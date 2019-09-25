#lang racket

(provide create-copyright)

(define (create-copyright name author)
  (format "~a por ~a
está licenciado bajo
https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License].
Basado en un trabajo en https://www.bootstrapworld.org[www.BootstrapWorld.org].
Los permisos que excedan el alcance de esta licencia pueden estar disponibles poniéndose
en contacto con
mailto:schanzer@BootstrapWorld.org." 
          name author
          ))
