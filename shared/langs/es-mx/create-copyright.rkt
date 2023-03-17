#lang racket

(provide create-copyright)

(define (create-copyright name)
  (format "~a por the https://bootstrapworld.org/community/index.shtml#Contributors[Comunidad Bootstrap] está licenciado bajo https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License]. Esta licencia no otorga permiso para ejecutar capacitación o desarrollo profesional. Ofrecer capacitación o desarrollo profesional con materiales derivados sustancialmente de Bootstrap debe ser aprobado por escrito por un Director de Bootstrap. Los permisos que excedan el alcance de esta licencia pueden estar disponibles poniéndose en contacto con mailto:contact@BootstrapWorld.org[contact@BootstrapWorld.org]." 
          name
          ))