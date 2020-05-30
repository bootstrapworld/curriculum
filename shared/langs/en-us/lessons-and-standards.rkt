#lang racket

;FIXME what wd be the canonical location of this file?
;      the pathway top dir?

(provide *lessons-and-standards*)

(define *lessons-and-standards*
  '(

    ("alg-game-intro" "BS-M")
    ("alg-game-intro" "MP.2")
    ("alg-coordinates" "BS-M")
    ("alg-coordinates" "MP.2")
    ("alg-creating-functions-1" "7.EE.B.4")
    ("alg-creating-functions-1" "8.F.B")
    ("alg-creating-functions-1" "BS-DR.1")
    ("alg-creating-functions-1" "HSA.SSE.A.1")
    ("alg-defining-functions" "7.EE.B.4")
    ("alg-defining-functions" "8.F.B")
    ("alg-defining-functions" "BS-DR.1")
    ("alg-defining-functions" "HSA.SSE.A.1")
    ("alg-solving-word-problems" "7.EE.B.4")
    ("alg-solving-word-problems" "8.F.B")
    ("alg-solving-word-problems" "BS-DR.2")
    ("alg-solving-word-problems" "HSF.IF.A.2")
    ("alg-restating-the-problem" "8.F.B")
    ("alg-restating-the-problem" "BS-DR.1")
    ("alg-restating-the-problem" "BS-DR.2")
    ("alg-restating-the-problem" "BS-DR.3")
    ("alg-restating-the-problem" "HSF.BF.A.1")
    ("alg-restating-the-problem" "MP.1")
    ("alg-restating-the-problem" "MP.7")
    ("alg-defining-values" "7.EE.B.4")
    ("alg-defining-values" "BS-PL.3")
    ("alg-defining-values" "HSA.SSE.A.1")
    ("alg-defining-values" "MP.2")
    ("alg-defining-values" "MP.7")
    ("alg-distance-formula" "8.G.B.7")
    ("alg-distance-formula" "MP.2")
    ("alg-domain-and-range" "8.F.A.1")
    ("alg-domain-and-range" "BS-PL.2")
    ("alg-domain-and-range" "HSF.IF.A.1")
    ("alg-error-analysis" "MP.2")
    ("alg-making-game-images" "7.RP.A.1")
    ("alg-making-game-images" "8.G.A.1")
    ("alg-making-game-images" "BS-IDE")
    ("alg-making-game-images" "BS-PL.3")
    ("alg-making-game-images" "MP.6")
    ("alg-character-animation" "8.F.B")
    ("alg-character-animation" "BS-PL.3")
    ("alg-character-animation" "HSF.LE.B")
    ("alg-character-animation" "MP.2")
    ("alg-problem-decomposition" "BS-DR.1")
    ("alg-problem-decomposition" "BS-DR.2")
    ("alg-problem-decomposition" "HSF.BF.A.1")
    ("alg-problem-decomposition" "MP.1")
    ("alg-problem-decomposition" "MP.6")
    ("alg-function-composition-1" "8.G.A.1")
    ("alg-function-composition-1" "BS-IDE")
    ("alg-function-composition-1" "MP.1")
    ("alg-function-composition-1" "MP.5")
    ("alg-function-composition-2" "7.RP.A.1")
    ("alg-function-composition-2" "8.G.A.1")
    ("alg-function-composition-2" "MP.1")
    ("alg-function-composition-3" "HSF.BF.A.1.B")
    ("alg-simple-inequalities" "7.EE.B.4")
    ("alg-simple-inequalities" "BS-DR.2")
    ("alg-simple-inequalities" "BS-DR.3")
    ("alg-simple-inequalities" "HSF.IF.A.2")
    ("alg-simple-inequalities" "MP.1")
    ("alg-simple-inequalities" "MP.4")
    ("alg-compound-inequalities" "7.EE.B.4")
    ("alg-compound-inequalities" "BS-DR.2")
    ("alg-compound-inequalities" "BS-DR.3")
    ("alg-compound-inequalities" "HSF.IF.A.2")
    ("alg-order-of-operations" "HSA.SSE.A.2")
    ("alg-order-of-operations" "HSA.SSE.B")
    ("alg-order-of-operations" "MP.1")
    ("alg-order-of-operations" "MP.2")
    ("alg-piecewise-functions" "HSA.SSE.A.1.A")
    ("alg-piecewise-functions" "HSA.SSE.A.1.B")
    ("alg-piecewise-functions" "MP.8")
    ("alg-player-animation" "HSA.SSE.A.1.A")
    ("alg-player-animation" "HSA.SSE.A.1.B")

    ; flags
    ("fl-flags-of-the-world" "N-Q&1&3" "BS-PL.2" "6.NS.5-8" "F-IF.1-3")
    ("fl-image-transformations" "N-Q&1&3" "BS-PL.2" "6.NS.5-8" "F-IF.1-3")
    ("fl-intro-to-dilations" "N-Q&1&3" "BS-PL.2" "6.NS.5-8" "F-IF.1-3")

    ; demo
    ("__sample-lesson" "8.F.1-3&1")
    ("__sample-lesson" "8.NS.A")

    ;data science
    ("ds-intro" 
        "6.SP.A.1" "6.SP.B.5.A" "7.SP.A.1" "SL.9-10.1" 
        "2-DA-07" 
        "P7")
    ("ds-pyret-intro" 
        "2-DA-07")
    ("ds-applying-functions" 
        "HSF.IF.A.2")
    ("ds-plotting" 
        "2-DA-07" "2-DA-08" "3A-DA-11" 
        "P5")
    ("ds-displays-and-lookups" 
        "6.SP.B.4" "8.SP.A.1" 
        "HS-SEP4-1" 
        "3A-DA-11" 
        "9-12.Data and Analysis.Visualization and Transformation" "6-8.Data and Analysis.Inference and Models")
    ("ds-defining-functions" 
        "8.SP.A.1" 
        "HS-SEP5-3" "HSF.BF.A.1" 
        "2-AP-14" "2-AP-17" "2-AP-19" "P4" 
        "6-8.Algorithms and Programming.Variables" "9-12.Algorithms and Programming.Modularity" "6-8.Algorithms and Programming.Modularity")
    ("ds-table-methods" 
        "HS-SEP4-6"
        "2-DA-08")
    ("ds-defining-table-functions" 
        "HS-SEP5-3" 
        "2-AP-13" "2-AP-14" "2-AP-17" "2-AP-19" "3A-AP-17" "3A-AP-18" "P4" 
        "9-12.Algorithms and Programming.Modularity" "6-8.Algorithms and Programming.Modularity")
    ("ds-method-chaining" 
        "HS-SEP4-1" 
        "2-AP-17" "2-AP-13" "3A-AP-17" "3A-AP-18" "P3" 
        "9-12.Algorithms and Programming.Control" "6-8.Algorithms and Programming.Control" "9-12.Algorithms and Programming.Modularity")
    ("ds-if-expressions" 
        "HS-SEP4-5" 
        "2-DA-08" "2-AP-19" "3B-NI-05" "P3" 
        "6-8.Data and Analysis.Inference and Models" "9-12.Algorithms and Programming.Control")
    ("ds-random-samples" 
        "7.SP.A.1" "7.SP.A.2" "HSS.IC.B.3" 
        "HS-SEP4-3" 
        "2-DA-08" "2-DA-09")
    ("ds-grouped-samples" 
        "6.SP.B.4" "8.SP.A.1" 
        "HS-SEP4-5" 
        "2-DA-08" "2-DA-09" "2-AP-11" "P3")
    ("ds-choosing-your-dataset" 
        "6.SP.A.1" 
        "HS-SEP1-3" 
        "3A-AP-16" "3A-AP-23" "3B-AP-14" "P7")
    ("ds-histograms" 
        "6.SP.A.2" "6.SP.B.4" "6.SP.B.5.A" "6.SP.B.5.B" "6.SP.B.5.C" "HSS.ID.A.3" "HSS.ID.A.1" "HSS.ID.A.2"
        "HS-SEP2-1"  
        "3A-DA-11" "3B-AP-14" "P5")
    ("ds-histograms2" 
        "6.SP.A.2" "6.SP.B.4" "6.SP.B.5.C" "HSS.ID.A.3" "HSS.ID.A.1" "HSS.ID.B.6.A"
        "HS-SEP4-2" 
        "3A-DA-11" "3B-AP-14" 
        "9-12.Data and Analysis.Visualization and Transformation")
    ("ds-measures-of-center" 
        "6.SP.A.2" "6.SP.A.3" "6.SP.B.4" "6.SP.B.5.C" 
        "HS-SEP4-2" 
        "6-8.Data and Analysis.Inference and Models")
    ("ds-measures-of-spread" 
        "6.SP.A.2" "6.SP.B.4" "6.SP.B.5.C" "7.SP.B.3" 
        "HS-SEP4-2" "HSS.ID.A.1" 
        "3A-DA-11" "P5" 
        "9-12.Data and Analysis.Visualization and Transformation" "6-8.Data and Analysis.Inference and Models")
    ("ds-checking-your-work" 
        "7.SP.A.1" 
        "HS-SEP5-4" "2-AP-17" 
        "3B-AP-21" "P6" 
        "9-12.Computing Systems.Troubleshooting" "6-8.Computing Systems.Troubleshooting")
    ("ds-scatter-plots" 
        "HS-SEP6-1" 
        "8.SP.A.1" "8.SP.A.2" "HSS.ID.B.6" "HSS.ID.C.8" 
        "3A-DA-11" "3B-NI-05" "P5" 
        "9-12.Data and Analysis.Visualization and Transformation" "6-8.Data and Analysis.Visualization and Transformation")
    ("ds-correlations" 
        "HSS.ID.C.9" "HSS.ID.C.8" "HSS.ID.B.6" "8.SP.A.1" "8.SP.A.2" 
        "HS-SEP6-1" 
        "2-DA-09" "3B-NI-05" "3B-NI-07" "P5" 
        "6-8.Data and Analysis.Visualization and Transformation")
    ("ds-linear-regression" 
        "HSS.ID.C.7" "HSS.ID.C.8" "HSS.ID.C.9" "HSS.ID.B.6.C" "8.SP.A.1" "8.SP.A.2" "8.SP.A.3" 
        "HS-SEP3-5" 
        "3A-DA-11" "3B-NI-05" 
        "9-12.Data and Analysis.Inference and Models")
    ("ds-threats-to-validity" 
        "HSS.IC.B.6" "HS-SEP4-3" "7.SP.A.1" 
        "HS-SEP1-7" 
        "3B-NI-07" "P1" 
        "6-8.Data and Analysis.Collection" "9-12.Data and Analysis.Inference and Models")
    ("ds-ethics-and-privacy" 
        "3A-AP-16" "P1" 
        "HS-SEP7-1" 
        "9-12.Data and Analysis.Collection" "9-12.Data and Analysis.Collection" "9-12.Impacts of Computing.Culture" "6-8.Impacts of Computing.Culture" "9-12.Impacts of Computing.Safety, Law, and Ethics" "6-8.Impacts of Computing.Safety, Law, and Ethics")

    ))
