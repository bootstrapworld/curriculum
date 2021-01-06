#lang racket

;FIXME what wd be the canonical location of this file?
;      the pathway top dir?

(provide *lessons-and-standards*)

(define *lessons-and-standards*
  '(

   
    ("alg-character-animation" 
        "8.F.B"
        "HSF.LE.B"
        "MP.2"
        "MP.4" ; STEMworks
        "6.EE.B.6" ; STEMworks
        "1B-AP-10" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3A-AP-16" ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.PA.A.1.2")
    ("alg-coordinates" 
        "MP.2"
        )
    ("alg-collision"
        "MP.3" ; STEMworks
        "6.EE.B.6" ; STEMworks
        "HSF.BF.A.1"
        "HSF.BF.B"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        )
    ("alg-compound-inequalities" 
        "7.EE.B.4"
        "HSF.BF.B" ; STEMworks
        "HSF.IF.A.2"
        "HSF.BF.A.1.C" ; STEMworks
        "OK.PA.A.4.3")
    ("alg-defining-functions" 
        "MP.4" ; STEMworks
        "6.EE.B.6" ; STEMworks
        "HSF.IF.A" ; STEMworks
        "HSF.IF.A.2"
        "HSF.IF.B"
        "HSF.IF.C"
        "7.EE.B.4"
        "8.F.B"
        "1B-AP-15" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-14"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "HSA.SSE.A.1"
        "OK.PA.A.1.1"
        "OK.PA.A.1.2")
    ("alg-defining-values" 
        "7.EE.B.4"
        "HSA.SSE.A.1"
        "MP.2"
        "MP.7"
        "OK.PA.A.3.1"
        "2-AP-14" ; STEMworks
        )
    ("alg-distance-formula" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B" ; STEMworks
        "8.G.B" ; STEMworks <-- recommend we remove the sub-standards and keep this
        "8.G.B.7"
        "8.G.B.8" ; STEMworks
        "MP.2"
        "MP.3" ; STEMworks
        "OK.PA.GM.1.2"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        )
    ("alg-domain-and-range" 
        "8.F.A.1"
        "HSF.IF.A.1"
        "OK.PA.A.1.1"
        )
    ("alg-error-analysis" 
        "MP.2"
        )
    ("alg-flags" 
        "HSN.Q.A" 
        "6.RP.A" 
        "6.RP.A.3.D"
        "HSF.IF.A.2"
        "HSF.IF.B"
        "OK.MAP.1"
        "OK.MAP.4"
        "OK.PA.A.4"
        "OK.3.AP.A.01" 
        "OK.4.AP.C.01"
        "OK.3.AP.M.01"
        "OK.3.AP.PD.03"
        "OK.6.AP.M.01"
        ) 
    ("alg-function-composition" 
        "6.EE.B.6" ; STEMworks
        "HSF.BF.A.1.C"
        "HSF.BF.A" ; STEMworks
        "MP.1"
        "MP.5"
        "OK.PA.A.3.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-21" ; STEMworks
        )
    ("alg-numbers-inside-videogames" 
        "MP.2"
        )
    ("alg-inequalities" 
        "7.EE.B.4"
        "HSF.IF.A.2"
        "MP.1"
        "MP.4"
        "OK.PA.A.4.3"
        )
    ("alg-inequalities-2" 
        "7.EE.B.4"
        "HSF.IF.A.2"
        "OK.PA.A.4.3"
        )
    ("alg-making-game-images" 
        "7.RP.A.1"
        "8.G.A.1"
        "1B-AP-14" ; STEMworks
        "2-AP-16"  ; STEMworks
        "3A-AP-20" ; STEMworks
        "1B-IC-21" ; STEMworks
        "3A-AP-18" ; STEMworks
        "MP.6"
        )
    ("alg-order-of-operations" 
        "OK.PA.A.3"
        "OK.A1.A.3"
        "HSA.SSE.A.2"
        "HSA.SSE.B"
        "MP.1"
        "MP.2"
        "MP.3" ; STEMworks
        "MP.4" ; STEMworks
        )
    ("alg-piecewise-functions" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B" ; STEMworks
        "HSA.SSE.A.1.A"
        "HSA.SSE.A.1.B"
        "MP.8"
        "1B-AP-12" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.PA.A.1.1"
        )
    ("alg-player-animation" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B"   ; STEMworks
        "MP.4"     ; STEMworks
        "3B-AP-22" ; STEMworks
        "1B-AP-10" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3A-AP-16" ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "HSA.SSE.A.1.A"
        "HSA.SSE.A.1.B"
        "OK.PA.A.1.1"
        )      
    ("alg-problem-decomposition"
        "6.EE.B.6" ; STEMworks
        "7.EE.A.2" ; STEMworks
        "7.EE.B"   ; STEMworks
        "HSF.BF.A" ; STEMworks
        "HSF.BF.A.1"
        "HSF.BF.A.1.C" ; STEMworks
        "HSF.BF.B" ; STEMworks
        "MP.1"
        "MP.3"     ; STEMworks
        "MP.4"     ; STEMworks
        "MP.6"
        "1B-AP-11" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-13"  ; STEMworks
        "3A-AP-17" ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.A1.A.3.1")
    ("alg-restating-the-problem" 
        "8.F.B"
        "HSF.BF.A.1"
        "MP.1"
        "MP.7"
        "OK.PA.A.1.2"
        )
    ("alg-sam-the-butterfly"
        "6.EE.B.6" ; STEMworks
        "MP.4" ; STEMworks
        "7.EE.B" ; STEMworks
        "HSF.BF.B" ; STEMworks
        "HSF.BF.A.1.C" ; STEMworks
        "OK.PA.A.4.3"
        "OK.A1.A.2"
        )
    ("alg-simple-inequalities" 
        "7.EE.B.4"
        "HSF.IF.A.2"
        "MP.1"
        "MP.4"
        "OK.PA.A.4.3"
        )
    ("alg-solving-word-problems" 
        "6.EE.B.6" ; STEMworks
        "MP.4" ; STEMworks
        "7.EE.B" ; STEMworks
        "7.EE.B.4"
        "8.F.B"
        "HSF.IF.A.2"
        "OK.PA.A.1.3"
        "OK.PA.A.2.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "3B-AP-23" ; STEMworks
        )
    ("alg-surface-area-rect-prism"
        "6.EE.B.6" ; STEMworks
        "MP.4" ; STEMworks
        "6.G.A.4"
        "7.G.B.6"
        "OK.PA.GM.2.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        )
   

    ;data science
    
    ("ds-applying-functions" 
        "HSF.IF.A.2"
        "OK.A1.F.1.2"
        )
    ("ds-checking-your-work" 
        "MP.3" ; STEMworks
        "HS-SEP5-4" 
        "2-AP-17" 
        "3B-AP-21" 
        "1B-AP-15" ; STEMworks
        "2-AP-17"  ; STEMworks
        "3B-AP-21" ; STEMworks
        "P6" 
        "9-12.Computing Systems.Troubleshooting" 
        "6-8.Computing Systems.Troubleshooting"
        "OK.L1.IC.C.02"
        )
    ("ds-choosing-your-dataset" 
        "6.SP.A.1" ; STEMworks
        "HS-SEP1-3" 
        "3A-AP-16" 
        "3A-AP-23" 
        "3B-AP-14" 
        "1B-AP-11" ; STEMworks
        "3A-AP-17" ; STEMworks
        "P7"
        "OK.L1.DA.CVT.01"
        )
    ("ds-correlations" 
        "MP.3" ; STEMworks
        "MP.4" ; STEMworks
        "1B-DA-06" ; STEMworks
        "HSS.ID.C.9" 
        "HSS.ID.C.8" 
        "HSS.ID.B.6" 
        "8.SP.A.1" 
        "8.SP.A.2" 
        "HS-SEP6-1" 
        "2-DA-09" 
        "3B-NI-05" 
        "3B-NI-07" 
        "P5" 
        "6-8.Data and Analysis.Visualization and Transformation"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        )
    ("ds-defining-functions" 
        "6.EE.B.6" ; STEMworks
        "MP.4" ; STEMworks
        "8.SP.A.1" 
        "HS-SEP5-3" 
        "HSF.IF.A" ; STEMworks
        "HSF.BF.A.1" 
        "1B-AP-15" ; STEMworks
        "2-AP-14" 
        "2-AP-17" 
        "2-AP-19" 
        "P4" 
        "6-8.Algorithms and Programming.Variables" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.A1.F.1.3"
        "OK.A1.A.1.1"
        "OK.8.AP.PD.02"
        )
      ("ds-defining-table-functions" 
        "6.EE.B.6" ; STEMworks
        "HS-SEP5-3" 
        "2-AP-13" 
        "2-AP-14" 
        "2-AP-17" 
        "2-AP-19" 
        "3A-AP-17" 
        "3A-AP-18" 
        "P4" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.L1.AP.M.01"
        )
    ("ds-displays-and-lookups" 
        "HS-SEP4-1" 
        "3A-DA-11" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        "OK.8.DA.S.01"
        )
    ("ds-intro" 
        "MP.3" ; STEMworks
        "6.SP.A.1" ; STEMworks
        "SL.9-10.1" 
        "P7"
        "OK.8.DA.CVT.01"
        "OK.5.DA.IM.01"
        )
    ("ds-ethics-and-privacy" 
        "3A-AP-16" 
        "MP.3"    ; STEMworks
        "2-IC-23" ; STEMworks
        "3A-IC-24"; STEMworks
        "3A-IC-29"; STEMworks
        "3A-IC-30"; STEMworks
        "P1" 
        "HS-SEP7-1" 
        "9-12.Data and Analysis.Collection" 
        "9-12.Impacts of Computing.Culture" 
        "9-12.Impacts of Computing.Safety, Law, and Ethics"
        "OK.L1.IC.C.01"
        )
    ("ds-grouped-samples"
        "6.EE.B.6" ; STEMworks
        "8.SP.A.1"
        "HS-SEP4-5" 
        "2-DA-08" 
        "2-DA-09" 
        "2-AP-11" 
        "P3"
        "OK.PA.A.2.2"
        "OK.L1.IC.C.02"
        )
    ("ds-if-expressions" 
        "HS-SEP4-5" 
        "2-DA-08" 
        "2-AP-19" 
        "3B-NI-05" 
        "1B-AP-10" ; STEMworks
        "P3" 
        "6-8.Data and Analysis.Inference and Models" 
        "9-12.Algorithms and Programming.Control"
        )
    ("ds-histograms" 
        "MP.4" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "HSS.ID.A.3" 
        "HSS.ID.A.1" 
        "HSS.ID.A.2"
        "HS-SEP2-1"  
        "3A-DA-11" 
        "3B-AP-14" 
        "P5"
        )
    ("ds-histograms2" 
        "MP.4" ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.A"   ; STEMworks
        "HSS.ID.A.3" 
        "HSS.ID.A.1" 
        "HS-SEP4-2"
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "3B-AP-14" 
        "9-12.Data and Analysis.Visualization and Transformation"
        "OK.L1.AP.PD.05"
        )
    ("ds-linearity"
        "6.EE.B.6" ; STEMworks
        "8.F.A.2"
        "8.F.B.4"
        "8.EE.B.5"
        "HSF.IF.A" ; STEMworks  <- recommend we keep this, and remove sub-standards
        "HSF.IF.A.2"
        "HSF.IF.B.5"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "MP.1"
        "MP.2"
        "MP.3"
        "MP.5"
        "MP.7"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        )
    ("ds-linearity-2"
        "6.EE.B.6" ; STEMworks
        "HSF.IF.A.1"
        "HSF.IF.A.2"
        "HSF.IF.B.5"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "MP.1"
        "MP.2"
        "MP.3"
        "MP.5"
        "MP.7"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        "OK.PA.A.2.3"
        "OK.A1.A.4.1"
        "OK.A1.F.3.1"
        )
    ("ds-linear-regression" 
        "MP.4" ; STEMworks
        "HSS.ID.C.7" 
        "HSS.ID.C.8" 
        "HSS.ID.C.9" 
        "HSS.ID.B.6.A" ; STEMworks
        "HSS.ID.B.6.C" 
        "6.EE.B.6" ; STEMworks
        "6.SP.A"   ; STEMworks
        "8.SP.A.1" 
        "8.SP.A.2" 
        "8.SP.A.3" 
        "HS-SEP3-5"
        "1B-DA-06" ; STEMworks 
        "1B-DA-07" ; STEMworks
        "3A-DA-11" 
        "3A-DA-12" ; STEMworks
        "3B-NI-05" 
        "9-12.Data and Analysis.Inference and Models"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        )
    ("ds-measures-of-center"
        "MP.3" ; STEMworks
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.5.C";STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.D";STEMworks
        "HSS.ID.A.2";STEMworks
        "HS-SEP4-2"
        "6-8.Data and Analysis.Inference and Models"
        "OK.PA.D.1.2"
        )
    ("ds-measures-of-spread" 
        "MP.3" ; STEMworks
        "MP.4" ; STEMworks
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.C"; STEMworks
        "HSS.ID.A.2";STEMworks
        "HS-SEP4-2" 
        "HSS.ID.A.1" 
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "P5" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        )
    ("ds-method-chaining" 
        "HS-SEP4-1" 
        "1B-AP-10" ; STEMworks
        "2-AP-17" 
        "2-AP-13" 
        "3A-AP-17" 
        "3A-AP-18" 
        "P3" 
        "9-12.Algorithms and Programming.Control" 
        "6-8.Algorithms and Programming.Control" 
        "9-12.Algorithms and Programming.Modularity"
        "OK.L1.AP.M.01"
        )
    ("ds-plotting"  
        "2-DA-08" 
        "3A-DA-11" 
        "P5"
        "OK.8.DA.S.01"
        )
    ("ds-pyret-intro" 
        "OK.7.AP.A.01"
        "OK.8.AP.C.01"
        ) 
    ("ds-random-samples" 
        "HSS.IC.B.3" 
        "HS-SEP4-3" 
        "2-DA-08" 
        "2-DA-09"
        "OK.PA.A.2.2"
        "OK.PA.D.2.2"
        "OK.L1.IC.C.02"
        )
    ("ds-scatter-plots"
        "HS-SEP6-1" 
        "6.SP.A" ; STEMworks
        "8.SP.A.1" 
        "8.SP.A.2" 
        "HSS.ID.B.6" 
        "HSS.ID.C.8" 
        "1B-DA-06" ; STEMworks
        "1B-DA-07" ; STEMworks
        "2-DA-09"  ; STEMworks
        "3A-DA-12" ; STEMworks
        "3A-DA-11" 
        "3B-NI-05" 
        "P5" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Visualization and Transformation"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        )
    ("ds-table-methods" 
        "HS-SEP4-6"
        "2-DA-08"
        "OK.L1.AP.M.02"
        )
    ("ds-threats-to-validity" 
        "MP.3" ; STEMworks
        "HSS.IC.B.6" 
        "HS-SEP4-3"
        "HS-SEP1-7" 
        "3B-NI-07" 
        "2-IC-21" ; STEMworks
        "P1" 
        "6-8.Data and Analysis.Collection" 
        "9-12.Data and Analysis.Inference and Models"
        "OK.L1.IC.C.02"
        )
    ))
