#lang racket

(provide create-copyright)

(define (create-copyright name author)
  (format "~n~n'''~n~a by ~a
is licensed under a 
https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License].
Based on a work at https://www.bootstrapworld.org[www.BootstrapWorld.org].
Permissions beyond the scope of this license may be available by contacting
mailto:schanzer@BootstrapWorld.org[schanzer@BootstrapWorld.org]." 
          name author
          ))
