#lang racket
(require racket/hash)
(require json)
(require "utils.rkt")

;; Inline quiz directives: @shortAnswer, @multipleChoice, @cardSort,
;; @categorize, @quizJSON, @checkpoint, @assessment.
;;
;; Design: https://github.com/bootstrapworld/curriculum/issues/2888
;;
;; preproc.rkt reads each directive's fixed-count {...} groups (via its own
;; read-group) and hands the raw group text to the handlers below, which
;; parse it, build a jsexpr question object, and append it to a running
;; list. @checkpoint{title} flushes that list to a quiz.json; @assessment
;; {title} concatenates every checkpoint seen so far into a second,
;; cumulative quiz.json. Nothing here touches ports or directive-expansion
;; internals, so it's independently testable without preproc.rkt's other
;; (heavier) dependencies.
;;
;; KNOWN v1 SIMPLIFICATIONS (documented rather than silently glossed over):
;; - Quiz text supports @image{path} / @image{path, size} (converted to
;;   Markdown, since quiz content is rendered by mdquiz's own Markdown
;;   renderer, not Asciidoctor) and AsciiDoc *bold* (converted to Markdown
;;   **bold**). Anything else -- nested custom directives, footnotes, etc.
;;   -- passes through literally. @quizJSON{} is the escape hatch for
;;   anything this doesn't cover.
;; - Image paths are written relative to the lesson (images/histoA.png);
;;   write-quiz-json! points them, from the quiz's own folder, at the
;;   lesson's (anonymized) image (see relink-images!). No alt-text lookup (unlike make-image in
;;   preproc.rkt): alt text is always empty, matching the existing
;;   quiz.json corpus's own convention (see e.g.
;;   histograms-cumulative/quiz.json's "![](./histoA.png)").
;; - CardSort card ids are a simple per-question counter ("card1", "card2",
;;   ...) rather than slugified content -- ids are only ever used internally
;;   to link an answer-key entry back to its card, never shown to students,
;;   so a counter is simpler and can't collide the way slugified content
;;   (especially image-only cards) could.
;; - Resolved on #2888: a lone @assessment{} with no preceding
;;   @checkpoint at all (a lesson with a single quiz, no intermediate
;;   checkins) needs no workaround -- see handle-cumulative-assessment!.

(provide reset-inline-quiz-state!
         set-pending-quiz-label!
         take-pending-quiz-label!
         handle-shortAnswer!
         handle-multipleChoice!
         handle-cardSort!
         handle-categorize!
         handle-quizJSON!
         handle-checkpoint!
         handle-cumulative-assessment!)

;; ---------------------------------------------------------------------
;; State: the running list of questions since the last @checkpoint (or the
;; start of the lesson), and every checkpoint's questions seen so far (for
;; @assessment to concatenate). Both reset per lesson.
;; ---------------------------------------------------------------------

(define *pending-questions* (box '()))          ; reverse order; newest first
(define *checkpoints-so-far* (box '()))         ; list of (title . questions), oldest first
(define *pending-label* (box #f))               ; label from preceding @quiz-label{...}
(define *written-slugs* (box '()))               ; (slug . 'checkpoint/'assessment) written so far, this lesson

(define (reset-inline-quiz-state!)
  (set-box! *pending-questions* '())
  (set-box! *checkpoints-so-far* '())
  (set-box! *pending-label* #f)
  (set-box! *written-slugs* '()))

;; @quiz-label{...} labels the next question. Returns the label it
;; displaced, if an earlier @quiz-label was never used, so preproc.rkt can
;; warn about it.
(define (set-pending-quiz-label! s)
  (begin0 (unbox *pending-label*)
    (set-box! *pending-label* (string-trim s))))

;; Clears and returns the pending label, if any: for preproc.rkt to drop a
;; skipped question's label (rather than let it attach to the next
;; question), and to catch one that no question followed.
(define (take-pending-quiz-label!)
  (begin0 (unbox *pending-label*)
    (set-box! *pending-label* #f)))

(define (add-question! q)
  (define label (take-pending-quiz-label!))
  (set-box! *pending-questions*
            (cons (if label (hash-set q 'label label) q)
                  (unbox *pending-questions*))))

;; ---------------------------------------------------------------------
;; Small helpers
;; ---------------------------------------------------------------------

(define (slugify s)
  (let* ([s (string-downcase (string-trim s))]
         [s (regexp-replace* #px"[^a-z0-9]+" s "-")]
         [s (regexp-replace #px"^-+" s "")]
         [s (regexp-replace #px"-+$" s "")])
    (if (string=? s "") "untitled" s)))

;; @image{path} or @image{path, size} -> Markdown image syntax.
;; size, when given, becomes the mdquiz-corpus convention "=WIDTHxWIDTH"
;; (a single number sets both dimensions, matching @image{}'s own usage
;; elsewhere in this codebase, e.g. @image{images/histoA.png, 110}).
(define (expand-image-calls s)
  (regexp-replace*
    #px"@image\\{([^},]+)(?:,\\s*([0-9]+))?\\}"
    s
    (lambda (whole path size)
      (if size
          (format "![](~a =~ax~a)" (string-trim path) size size)
          (format "![](~a)" (string-trim path))))))

;; AsciiDoc *bold* -> Markdown **bold**. Deliberately narrow (word-ish
;; content, no newlines) so it doesn't misfire on a bare literal asterisk.
(define (expand-bold s)
  (regexp-replace* #px"\\*([^*\n]+)\\*" s "**\\1**"))

;; AsciiDoc " +\n" (forced line break) -> bare "\n" for JSON consumers.
(define (expand-line-breaks s)
  (regexp-replace* #px" \\+\n" s "\n"))

;; quiz.json's "\n" (e.g. the corpus's "\n\n &nbsp; \n\n" spacer), as
;; authors carry it over from hand-written quizzes: a literal backslash-n
;; in the .adoc becomes a real newline. "\\n" stays a literal "\n".
(define (expand-escaped-newlines s)
  (regexp-replace* #px"\\\\(\\\\?)n" s
    (lambda (whole esc) (if (string=? esc "") "\n" "\\n"))))

;; The one text-conversion pass every piece of quiz content (prompts,
;; options, card/category items, answers) goes through.
(define (quiz-text s)
  (expand-bold (expand-image-calls (expand-line-breaks (expand-escaped-newlines (string-trim s))))))

;; ---------------------------------------------------------------------
;; AsciiDoc-list mini-parsers over already-extracted group text (raw
;; strings -- preproc.rkt's read-group has already found the closing brace
;; by the time any of this runs, so these are just line-oriented regexp
;; scans, not port-based parsing).
;; ---------------------------------------------------------------------

;; "- [ ] text" / "- [x] text" lines -> list of (checked? . text), in order.
(define (parse-checkbox-list body)
  (for/list ([line (string-split body "\n")]
             #:do [(define m (regexp-match #px"^\\s*-\\s*\\[([ xX])\\]\\s*(.*?)\\s*$" line))]
             #:when m)
    (cons (not (string=? (second m) " ")) (quiz-text (third m)))))

;; "Term::" starts a new group; "- item" lines belong to the most recent
;; group. Returns a list of (term . (item ...)), in order. Shared by
;; @cardSort (term discarded, just a pile marker) and @categorize (term
;; kept, it's a real student-facing label).
(define (parse-description-list body)
  (define groups (box '()))       ; (term . reversed-items), most recent first
  (for ([line (string-split body "\n")])
    (cond
      [(regexp-match #px"^(\\S.*)::\\s*$" line)
       => (lambda (m) (set-box! groups (cons (cons (string-trim (second m)) '()) (unbox groups))))]
      [(regexp-match #px"^\\s*-\\s*(.*?)\\s*$" line)
       => (lambda (m)
            (when (null? (unbox groups))
              (error 'inline-quiz "list item ~s appears before any \"Term::\" line" (second m)))
            (define top (car (unbox groups)))
            (set-box! groups (cons (cons (car top) (cons (quiz-text (second m)) (cdr top)))
                                    (cdr (unbox groups)))))]
      [(string=? (string-trim line) "") (void)]
      [else (error 'inline-quiz "unrecognized line in a term/item list: ~s" line)]))
  (reverse (for/list ([g (unbox groups)]) (cons (car g) (reverse (cdr g))))))

;; "", "0..360", "0..", "..360", ".." -> #f (no constraint) or a jsexpr
;; validation hash. Either side of ".." may be blank.
(define (parse-numeric-range s)
  (define trimmed (string-trim s))
  (cond
    [(string=? trimmed "") #f]
    [(regexp-match #px"^(-?[0-9]*)\\.\\.(-?[0-9]*)$" trimmed)
     => (lambda (m)
          (define lo (second m))
          (define hi (third m))
          (define h (hash 'numeric #t))
          (define h2 (if (string=? lo "") h (hash-set h 'min (string->number lo))))
          (if (string=? hi "") h2 (hash-set h2 'max (string->number hi))))]
    [else (error 'inline-quiz "malformed numeric range ~s; expected e.g. \"0..360\", \"0..\", \"..360\", or \"..\"" s)]))

;; ---------------------------------------------------------------------
;; Directive handlers. Each takes the already-read group strings (in
;; source order) and appends one jsexpr question to *pending-questions*.
;; ---------------------------------------------------------------------

;; @shortAnswer{required-flag}{numeric-range}{prompt}{answer}
(define (handle-shortAnswer! required-flag-str range-str prompt-str answer-str)
  (define required? (not (string=? (string-trim required-flag-str) "optional")))
  (define range (parse-numeric-range range-str))
  (define validation
    (let* ([h (hash 'required required?)])
      (if range (hash-union h range #:combine (lambda (a b) b)) h)))
  (add-question!
    (hash 'type "ShortAnswer"
          'prompt (hash 'prompt (quiz-text prompt-str) 'validation validation)
          'answer (hash 'answer (quiz-text answer-str)))))

;; @multipleChoice{order-mode}{prompt}{checkbox-list}
(define (handle-multipleChoice! order-mode-str prompt-str list-str)
  (define mode (string-downcase (string-trim order-mode-str)))
  (define items (parse-checkbox-list list-str))  ; (checked? . text), in written order
  (when (null? items)
    (error 'inline-quiz "@multiple-choice has no options"))
  (define answers (filter car items))
  (when (null? answers)
    (error 'inline-quiz "@multiple-choice has no option marked [x]"))
  (define answer-texts (map cdr answers))
  (define answer-value (if (= (length answer-texts) 1) (first answer-texts) answer-texts))
  (define base-prompt (hash 'prompt (quiz-text prompt-str)))
  (define prompt
    (cond
      [(string=? mode "fixed")
       (define first-answer-pos (for/first ([it items] [idx (in-naturals)] #:when (car it)) idx))
       (define distractors (map cdr (filter (lambda (it) (not (car it))) items)))
       (hash-set* base-prompt 'distractors distractors 'answerIndex first-answer-pos)]
      [(member mode '("" "sorted"))
       (hash-set* base-prompt 'distractors (map cdr (filter (lambda (it) (not (car it))) items))
                  'sortAnswers #t)]
      [(member mode '("shuffle" "random"))
       (hash-set base-prompt 'distractors (map cdr (filter (lambda (it) (not (car it))) items)))]
      [else (error 'inline-quiz "@multiple-choice's order-mode must be empty, sorted, shuffle, random, or fixed; got ~s" order-mode-str)]))
  (add-question!
    (hash 'type "MultipleChoice" 'prompt prompt 'answer (hash 'answer answer-value))))

;; @cardSort{ordered-flag}{prompt}{description-list}
(define (handle-cardSort! ordered-flag-str prompt-str list-str)
  (define ordered? (string=? (string-downcase (string-trim ordered-flag-str)) "ordered"))
  (define groups (parse-description-list list-str))  ; term discarded below, just a pile marker
  (define counter (box 0))
  (define (next-id!) (set-box! counter (add1 (unbox counter))) (format "card~a" (unbox counter)))
  (define id-groups
    (for/list ([g groups]) (for/list ([item (cdr g)]) (cons (next-id!) item))))
  (define all-cards (append* id-groups))
  (add-question!
    (hash 'type "CardSort"
          'prompt (hash 'prompt (quiz-text prompt-str)
                        'cards (for/list ([c all-cards]) (hash 'id (car c) 'content (cdr c))))
          'answer (hash 'answer (for/list ([g id-groups]) (map car g))
                        'ordered ordered?))))

;; @categorize{prompt}{description-list}
(define (handle-categorize! prompt-str list-str)
  (define groups (parse-description-list list-str))  ; term kept -- it's a real leftColumn label
  (add-question!
    (hash 'type "Categorize"
          'prompt (hash 'prompt (quiz-text prompt-str)
                        'leftColumn (map car groups)
                        'rightColumn (append* (map cdr groups)))
          ; jsexpr object keys must be symbols, not strings, per Racket's
          ; json library -- these come from arbitrary author-written terms.
          'answer (for/hash ([g groups]) (values (string->symbol (car g)) (cdr g))))))

;; @quizJSON{ raw JSON object }
(define (handle-quizJSON! json-str)
  (add-question! (string->jsexpr json-str)))

;; ---------------------------------------------------------------------
;; @checkpoint{title} / @assessment{title}
;; ---------------------------------------------------------------------

;; Writes {title, questions} to <dir>/assessments/<slug>/quiz.json.
;; slug is derived from the raw author title (without the "Show what you know:" prefix).
(define (write-quiz-json! dir slug title questions)
  (define assessment-dir (build-path dir "assessments" slug))
  (make-directory* assessment-dir)
  (define relinked-questions (relink-images! dir questions))
  (call-with-output-file (build-path assessment-dir "quiz.json")
    #:exists 'replace
    (lambda (o) (write-json (hash 'title title 'questions relinked-questions) o)))
  slug)

;; Quiz text references images by lesson-relative path (e.g.
;; images/histoA.png, from @image{}), but the quiz page lives two levels
;; down, in assessments/<slug>/. So point the Markdown at ../../<path>,
;; using the anonymized name -- renaming the lesson's image to it now if
;; that hasn't happened yet, just as make-image in preproc.rkt does for an
;; ordinary @image (so a filename can't give away an answer). ./ and ../
;; paths and URLs are left as written.
(define (relink-images! dir questions)
  (define (relink s)
    (regexp-replace* #px"!\\[([^\\]]*)\\]\\(([^) ]+)" s
      (lambda (whole alt path)
        (define anon (anonymize-filename path))
        (define src-qn (build-path dir path))
        (define anon-qn (build-path dir anon))
        (cond [(regexp-match? #px"^(\\.\\.?/|/|[a-z]+:)" path) whole]
              [(or (file-exists? anon-qn)
                   (and (file-exists? src-qn)
                        (begin (rename-file-or-directory src-qn anon-qn #t) #t)))
               (format "![~a](../../~a" alt (path->string anon))]
              [else (printf "WARNING: ~a: quiz image ~a not found\n\n" dir path)
                    whole]))))
  (let walk ([x questions])
    (cond [(string? x) (relink x)]
          [(list? x) (map walk x)]
          [(hash? x) (for/hasheq ([(k v) (in-hash x)]) (values k (walk v)))]
          [else x])))

;; "Show what you know: X Checkpoint" / "Show what you know: X (Cumulative)"
(define (checkpoint-display-title raw)
  (string-append "Show what you know: " raw " Checkpoint"))
(define (assessment-display-title raw)
  (string-append "Show what you know: " raw " (Cumulative)"))

;; dir is the lesson's own output directory (preproc.rkt's
;; *containing-directory*), passed in explicitly rather than required back
;; from preproc.rkt, to keep this module a leaf dependency.
;; Two @checkpoint/@assessment titles in one lesson that slugify alike would
;; write the same assessments/<slug>/ folder, the later silently replacing
;; the earlier. Instead, keep the earlier one and report the clash: returns
;; #t (writing nothing) if slug was already written in this lesson.
;; Exception: the same @assessment mentioned again (e.g., offered mid-lesson
;; and again at the end) is one cumulative quiz, not a clash -- rewrite it,
;; since the later mention has collected every question so far.
(define (write-quiz-json-unless-duplicate! dir kind slug title questions)
  (define earlier-kind (cond [(assoc slug (unbox *written-slugs*)) => cdr] [else #f]))
  (cond
    [(and earlier-kind (not (and (eq? kind 'assessment) (eq? earlier-kind 'assessment)))) #t]
    [else
     (write-quiz-json! dir slug title questions)
     (unless earlier-kind
       (set-box! *written-slugs* (cons (cons slug kind) (unbox *written-slugs*))))
     #f]))

;; Returns (list slug display-title duplicate?): the assessments/ folder it
;; wrote (or, if duplicate?, would have written, had an earlier one in this
;; lesson not already claimed it), and the title -- for preproc.rkt to
;; register in the lesson's Assessments list, emit a backlink, and warn on a
;; duplicate. A duplicate's questions still count toward the cumulative
;; @assessment; only its own quiz.json is skipped.
(define (handle-checkpoint! dir title-str)
  (define raw (string-trim title-str))
  (define title (checkpoint-display-title raw))
  (define slug (slugify raw))
  (define questions (reverse (unbox *pending-questions*)))
  (when (null? questions)
    (error 'inline-quiz "@checkpoint{~a} has no preceding questions to collect" raw))
  (define duplicate? (write-quiz-json-unless-duplicate! dir 'checkpoint slug title questions))
  (set-box! *checkpoints-so-far* (cons (cons title questions) (unbox *checkpoints-so-far*)))
  (set-box! *pending-questions* '())
  (list slug title duplicate?))

;; Resolved on #2888 (comment thread, schanzer/flannery-denny): a lone
;; @assessment{} with no preceding @checkpoint at all -- the
;; common one-lesson-one-quiz case -- should not require a redundant
;; @checkpoint{} immediately before it just to flush the pending list.
;; @assessment{} sweeps up any still-pending (un-checkpointed)
;; questions itself, in addition to every @checkpoint's questions so far.
;; Returns (list slug display-title duplicate?), as handle-checkpoint! does.
(define (handle-cumulative-assessment! dir title-str)
  (define raw (string-trim title-str))
  (define title (assessment-display-title raw))
  (define slug (slugify raw))
  (define checkpoints (reverse (unbox *checkpoints-so-far*)))
  (define pending (reverse (unbox *pending-questions*)))
  (define all-questions (append (append* (map cdr checkpoints)) pending))
  (when (null? all-questions)
    (error 'inline-quiz "@assessment{~a} has no preceding questions (from @checkpoint or otherwise) to collect" raw))
  (set-box! *pending-questions* '())
  (define duplicate? (write-quiz-json-unless-duplicate! dir 'assessment slug title all-questions))
  (list slug title duplicate?))
