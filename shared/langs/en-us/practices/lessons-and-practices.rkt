#lang racket

(provide *lessons-and-practices*)

(define *lessons-and-practices*
  '(

; dummy alignments for sample lessons
    ("__sample-lesson" "SJ.1")
    ("zample-lesson" "SJ.1")
; core

    ("computing-needs-all-voices" 
        "SJ.1"
        "SJ.2"
        "SJ.4"
        "SJ.7"
        "SJ.8"
        "SJ.10"
        "P1"
        ) 

    ("codap-transformers" 
        "MP.4"
        )

    ("contracts"
         "SEP.8" 
         "MLR.8"
         "MLR.2"    ; strategy box in lesson
        )

    ("defining-functions" 
        "MP.4"      ; STEMworks
        "MLR.7"
        "MLR.3"     ; page focused just on this
        "P4" 
        )

    ("debugging" 
        "MP.6"
        "P2"
        "P6"
        )

    ("simple-data-types" 
        "MLR.4"
        "MP.6"
        ) 
; math
   
    ("combinatorics-permutation"
        "MP.4"
        "MP.7"
        "SEP.5")

    ("combinatorics-combination"
        "MP.4"
        ; "MP.5" -- needed? FIXME
        "MP.7"
        "SEP.5")

    ("coordinates" 
        "MP.2"
        )

    ("defining-values" 
        "MP.2"
        "MP.7"
        "MP.8"
        "SEP.7"
        "MLR.5"
        "MLR.7"
        "MLR.8"
        )
    
    ("distance-formula" 
        "MP.2"
        "MP.3"      ; STEMworks
        "SEP.5"
        "MLR.8"
        )

    ("error-analysis" 
        "MP.2"
        )

    ("flags" 
        "MLR.3"
        "MLR.7"
        "MP.1"
        "MP.2"
        "MP.4"
        "MP.6"
        "MP.7"
        "MP.8"
        "SEP.5"
        ) 

    ("function-composition" 
        "MP.1"
        "MP.5"
        "SEP.5"
        "MLR.1"     ; strategy box in lesson
        "MLR.3"
        "MLR.7"
        )

    ("functions-for-character-animation" 
        "MP.2"
        "MP.4"      ; STEMworks
        )

    ("inequalities1-simple" 
        "MP.1"
        "MP.4"
        "MP.6"
        "MLR.5"
        )

    ("inequalities2-compound" 
        "MLR.5"
        "MP.1"
        )

    ("inequalities3-sam"
        "MP.4"      ; STEMworks
        )    

    ("inequalities-collision"
        "MP.3"      ; STEMworks
        "MLR.7"
        )   

    ("making-game-images" 
        "MP.6"
        "MLR.8"     ; strategy box in lesson
        )

    ("numbers-inside-video-games" 
        "MP.2"
        "MP.4"
        )

    ("order-of-operations" 
        "MP.1"
        "MP.2"
        "MP.3"      ; STEMworks
        "MP.4"  
        "MLR.7"
        "SEP.2"
        )

    ("player-animation" 
        "MP.3"
        "MP.4"      ; STEMworks
        "MP.6"
        "MLR.6"     ; strategy box in lesson
        )      

    ("problem-decomposition"
        "MP.1"
        "MP.3"     ; STEMworks
        "MP.4"     ; STEMworks
        "MP.6"
        "MLR.7"    
        )
        
    ("restating-the-problem" 
        "MP.1"
        "MP.7"
        "MLR.6"     ; strategy box in lesson
        "MLR.1"     ; strategy box in lesson
        )

    ("solving-word-problems" 
        "MP.4"      ; STEMworks
        )

    ("surface-area-rect-prism"
        "MP.4"      ; STEMworks
        )

    ;data science
    
    
    ("checking-your-work" 
        "MP.3"      ; STEMworks
        "SEP.3"
        "P6" 
        "SJ.12"
        "SJ.13"
        "SJ.14"
        "SJ.15"
        )

    ("choosing-your-dataset" 
        "MP.2"
        "MP.5"
        "SEP.3"
        "P7"
        )

    ("correlations" 
        "MP.3"      ; STEMworks
        "MP.4"      ; STEMworks
        "MLR.7"
        "SEP.3"
        )

    ("custom-scatter-plots" 
        "MP.7"      
        )    
    
    ("defining-table-functions" 
        "MP.6"
        "MP.8"
        "P4" 
        )

    ("displays-and-lookups" 
        "MP.3"
        )

    ("displaying-categorical-data" 
        "MP.5"
        "MP.6"
        "SEP.3" 
        "SJ.2"
        "SJ.4"
        "SJ.7"
        )   

    ("ds-intro" 
        "MP.3"      ; STEMworks
        "P7"
        )

    ("ethics-and-privacy" 
        "MP.3"      ; STEMworks
        "P1" 
        "SJ.12"
        "SJ.13"
        )

    ("grouped-samples"
        "MP.2"
        "MP.3"
        "SEP.3"
        "P3"
        )

    ("histograms" 
        "MP.4"      ; STEMworks
        "SEP.3"
        )

    ("histograms2" 
        "MP.4"      ; STEMworks
        "SEP.3"
        )

    ("linearity"
        "MP.1"
        "MP.2"
        "MP.3"
        "MP.5"
        "MP.7"
        )

    ("linearity2"
        "MP.1"
        "MP.2"
        "MP.3"
        "MP.5"
        "MP.7"
        )

    ("linear-regression" 
        "MP.4"      ; STEMworks
        "MLR.8"
        "SEP.3"
        )

    ("measures-of-center"
        "MP.3"      ; STEMworks
        "SEP.3"
        )

    ("box-plots" 
        "MP.3"      ; STEMworks
        "MP.4"      ; STEMworks
        "MLR.7"
        "SEP.3"
        )

    ("method-chaining" 
        "MP.6"
        "MLR.8"
        "P3" 
        )

    ("piecewise-functions-conditionals" 
        "MP.8"
        )

    ("random-samples" 
        "MLR.1"
        "MP.2"
        "SEP.3"
        "SJ.10"
        )

    ("scatter-plots"
        "MP.2"
        "SEP.3"
        )

    ("table-methods" 
        "MP.4"
        )

    ("threats-to-validity" 
        "MP.3"      ; STEMworks
        "SEP.3"
        "P1" 
        )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REACTIVE

    ("re-intro-to-data-structures" 
        )

    ("re-structures-reactors-animations" 
        )

    ("re-functions-that-ask-questions" 
        )

    ("re-key-events" 
        )

    ("re-refactoring" 
        "P3"
        "P4"
        )

    ("re-your-own-drawing-functions" 
        )

    ("re-build-your-own-animation" 
        "P3"
        "P4"
        )

    ("re-adding-collisions" 
        "P3"
        "P4"
        )

    ("re-scoring" 
        "P4"
        "P6"
        )

    ("re-adding-levels" 
        "P3"
        "P6"
        )

    ("re-making-pong"
        "P3"
        "P4"
        )

    ("re-nested-structures" 
        "P3"
        "P4"
        )

    ("re-timers" 
        "P3"
        "P4"
        )
))
