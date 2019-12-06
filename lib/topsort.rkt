#lang racket

(provide 
  topologically-sort)

(define (topologically-sort deps)
  (let* ([all-items (remove-duplicates (apply append deps))]
         [num-items (length all-items)]
         [item-graph (make-vector num-items)])
    (let loop ([i 0])
      (unless (>= i num-items)
        (vector-set! item-graph i (vector '() #f))
        (loop (+ i 1))))
    (for-each (lambda (dep)
                (let* ([me (car dep)]
                       [my-befores (cdr dep)]
                       [my-index (index-of all-items me)]
                       [my-befores-indices (map (lambda (it)
                                                  (index-of all-items it))
                                                my-befores)])
                  (vector-set! 
                    (vector-ref item-graph my-index) 0 my-befores-indices)))
              deps)
    (let ([r '()])
      (letrec ([consider (lambda (i)
                           (let* ([me (vector-ref item-graph i)]
                                  [my-befores (vector-ref me 0)]
                                  [im-done? (vector-ref me 1)])
                             ;TODO: we don't stop show for cyclic dependency
                             ;but perhaps warning?
                             (unless im-done?
                               (vector-set! me 1 #t)
                               (for-each consider my-befores)
                               (set! r (cons (list-ref all-items i) r)))))])
        (let loop ([i 0])
          (unless (>= i num-items)
            (consider i)
            (loop (+ i 1))))
        (reverse r)))))
