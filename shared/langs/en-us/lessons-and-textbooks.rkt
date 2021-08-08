#lang racket

(provide *lessons-and-textbooks*)

(define *lessons-and-textbooks*
  '(
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
	"IM.Alg1.4.2"
	"IM.Alg1.4.3"	
	)

    ("defining-functions" 
        "IM.8.5.3"
		"IM.Alg1.4.4"
		"IM.Alg1.4.5"
		"IM.Alg1.4.2"
		"IM.Alg1.4.3"
	)

    ("defining-values"
        "CMP.6.6" 
        "IM.6.6.2"
	"IM.7.6.11"
	"IM.Alg1.4.2"
	)

    ("simple-dataypes" 
	"IM.6.7.8"
	"IM.6.7.9"
	"IM.6.7.10"
	"IM.7.6.13"
	; no solid alignment to IM.Alg1
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
	"IM.Alg1.4.1"
	)

    ("distance-formula" 
        "CMP.8.2"
        "IM.8.8.6"
	"IM.8.8.7"
	"IM.8.8.8"
	"IM.8.8.10"
	"IM.Alg1.2.9"
	)

    ("flags" 
	"IM.6.2.14"
	"IM.6.1.3"
	"IM.6.7.14"
	"IM.6.7.15"
        "IM.7.4.1"
	"IM.7.1.1"
	"IM.7.1.5"
	"IM.8.1.1"
	"IM.8.1.2"
	"IM.8.1.3"
	"IM.8.2.1"
	"IM.Alg1.4.3"
	) 

    ("function-composition"
	; no solid alignment to IM.Alg1
        )

    ("functions-for-character-animation" 
	"IM.6.6.6"
	"IM.6.3.8"
	"IM.8.3.11"
	"IM.Alg1.4.6"
	"IM.Alg1.4.10"
        )

    ("inequalities-collision"
        "IM.8.8.11"
		"IM.Alg1.2.20"
	)

    ("inequalities1-simple"
        "IM.6.7.8"
	"IM.6.7.9"
	"IM.6.7.10"
	"IM.Alg1.2.18"
	)

    ("inequalities2-compound" 
	"IM.Alg1.2.18"
        )

    ("inequalities3-sam"
	"IM.6.7.10"
	"IM.7.6.17"
	"IM.Alg1.2.20"
	)    

    ("making-game-images" 
        "IM.6.5.5"
	"IM.7.1.1"
	"IM.7.1.5"
	"IM.8.1.1"
	"IM.8.1.2"
	"IM.8.1.3"
	"IM.8.2.1"
	"IM.Alg1.4.2"
	)

    ("numbers-inside-videogames" 
        "IM.6.7.11"
	"IM.6.7.12"
	"IM.8.1.1"
	"IM.Alg1.1.1"
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
	"IM.Alg1.2.6"
        )
	
    ("piecewise-functions" 
        "CMP.Alg-Ext.2"
	"IM.8.5.10"
	"IM.Alg1.4.12"
        )

    ("player-animation" 
        "IM.8.5.10"
		"IM.Alg1.4.12"
	)      

    ("problem-decomposition"
        "IM.6.6.8"
		"IM.Alg1.2.6"
		"IM.Alg1.2.8"
	)
        
    ("restating-the-problem" 
        "IM.8.5.3"
		"IM.Alg1.4.4"
		"IM.Alg1.4.5"
	)

    ("solving-word-problems" 
	"IM.7.2.3"
	"IM.8.5.3"
	"IM.Alg1.2.5"
        )

    ("surface-area-rect-prism"
        "CMP.6.4"
        "CMP.7.7"
	"IM.6.1.12"
	"IM.6.1.13"
	"IM.6.1.14"
	"IM.6.1.15"
	"IM.7.7.14"
	"IM.Alg1.2.2"
	"IM.Alg1.2.3"
        )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATA SCIENCE
	
    ("checking-your-work" 
	"IM.Alg1.1.15"
        )

    ("choosing-your-dataset" 
	"IM.Alg1.3.10"
        )

    ("correlations" 
        "CMP.8.1"
	"IM.8.6.4"
	"IM.8.6.5"
	"IM.Alg1.3.5"
	"IM.Alg1.3.7"
	"IM.Alg1.3.8"
        )
	
    ("defining-table-functions" 
        "IM.8.5.3"
		"IM.Alg1.4.10"
	)

    ("displays-and-lookups" 
        "IM.8.6.9"
		"IM.Alg1.1.9"
	)

    ("ds-intro" 
	"IM.6.8.1"
	"IM.6.8.2"
	"IM.Alg1.1.1"
        )

    ("ethics-and-privacy" 
	; no solid alignment to IM.Alg1
        )

    ("grouped-samples"
	"IM.7.8.11"
	"IM.7.8.18"	
	; no solid alignment to IM.Alg1
	)

    ("if-expressions" 
		"IM.Alg1.4.10"
        )

    ("histograms" 
	"IM.6.8.6"
	"IM.6.8.7"
	"IM.6.8.8"
	"IM.8.6.2" 
	"IM.Alg1.1.2"
	"IM.Alg1.1.3"
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
	"IM.Alg1.3.7"
	"IM.Alg1.3.8"
	"IM.Alg1.3.9"
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
	"IM.Alg1.1.5"
	"IM.Alg1.1.11"
        )

    ("measures-of-spread" 
        "CMP.6.7"
	"IM.6.8.15"
	"IM.6.8.16"
	"IM.6.8.17"
	"IM.7.8.15"
	"IM.Alg1.1.11"
	"IM.Alg1.1.15"
        )

    ("method-chaining"
		"IM.Alg1.4.3"
        )

    ("displaying-categorical-data" 
        "IM.8.6.1"
	"IM.8.6.2"
	"IM.Alg1.1.2"
	"IM.Alg1.1.3"
	)

    ("random-samples" 
        "CMP.7.8"
	"IM.7.8.12"
	"IM.7.8.14"
	"IM.7.8.17"
	; no solid alignment to IM.Alg1
        )

    ("scatter-plots"
        "CMP.8.1"
	"IM.8.6.2"
	"IM.8.6.3"
	"IM.Alg1.3.4"
        )

    ; it appeared that this BS:DS lesson was missing from this file, so xbousquet added it on Aug 6th
    ; grades 6 - 8 alignment may be needed here
    ("simple-datatypes"
            "IM.Alg1.1.6"
    )

    ("table-methods" 
        )

    ("threats-to-validity" 
	"IM.7.8.14"
	"IM.7.8.17"
	"IM.7.8.19"  
	"IM.Alg1.3.9"	
	)
	
    ; it appeared that this BS:DS lesson was missing from this file, so xbousquet added it on Aug 6th
    ; grades 6 - 8 alignment may be needed here
    ("visualizing-the-shape-of-data"
            "IM.Alg1.1.4"
    )

))
