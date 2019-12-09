#lang racket

(provide
  topologically-sort)

(define (topologically-sort deps)
  (let* ([all-items (remove-duplicates (apply append deps))]
         [num-items (length all-items)]
         [item-graph (make-vector num-items)])
    (for ([i num-items])
      (vector-set! item-graph i (vector '() 'not-yet)))
    (for ([dep deps])
      (let* ([me (car dep)]
             [my-befores (cdr dep)]
             [my-index (index-of all-items me)]
             [my-befores-indices (map (lambda (it)
                                        (index-of all-items it))
                                      my-befores)])
        (vector-set!
          (vector-ref item-graph my-index) 0 my-befores-indices)))
    (let ([r '()])
      (letrec ([consider (lambda (i)
                           (let* ([me (vector-ref item-graph i)]
                                  [my-befores (vector-ref me 0)]
                                  [my-status (vector-ref me 1)])
                             (case my-status
                               [(not-yet) (vector-set! me 1 'wip)
                                          (for-each consider my-befores)
                                          (set! r (cons (list-ref all-items i) r))
                                          (vector-set! me 1 'done)]
                               [(wip) (printf "WARNING: Cyclic dependency involving ~s in ~s\n"
                                              (list-ref all-items i)
                                              deps)]
                               [else (void)])))])
        (for ([i num-items])
          (consider i))
        (reverse r)))))
