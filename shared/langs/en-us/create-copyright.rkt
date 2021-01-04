#lang racket

(provide create-copyright)

(define (create-copyright name)
  (format "~a by the https://bootstrapworld.org/community/index.shtml#Contributors[Bootstrap Community] is licensed under a https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License]. This license does not grant permission to run training or professional development. Offering training or professional development with materials substantially derived from Bootstrap must be approved in writing by a Bootstrap Director. Permissions beyond the scope of this license, such as to run training, may be available by contacting mailto:contact@BootstrapWorld.org[contact@BootstrapWorld.org]. "
          name
          ))