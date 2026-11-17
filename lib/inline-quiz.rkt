#lang racket
(require racket/hash)
(require json)
(require "utils.rkt")

;; Inline quiz directives: @shortAnswer, @multipleChoice, @cardSort,
;; @categorize, @quizJSON, @checkpoint, @assessment, and a course page's
;; @course-checkpoint, @course-assessment.
;;
;; Design: https://github.com/bootstrapworld/curriculum/issues/2888
;;
;; preproc.rkt reads each directive's fixed-count {...} groups (via its own
;; read-group) and hands the raw group text to the handlers below, which
;; parse it, build a jsexpr question object, and append it to a running
;; list. @checkpoint{title} flushes that list to a quiz; @assessment
;; {title} concatenates every checkpoint seen so far into a second,
;; cumulative quiz. At the end of the lesson, write-inline-quizzes! writes
;; each quiz's quiz.json. Nothing here touches ports or directive-expansion
;; internals (preproc.rkt hands in its directive expander), so it's
;; independently testable without preproc.rkt's other (heavier)
;; dependencies.
;;
;; Quiz text (prompts, options, cards, categories) is AsciiDoc, like the
;; rest of the lesson: its directives are expanded by preproc.rkt as usual
;; (so e.g. @image{} gets its anonymized filename, and its alt text from
;; lesson-images.json's quiz-description rather than description), and
;; write-inline-quizzes! converts it to HTML with Asciidoctor -- one run for
;; all of a lesson's quizzes -- so quiz.json carries HTML, which
;; swyk-client passes through as is. Exceptions: ShortAnswer's answer key
;; stays plain text, since it's compared against what the student types;
;; and @quizJSON{} questions are written exactly as given.
;;
;; KNOWN v1 SIMPLIFICATIONS (documented rather than silently glossed over):
;; - Of the lesson pipeline's post-Asciidoctor fixups (do-postproc.lua),
;;   only its directive-placeholder conversions (%CURRICULUM...%) are
;;   repeated here (see finish-quiz-html). Directives that rely on more
;;   (e.g., math, which needs MathJax on the page) won't render in quizzes.
;; - CardSort card ids are a simple per-question counter ("card1", "card2",
;;   ...) rather than slugified content -- ids are only ever used internally
;;   to link an answer-key entry back to its card, never shown to students,
;;   so a counter is simpler and can't collide the way slugified content
;;   (especially image-only cards) could.
;; - Resolved on #2888: a lone @assessment{} with no preceding
;;   @checkpoint at all (a lesson with a single quiz, no intermediate
;;   checkins) needs no workaround -- see handle-cumulative-assessment!.

(provide reset-inline-quiz-state!
         set-quiz-text-expander!
         write-inline-quizzes!
         set-pending-quiz-label!
         take-pending-quiz-label!
         handle-shortAnswer!
         handle-multipleChoice!
         handle-cardSort!
         handle-categorize!
         handle-quizJSON!
         handle-checkpoint!
         handle-cumulative-assessment!
         handle-course-checkpoint!
         handle-course-assessment!)

;; ---------------------------------------------------------------------
;; State: the running list of questions since the last @checkpoint (or the
;; start of the lesson), and every checkpoint's questions seen so far (for
;; @assessment to concatenate). Both reset per lesson.
;; ---------------------------------------------------------------------

(define *pending-questions* (box '()))          ; reverse order; newest first
(define *checkpoints-so-far* (box '()))         ; list of (title . questions), oldest first
(define *pending-label* (box #f))               ; label from preceding @quiz-label{...}
(define *written-slugs* (box '()))               ; (slug . 'checkpoint/'assessment) written so far, this lesson
(define *quizzes-to-write* (box '()))           ; (list dir slug title questions), newest first

(define (reset-inline-quiz-state!)
  (set-box! *pending-questions* '())
  (set-box! *checkpoints-so-far* '())
  (set-box! *pending-label* #f)
  (set-box! *written-slugs* '())
  (set-box! *quizzes-to-write* '()))

;; preproc.rkt's expand-directives:string->string, which quiz-text runs
;; every piece of quiz text through. Identity until preproc.rkt sets it.
(define *quiz-text-expander* (box values))

(define (set-quiz-text-expander! f)
  (set-box! *quiz-text-expander* f))

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

;; quiz.json's "\n" (e.g. the corpus's "\n\n &nbsp; \n\n" spacer), as
;; authors carry it over from hand-written quizzes: a literal backslash-n
;; in the .adoc becomes a real newline. "\\n" stays a literal "\n".
(define (expand-escaped-newlines s)
  (regexp-replace* #px"\\\\(\\\\?)n" s
    (lambda (whole esc) (if (string=? esc "") "\n" "\\n"))))

;; Indentation isn't significant in quiz text: authors indent continuation
;; lines, and the "\n\n &nbsp; \n\n" spacer above leaves a line starting
;; with a space -- either of which AsciiDoc would otherwise turn into a
;; literal (preformatted) paragraph.
(define (unindent s)
  (regexp-replace* #px"(?m:^[ \t]+)" s ""))

;; A piece of quiz text, as AsciiDoc with its directives already expanded,
;; awaiting write-inline-quizzes!'s conversion to HTML.
(struct qtext (adoc))

;; Categorize's answer key: a list of (category . items), all qtexts. Kept
;; as a list until conversion, since the jsexpr it becomes is keyed by the
;; categories' (converted) text.
(struct categorize-answer (groups))

;; The one text-conversion pass every piece of quiz content (prompts,
;; options, card/category items) goes through.
(define (quiz-text s)
  (qtext ((unbox *quiz-text-expander*) (unindent (expand-escaped-newlines (string-trim s))))))

;; Text that stays plain: ShortAnswer's answer key, which swyk-client
;; compares against what the student types and shows as is.
(define (plain-text s)
  (expand-escaped-newlines (string-trim s)))

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
          'answer (hash 'answer (plain-text answer-str)))))

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
  (define groups  ; term kept -- it's a real leftColumn label
    (for/list ([g (parse-description-list list-str)])
      (cons (quiz-text (car g)) (cdr g))))
  (add-question!
    (hash 'type "Categorize"
          'prompt (hash 'prompt (quiz-text prompt-str)
                        'leftColumn (map car groups)
                        'rightColumn (append* (map cdr groups)))
          'answer (categorize-answer groups))))

;; @quizJSON{ raw JSON object }
(define (handle-quizJSON! json-str)
  (add-question! (string->jsexpr json-str)))

;; ---------------------------------------------------------------------
;; @checkpoint{title} / @assessment{title}
;; ---------------------------------------------------------------------

;; Writes {title, questions} to <dir>/assessments/<slug>/quiz.json.
;; slug is derived from the raw author title (without the "Show what you know:" prefix),
;; unless a folder=NAME option gives it.
(define (write-quiz-json! dir slug title questions)
  (define assessment-dir (build-path dir "assessments" slug))
  (make-directory* assessment-dir)
  (define relinked-questions (relink-images! dir questions))
  (call-with-output-file (build-path assessment-dir "quiz.json")
    #:exists 'replace
    (lambda (o) (write-json (hash 'title title 'questions relinked-questions) o)))
  slug)

;; Called by preproc.rkt at the end of the lesson plan: converts the quiz
;; text of every quiz the lesson collected to HTML, in one Asciidoctor run,
;; and writes each quiz.json. dist-root-dir is the lesson's own path to the
;; distribution root.
(define (write-inline-quizzes! dist-root-dir)
  (define quizzes (reverse (unbox *quizzes-to-write*)))
  (set-box! *quizzes-to-write* '())
  (unless (null? quizzes)
    (define dir (first (first quizzes)))
    (define texts (remove-duplicates (collect-quiz-texts (map fourth quizzes))))
    (define html-of
      (for/hash ([t texts] [h (quiz-texts->html dir dist-root-dir texts)])
        (values t h)))
    (for ([q quizzes])
      (match-define (list dir slug title questions) q)
      (write-quiz-json! dir slug title (resolve-quiz-texts questions html-of)))))

;; Every qtext's AsciiDoc, in order, duplicates and all.
(define (collect-quiz-texts x)
  (cond [(qtext? x) (list (qtext-adoc x))]
        [(categorize-answer? x) (collect-quiz-texts (categorize-answer-groups x))]
        [(pair? x) (append (collect-quiz-texts (car x)) (collect-quiz-texts (cdr x)))]
        [(hash? x) (append* (map collect-quiz-texts (hash-values x)))]
        [else '()]))

;; The questions as jsexpr, each qtext replaced by its HTML.
(define (resolve-quiz-texts x html-of)
  (define (resolve x) (resolve-quiz-texts x html-of))
  (cond [(qtext? x) (hash-ref html-of (qtext-adoc x))]
        ; jsexpr object keys must be symbols, not strings, per Racket's
        ; json library -- these come from arbitrary author-written terms.
        [(categorize-answer? x)
         (for/hash ([g (categorize-answer-groups x)])
           (values (string->symbol (resolve (car g))) (map resolve (cdr g))))]
        [(list? x) (map resolve x)]
        [(hash? x) (for/hasheq ([(k v) (in-hash x)]) (values k (resolve v)))]
        [else x]))

;; Asciidoctor's output for the texts is split back into one piece per text
;; at these markers, passed through between the texts.
(define quiz-text-separator "<!--QUIZTEXT-->")

;; texts (AsciiDoc strings) -> their HTML, in the same order. The quiz page
;; lives two levels below the lesson, in assessments/<slug>/, so image
;; paths, written relative to the lesson, get ../../ (imagesdir), as do
;; links relative to the distribution root (fromlangroot). If Asciidoctor
;; fails, or its output doesn't split back into one piece per text (as an
;; unclosed delimited block in one text, swallowing the following markers,
;; would cause), warns and returns the texts unconverted.
(define (quiz-texts->html dir dist-root-dir texts)
  (define marker (string-append "\n++++\n" quiz-text-separator "\n++++\n\n"))
  (define doc
    (string-append (string-append* (for/list ([t texts]) (string-append marker t "\n")))
                   marker))
  (define-values (html errors ok?)
    (run-asciidoctor doc (list "-a" "imagesdir=../.."
                               "-a" (string-append "fromlangroot=../../" dist-root-dir))))
  (unless (string=? (string-trim errors) "")
    (printf "WARNING: ~a: Asciidoctor, converting quiz text:\n~a\n" dir (string-trim errors)))
  ; Drop what precedes the first marker and follows the last.
  (define pieces (string-split html quiz-text-separator #:trim? #f))
  (cond
    [(and ok? (= (length pieces) (+ (length texts) 2)))
     (map finish-quiz-html (drop-right (cdr pieces) 1))]
    [else
     (printf "WARNING: ~a: couldn't convert quiz text to HTML (is a delimited block left unclosed?) -- using it as is\n\n" dir)
     texts]))

;; Runs Asciidoctor on doc (stdin to stdout, body only). Returns its
;; output, its error output, and whether it succeeded.
(define (run-asciidoctor doc args)
  (define exe (find-executable-path "asciidoctor"))
  (cond
    [(not exe) (values "" "asciidoctor not found" #f)]
    [else
     (define-values (sp out in err)
       (apply subprocess #f #f #f exe (append args (list "-s" "-o" "-" "-"))))
     (define errors "")
     (define err-reader (thread (lambda () (set! errors (port->string err)))))
     (define writer (thread (lambda () (write-string doc in) (close-output-port in))))
     (define html (port->string out))
     (thread-wait writer)
     (thread-wait err-reader)
     (subprocess-wait sp)
     (close-input-port out)
     (close-input-port err)
     (values html errors (zero? (subprocess-status sp)))]))

;; One text's HTML, with the directive placeholders preproc.rkt leaves for
;; do-postproc.lua converted the way it converts them. A text that is a
;; single paragraph becomes just its <p> -- the shape a Markdown-rendered
;; text had, which swyk-client's styles (and build-mdquiz's) expect.
(define (finish-quiz-html s)
  (let* ([s (string-trim s)]
         [s (regexp-replace* #rx"%CURRICULUMMATHJAXMARKER%" s "$$")]
         [s (regexp-replace* #rx"%CURRICULUMCOMMENTSTART%" s "<!--")]
         [s (regexp-replace* #rx"%CURRICULUMCOMMENTSTOP%" s "-->")]
         [s (regexp-replace* #rx"%CURRICULUMLT%" s "<")]
         [s (regexp-replace* #rx"%CURRICULUMGT%" s ">")]
         [s (regexp-replace* #rx"%CURRICULUM([^%]*)%" s "<\\1")]
         [s (regexp-replace* #rx"%BEGINCURRICULUM([^%]*)%" s ">")]
         [s (regexp-replace* #rx"%ENDCURRICULUM([^%]*)%" s "</\\1>")]
         [s (regexp-replace* #rx"&#8656;" s "\\&lt;=")]
         [s (regexp-replace* #rx"&#8594;" s "-\\&gt;")])
    (cond [(and (= (length (regexp-match* #rx"<div" s)) 1)
                (regexp-match #px"^<div class=\"paragraph\">\n(<p>.*</p>)\n</div>$" s))
           => second]
          [else s])))

;; Quiz text references images by lesson-relative path (e.g.
;; images/histoA.png), but the quiz page lives two levels down, in
;; assessments/<slug>/. Converted quiz text already accounts for that (see
;; quiz-texts->html); this is for Markdown images in @quizJSON{} questions.
;; Point them at ../../<path>,
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

;; @course-checkpoint's and @course-assessment's second argument: the
;; assessments/ folder to write to (e.g. student-pre, to keep an existing
;; quiz's URL), rather than one slugified from the title.
(define (check-folder-name directive folder-str)
  (define name (string-trim folder-str))
  (unless (regexp-match? #px"^[a-z0-9]+(-[a-z0-9]+)*$" name)
    (error 'inline-quiz "@~a: folder ~s must be lowercase letters, digits and single hyphens, e.g. student-pre" directive name))
  name)

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
     ; Queued for write-inline-quizzes!; a rewrite replaces the earlier one.
     (set-box! *quizzes-to-write*
               (cons (list dir slug title questions)
                     (filter (lambda (q) (not (equal? (second q) slug)))
                             (unbox *quizzes-to-write*))))
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
  (checkpoint! dir "checkpoint" raw (checkpoint-display-title raw) (slugify raw)))

;; @course-checkpoint{title}{folder}: a course page's quiz -- the title as
;; written, in assessments/<folder>/.
(define (handle-course-checkpoint! dir title-str folder-str)
  (define raw (string-trim title-str))
  (checkpoint! dir "course-checkpoint" raw raw (check-folder-name "course-checkpoint" folder-str)))

(define (checkpoint! dir directive raw title slug)
  (define questions (reverse (unbox *pending-questions*)))
  (when (null? questions)
    (error 'inline-quiz "@~a{~a} has no preceding questions to collect" directive raw))
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
  (assessment! dir "assessment" raw (assessment-display-title raw) (slugify raw)))

;; @course-assessment{title}{folder}: likewise, for a cumulative quiz.
(define (handle-course-assessment! dir title-str folder-str)
  (define raw (string-trim title-str))
  (assessment! dir "course-assessment" raw raw (check-folder-name "course-assessment" folder-str)))

(define (assessment! dir directive raw title slug)
  (define checkpoints (reverse (unbox *checkpoints-so-far*)))
  (define pending (reverse (unbox *pending-questions*)))
  (define all-questions (append (append* (map cdr checkpoints)) pending))
  (when (null? all-questions)
    (error 'inline-quiz "@~a{~a} has no preceding questions (from a checkpoint or otherwise) to collect" directive raw))
  (set-box! *pending-questions* '())
  (define duplicate? (write-quiz-json-unless-duplicate! dir 'assessment slug title all-questions))
  (list slug title duplicate?))
