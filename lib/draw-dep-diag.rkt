#lang racket

(require "topsort.rkt")
(require "html-tag-gen.rkt")

(provide
  draw-dependency-diagram)

(define (lesson->title lesson)
  (let ([lesson-title lesson]
        [lesson-title-file (format "./lessons/~a/index-title.txt" lesson)])
    (when (file-exists? lesson-title-file)
      (set! lesson-title (call-with-input-file lesson-title-file read-line)))
    lesson-title))

(define (lesson->plan lesson)
  (format "./lessons/~a/index.html" lesson))

(define (create-dependency-graph lessons)
  ;(printf "create-dependency-graph of ~s\n" lessons)
  (let ([deps '()])
    (for ([lesson lessons])
      (let ([lesson-deps-file (format "./lessons/~a/index-dependencies.txt" lesson)]
            [lesson-deps '()])
        (when (file-exists? lesson-deps-file)
          (set! lesson-deps (call-with-input-file lesson-deps-file read)))
        (set! deps (cons (cons lesson lesson-deps) deps))))
    (reverse deps)))

(define *svg-dx* 200)
(define *svg-dy* 150)
(define *text-x0* 40)
(define *text-y0* 40)
(define *text-dy* 40)
(define *arrow-dx* 10)
(define *arrow-padding-dx* 10)
(define *arrow-head-dx* 5)
(define *arrow-padding-dy* 5)

(define (text-y i)
  (+ *text-y0* (* i *text-dy*)))

(define (draw-dependency-diagram lessons o)

  (let* ([deps (create-dependency-graph lessons)]
         [tsorted-lessons (topologically-sort deps)]
         [num-lessons (length tsorted-lessons)])
    ;(printf "deps= ~s\n" deps)

    (set! *svg-dx* (+ 500 40 (* num-lessons 15)))
    (set! *svg-dy* (+ 20 (* num-lessons 40)))
    (set! *text-x0* (+ 40 (* num-lessons 15)))

    (display 
      (enclose-tag "svg" "" 
        #:attribs (format "width=\"~a\" height=\"~a\"" *svg-dx* *svg-dy*)
        (string-append
          (enclose-tag "defs" ""
            (enclose-tag "marker" ""
              #:attribs "id=\"arrow\" markerWidth=\"10\" markerHeight=\"10\" refX=\"0\" refY=\"3\" orient=\"auto\" markerUnits=\"strokeWidth\""
              (enclose-tag "path" ""
                #:attribs "d=\"M0,0 L0,6 L9,3 z\" fill=\"#000\""
                "")))
          (string-join
            (map (lambda (lsn)
                   (let ([i (index-of tsorted-lessons lsn)])
                     (enclose-tag "a" ""
                       #:attribs (format "xlink:href=\"~a\"" 
                                         (lesson->plan lsn))
                       (enclose-tag "text" ""
                         #:attribs (format "x=\"~a\" y=\"~a\"" 
                                           *text-x0*
                                           (text-y i))
                         (lesson->title lsn)))))
                 tsorted-lessons) "\n")
          (string-join 
            (apply append
                   (map (lambda (dep)
                          (let* ([me (car dep)] 
                                 [others (cdr dep)]
                                 [i (index-of tsorted-lessons me)])
                            ;(printf "me=~s others=~s i= ~s deps=~s\n" me others i deps)
                            (map (lambda (it)
                                   (let ([j (index-of tsorted-lessons it)]) 
                                     ;(printf "me=~s i=~a j=~a\n" me i j)
                                     (if (> i j)
                                         (let ([i-j (- i j)])
                                           (enclose-tag "polyline" ".svg-polyline" 
                                             #:attribs
                                             (format "marker-end=\"url(#arrow)\" points=\"~a,~a ~a,~a ~a,~a ~a,~a\""
                                                     (- *text-x0* *arrow-padding-dx*) 
                                                     (- (text-y j) *arrow-padding-dy*)
                                                     (- *text-x0* *arrow-padding-dx* (* i-j *arrow-dx*))
                                                     (- (text-y j) *arrow-padding-dy*)
                                                     (- *text-x0* *arrow-padding-dx* (* i-j *arrow-dx*))
                                                     (- (text-y i) *arrow-padding-dy*)
                                                     (- *text-x0* *arrow-padding-dx* *arrow-head-dx*)
                                                     (- (text-y i) *arrow-padding-dy*))
                                             ""))
                                         "")))
                                 others)
                            ))
                        deps))
            "\n")))
      o)
    (display "\n\n" o)))



