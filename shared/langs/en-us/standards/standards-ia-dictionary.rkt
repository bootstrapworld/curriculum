#lang racket

(provide *iowa-standards-list*)

(require "standards-cc-ela-dictionary.rkt")
(require "standards-cc-math-dictionary.rkt")

(define (iowa-prefix std)
  (cons (string-append "IA." (first std))
        (rest std)))

(define *iowa-standards-list*
  `(
    ; prefix the Common Core Math and ELA standards
    ,@(map iowa-prefix *cc-math-standards-list*)
    ,@(map iowa-prefix *cc-ela-standards-list*)

    ; Iowa-Specific 21st Century Skills
    ("IA.21.6-8.ES.1"
     "Communicate and work productively with others, considering different perspectives, and cultural views to increase the quality of work."
     )
    ("IA.21.6-8.ES.2"
     "Adapt and adjust to various roles and responsibilities in an environment of change."
     )
    ("IA.21.6-8.ES.3"
     "Demonstrate leadership, integrity, ethical behavior, and social responsibility in all environments."
     )
    ("IA.21.6-8.ES.4"
     "Demonstrate initiative, self–direction, creativity, and entrepreneurial thinking while exploring individual talents and skills necessary to be successful."
     )
    ("IA.21.6-8.ES.5"
     "Demonstrate productivity and accountability while aspiring to meet high expectations."
     )
    ("IA.21.6-8.TL.1"
     "Demonstrate creative thinking in the design and development of innovative technology products and problem solving."
     )
    ("IA.21.6-8.TL.2"
     "Collaborate with peers, experts, and others using interactive technology."
     )
    ("IA.21.6-8.TL.3"
     "Plan strategies utilizing digital tools to gather, evaluate, and use information."
     )
    ("IA.21.6-8.TL.4"
     "Use critical thinking skills to conduct research, solve problems, and make informed decisions using appropriate technological tools and resources."
     )
    ("IA.21.6-8.TL.5"
     "Understand the legal and ethical issues of technology as related to individuals, cultures, and societies."
     )
    ("IA.21.6-8.TL.6"
     "Understand the underlying structure and application of technology systems."
     )
    ("IA.21.9-12.ES.1"
     "Communicate and work productively with others, incorporating different perspectives and cross cultural understanding, to increase innovation and the quality of work."
     )
    ("IA.21.9-12.ES.2"
     "Adapt to various roles and responsibilities and work flexibly in climates of ambiguity and changing priorities."
     )
    ("IA.21.9-12.ES.3"
     "Demonstrate leadership skills, integrity, ethical behavior, and social responsibility while collaborating to achieve common goals."
     )
    ("IA.21.9-12.ES.4"
     "Demonstrate initiative and self–direction through high achievement and lifelong learning while exploring the ways individual talents and skills can be used for productive outcomes in personal and professional life."
     )
    ("IA.21.9-12.ES.5"
     "Demonstrate productivity and accountability by meeting high expectations."
     )
    ("IA.21.9-12.TL.1"
     "Demonstrate creative thinking, construct knowledge, and develop innovative products and processes using technology."
     )
    ("IA.21.9-12.TL.2"
     "Use digital media and environments to communicate and work collaboratively, including at a distance, to support individual learning and contribute to the learning of others."
     )
    ("IA.21.9-12.TL.3"
     "Apply digital tools to gather, evaluate, and use information."
     )
    ("IA.21.9-12.TL.4"
     "Demonstrate critical thinking skills using appropriate tools and resources to plan and conduct research, manage projects, solve problems and make informed decisions."
     )
    ("IA.21.9-12.TL.5"
     "Understand human, cultural, and societal issues related to technology and practice legal and ethical behavior."
     )
    ("IA.21.9-12.TL.6"
     "Demonstrate a sound understanding of technology concepts, systems and operations."
     )


    ))

