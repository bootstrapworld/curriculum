#lang racket

;FIXME what wd be the canonical location of this file?
;      the pathway top dir?

(provide *lessons-and-textbooks*)

(define *lessons-and-textbooks*)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CORE

    ("contracts" 
        "IM.6.6.16"
	"IM.6.6.17"
	"IM.6.6.18"
	"IM.7.2.4"
	"IM.7.2.5"
	"IM.7.2.6"
	"IM.8.5.1"
	"IM.8.5.2"
	)

    ("defining-functions" 
        "IM.8.5.3"
	)

    ("defining-values"
        "CMP.6.6" 
        "IM.6.6.2"
	"IM.7.6.11"
	)

    ("simple-dataypes" 
	"IM.6.7.8"
	"IM.6.7.9"
	"IM.6.7.10"
	"IM.7.6.13"
	) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MATH
   
    ("combinatorics-permutation"
        "HSS.CP.B.9"
            )

    ("combinatorics-combination"
        "HSS.CP.B.9"
        )

    ("coordinates"
        "IA.5.G.A.1" 
        "5.G.A.1"
	"IM.8.1.1"
        )

    ("distance-formula" 
        "CMP.8.2"
        "IM.8.8.6"
	"IM.8.8.7"
	"IM.8.8.8"
	"IM.8.8.10"
	)

    ("flags" 
	"IM.6.2.14"
	"IM.6.1.3"
	"IM.6.7.14"
	"IM.6.7.15"
        "IM.7.4.1"
	"IM.7.1.1"
	"IM.7.1.5"
	"IM.8.1.1
	"IM.8.1.2"
	"IM.8.1.3"
	"IM.8.2.1"
	) 

    ("function-composition" 
        )

    ("functions-for-character-animation" 
	"IM.6.6.6"
	"IM.6.3.8"
	"IM.8.3.11"
        )

    ("inequalities-collision"
        "IM.8.8.11"
	)

    ("inequalities1-simple"
        "IM.6.7.8"
	"IM.6.7.9
	"IM.6.7.10"
	)

    ("inequalities2-compound" 
        )

    ("inequalities3-sam"
	"IM.6.7.10"
	"IM.7.6.17"
	)    

    ("making-game-images" 
        "IM.6.5.5"
	"IM.7.1.1"
	"IM.7.1.5"
	"IM.8.1.1"
	"IM.8.1.2"
	"IM.8.1.3"
	"IM.8.2.1"
	)

    ("numbers-inside-videogames" 
        "IM.6.7.11"
	"IM.6.7.12"
	"IM.8.1.1"
	"IM.Alg1.1.1" ; Converted dashes to dots
	)

    ("order-of-operations" 
        "CMP.6.1"
        "CMP.7.2"
	"IM.6.6.13"
	"IM.6.6.14"
	"IM.6.6.15"
	"IM.7.5.13"
	"IM.7.5.14"
	"IM.8.7.7"
        )

    ("piecewise-functions" 
        "CMP.Alg-Ext.2"
	"IM.8.5.10"
        )

    ("player-animation" 
        "IM.8.5.10"
	)      

    ("problem-decomposition"
        "IM.6.6.8"
	)
        
    ("restating-the-problem" 
        "IM.8.5.3"
	)

    ("solving-word-problems" 
	"IM.7.2.3"
	"IM.8.5.3"
        )

    ("surface-area-rect-prism"
        "CMP.6.4"
        "CMP.7.7"
	"IM.6.1.12"
	"IM.6.1.13"
	"IM.6.1.14"
	"IM.6.1.15"
	"IM.7.7.14"
        )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATA SCIENCE
    
    ("checking-your-work" 
        )

    ("choosing-your-dataset" 
        )

    ("correlations" 
        "CMP.8.1"
	"IM.8.6.4"
	"IM.8.6.5"
        )
    
    ("defining-table-functions" 
        "IM.8.5.3"
	)

    ("displays-and-lookups" 
        "IM.8.6.9"
	)

    ("ds-intro" 
	"IM.6.8.1"
	"IM.6.8.2"
        )

    ("ethics-and-privacy" 
        )

    ("grouped-samples"
	"IM.7.8.11"
	"IM.7.8.18"	        
	)

    ("if-expressions" 
        )

    ("histograms" 
	"IM.6.8.6"
	"IM.6.8.7"
	"IM.6.8.8"
	"IM.8.6.2"        
	)

    ("histograms2" 
        "IM.6.8.6"
	"IM.6.8.7"
	"IM.6.8.8"
	"IM.8.6.1"
	)

    ("linearity"
        "CMP.7.5"
        "CMP.8.1"
        )

    ("linearity2"
        "CMP.7.5"
        "CMP.8.1"
        )

    ("linear-regression" 
        "CMP.8.1"
	"IM.8.6.6"
	"IM.8.6.7"
	"IM.8.6.8"
        )

    ("measures-of-center"
        "CMP.6.7"
        "CMP.8.1"
	"IM.6.8.9"
	"IM.6.8.10"
	"IM.6.8.13"
	"IM.6.8.14"
	"IM.7.8.11"
	"IM.7.8.13"
        )

    ("measures-of-spread" 
        "CMP.6.7"
	"IM.6.8.15"
	"IM.6.8.16"
	"IM.6.8.17"
	"IM.7.8.15"
        )

    ("method-chaining" 
        )

    ("displaying-categorical-data" 
        "IM.8.6.1"
	"IM.8.6.2"
	)

    ("random-samples" 
        "CMP.7.8"
	"IM.7.8.12"
	"IM.7.8.14"
	"IM.7.8.17"
        )

    ("scatter-plots"
        "CMP.8.1"
	"IM.8.6.2"
	"IM.8.6.3"
        )

    ("table-methods" 
        )

    ("threats-to-validity" 
	"IM.7.8.14"
	"IM.7.8.17"
	"IM.7.8.19"        
	)
    ))
