#lang racket

(provide create-copyright)

(define (create-copyright name author)
  (format "~a de ~a
est sous licence
https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License].
Basé sur en travail sur https://www.bootstrapworld.org[www.BootstrapWorld.org].
Des autorisations dépassant le cadre de cette licence peuvent être disponibles
en contactant 
mailto:schanzer@BootstrapWorld.org." 
          name author
          ))
