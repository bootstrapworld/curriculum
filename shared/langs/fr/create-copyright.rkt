#lang racket

(provide create-copyright)

(define (create-copyright name)
  (format "~a de the https://bootstrapworld.org/community/index.shtml[Communauté Bootstrap] est sous licence https://creativecommons.org/licenses/by-nc-nd/4.0/[Creative Commons 4.0 Unported License]. Cette licence n'accorde pas l'autorisation d'organiser une formation ou un développement professionnel. Offrir une formation ou un développement professionnel avec des matériaux essentiellement dérivés de Bootstrap doit être approuvé par écrit par un directeur Bootstrap. Des autorisations dépassant le cadre de cette licence peuvent être disponibles
en contactant mailto:contact@BootstrapWorld.org." 
          name
          ))