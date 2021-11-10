#lang racket

;FIXME what wd be the canonical location of this file?
;      the pathway top dir?

(provide *lessons-and-standards*)

(define *lessons-and-standards*
  '(
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CORE

    ("contracts" 
        "8.F.A.1"
        "HSF.IF.A.1"
        "HSF.IF.A.2"
        "IA.HSF.IF.A.1"
        "OK.A1.F.1.2"
        "OK.PA.A.1.1"
        "OK.A1.F.1.2" 
        "OK.A1.F.1.3"
        "OK.A1.F.1.4"
        "OK.5.GM.1.1"
        "OK.6.GM.2.2"
        "OK.G.2D.1.8"
        )

    ("defining-functions" 
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
        "8.SP.A.1" 
        "HSF.BF.A.1" 
        "P4" 
        "6-8.Algorithms and Programming.Variables" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.PA.A.1.1"
        "OK.PA.A.1.2"
        "OK.A1.F.1.3"
        "OK.A1.A.1.1"
        "OK.8.AP.PD.02"
        )

    ("defining-values"
        "6-8.Algorithms and Programming.Variables"
        "6.EE.B.6"
        "7.EE.B.4"
        "HSA.SSE.A.1"
        "IA.6.EE.B.6"
        "OK.7.A.3.3"
        "OK.PA.A.3.1" 
        "OK.A1.F.3.1"
        "OK.3.A.V.01" ; identical standard
        "OK.4.AP.V.01"; identical standard
        "OK.5.AP.V.01"; identical standard
        "1B-AP-09"
        "2-AP-11"
        )

    ("piecewise-functions-conditionals" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B" ; STEMworks
        "HSA.SSE.A.1.A"
        "HSA.SSE.A.1.B"
        "1B-AP-10" ; STEMworks
        "1B-AP-12" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.PA.A.1.1"
        "OK.L1.AP.M.01"
        "OK.L1.AP.M.02"
        "P3" 
        "9-12.Algorithms and Programming.Control"
        )

    ("simple-data-types"
        "OK.6.A.1.3"
        "OK.7.N.1.2"
        "OK.7.N.1.1"
        "OK.7.N.1.3"
        "OK.7.N.2.4"
        "OK.7.AP.A.01"
        "OK.8.AP.C.01"
        "2-AP-11"
        ) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MATH
   
    ("combinatorics-permutation"
        "HSS.CP.B.9"
        "OK.SP.1.5"
        )

    ("combinatorics-combination"
        "HSS.CP.B.9"
        "OK.SP.1.5"
        )

    ("coordinates"
        "IA.5.G.A.1" 
        "5.G.A.1"
        "OK.6.A.1.1"
        "OK.L1.CS.D.01"
        )

    ("distance-formula" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B" ; STEMworks
        "8.G.B" ; STEMworks <-- recommend we remove the sub-standards and keep this
        "8.G.B.7"
        "8.G.B.8" ; STEMworks
        "OK.PA.GM.1.2"
        "OK.G.2D.1.5"
        "OK.G.RT.1.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-10"
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        )

    ("flags" 
        "HSN.Q.A" 
        "6.RP.A" 
        "6.RP.A.3.D"
        "HSF.IF.A.2"
        "HSF.IF.B"
        "OK.MAP.1"
        "OK.MAP.4"
        "OK.PA.A.4"
        "OK.3.AP.A.01" 
        "OK.3.AP.M.01"
        "OK.3.AP.PD.03"
        "OK.4.AP.C.01"
        "OK.6.AP.M.01"
        "OK.8.AP.A.01"
        "OK.6.A.1.1"
        "OK.7.GM.4.1"
        "OK.7.GM.4.2"
        "3A-AP-18"
        ) 

    ("function-composition" 
        "IA.HSF.BF.A.1.B"
        "IA.HSF.BF.A.1.C"
        "6.EE.B.6" ; STEMworks
        "HSF.BF.A.1.C"
        "HSF.BF.A" ; STEMworks
        "OK.A1.F.1.3"
        "OK.PA.A.3.1"
        "OK.A1.F.3.2"
        "OK.A1.F.3.3"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-21" ; STEMworks
        )

    ("functions-for-character-animation" 
        "8.F.B"
        "HSF.LE.B"
        "6.EE.B.6" ; STEMworks
        "1B-AP-10" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3A-AP-16" ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.PA.A.1.2"
        "OK.8.AP.A.01"
        "OK.PA.A.2.1"
        )

    ("inequalities-collision"
        "6.EE.B.6" ; STEMworks
        "HSF.BF.A.1"
        "HSF.BF.B"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.PA.GM.1.2"
        "OK.G.2D.1.5"
        "OK.G.RT.1.1"
        "OK.PA.GM.1.2"
        )

    ("inequalities1-simple"
        "6.EE.B.8"
        "6.EE.B.5"
        "6.EE.B.8"
        "7.EE.B.4"
        "HSF.IF.A.2"
        "OK.6.A.3.1"
        "OK.7.A.3.3"
        "OK.PA.A.4.3"
        "3B-AP-10"
        )

    ("inequalities2-compound" 
        "7.EE.B.4"
        "HSF.IF.A.2"
        "HSS.CP.A.1"
        "OK.PA.A.4.3"
        "OK.6.A.3.1"
        "OK.7.A.3.3"
        "OK.A1.A.2.2"
        "3B-AP-10"
        )

    ("inequalities3-sam"
        "HSA.CED.A.3"
        "HSA.CED.A.1"
        "HSA.CED.A.3"
        "6.EE.B.8"
        "6.EE.B.6" ; STEMworks
        "7.EE.B" ; STEMworks
        "HSF.BF.B" ; STEMworks
        "HSF.BF.A.1.C" ; STEMworks
        "OK.PA.A.4.3"
        "OK.A1.A.2"
        "OK.7.A.3.3"
        "OK.A1.A.2.2"
        "3B-AP-10"
        )    

    ("making-game-images" 
        "7.RP.A.1"
        "8.G.A.1"
        "1B-AP-12"
        "1B-AP-14" ; STEMworks
        "2-AP-16"  ; STEMworks
        "3A-AP-20" ; STEMworks
        "1B-IC-21" ; STEMworks
        "3A-AP-18" ; STEMworks
        "OK.8.AP.A.01"
        "OK.7.GM.4.1"
        "OK.7.GM.4.2"
        )

    ("numbers-inside-videogames" 
        "OK.L1.CS.D.01"
        )

    ("order-of-operations" 
        "OK.PA.A.3"
        "OK.A1.A.3"
        "OK.7.A.4.2"
        "HSA.SSE.A.2"
        "HSA.SSE.B"
        )

    ("player-animation" 
        "6.EE.B.6" ; STEMworks
        "7.EE.B"   ; STEMworks
        "3B-AP-22" ; STEMworks
        "1B-AP-10" ; STEMworks
        "1B-AP-12"
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

    ("problem-decomposition"
        "6.EE.B.6" ; STEMworks
        "7.EE.A.2" ; STEMworks
        "7.EE.B"   ; STEMworks
        "HSF.BF.A" ; STEMworks
        "HSF.BF.A.1"
        "HSF.BF.A.1.C" ; STEMworks
        "HSF.BF.B" ; STEMworks
        "1B-AP-11" ; STEMworks
        "2-AP-11"  ; STEMworks
        "2-AP-13"  ; STEMworks
        "3A-AP-17" ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "OK.A1.A.3.1"
        )
        
    ("restating-the-problem" 
        "8.F.B"
        "HSF.BF.A.1"
        "OK.8.AP.A.01"
        "OK.PA.A.1.2"
        "OK.PA.A.1.3"
        "OK.PA.A.2.1"
        )

    ("solving-word-problems" 
        "6.EE.B.6"
        "7.EE.B"
        "7.EE.B.4"
        "8.F.B"
        "HSF.IF.A.2"
        "OK.PA.A.1.3"
        "OK.PA.A.2.1"
        "OK.8.AP.A.01"
        "2-AP-11"
        "2-AP-17"
        "2-AP-19"
        "3B-AP-14"
        "3B-AP-21"
        )

    ("surface-area-rect-prism"
        "6.EE.B.6" ; STEMworks
        "6.G.A.4"
        "7.G.B.6"
        "OK.PA.GM.2.1"
        "OK.7.GM.1.1"
        "OK.G.3D.1.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATA SCIENCE
    
    ("checking-your-work" 
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

    ("choosing-your-dataset" 
        "6.SP.A.1" ; STEMworks
        "3A-AP-16" 
        "3A-AP-23" 
        "3B-AP-14" 
        "1B-AP-11" ; STEMworks
        "3A-AP-17" ; STEMworks
        "P7"
        "OK.L1.DA.CVT.01"
        "OK.L1.IC.C.02"
        "OK.A1.D.1.1"
        "OK.PA.D.1.1"
        "OK.PA.A.2.2"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("correlations" 
        "1B-DA-06" ; STEMworks
        "HSS.ID.C.9" 
        "HSS.ID.C.8" 
        "HSS.ID.B.6" 
        "8.SP.A.1" 
        "8.SP.A.2" 
        "2-DA-09" 
        "3B-NI-05" 
        "3B-NI-07" 
        "P5" 
        "6-8.Data and Analysis.Visualization and Transformation"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        )
    
      ("defining-table-functions" 
        "6.EE.B.6" ; STEMworks
        "2-AP-13" 
        "2-AP-14" 
        "2-AP-17" 
        "3A-AP-17" 
        "3A-AP-18" 
        "P4" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.L1.AP.M.01"
        "OK.L1.AP.M.02" 
        "OK.A1.D.2.1"
        )

    ("displays-and-lookups" 
        "3A-DA-11" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("ds-intro" 
        "6.SP.A.1" ; STEMworks
        "SL.9-10.1" 
        "P7"
        "OK.8.DA.CVT.01"
        "OK.5.DA.IM.01"
        )

    ("ethics-and-privacy" 
        "3A-AP-16" 
        "2-IC-23" ; STEMworks
        "3A-IC-24"; STEMworks
        "3A-IC-29"; STEMworks
        "3A-IC-30"; STEMworks
        "P1" 
        "9-12.Data and Analysis.Collection" 
        "9-12.Impacts of Computing.Culture" 
        "9-12.Impacts of Computing.Safety, Law, and Ethics"
        "OK.L1.IC.C.01"
        )

    ("grouped-samples"
        "6.EE.B.6" ; STEMworks
        "8.SP.A.1"
        "2-DA-08" 
        "2-DA-09" 
        "2-AP-11" 
        "P3"
        "OK.PA.A.2.2"
        "OK.L1.IC.C.02"
        "OK.A1.D.1.1"
        "OK.PA.D.1.1"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("histograms" 
        "6.SP.B.4" ; STEMworks
        "HSS.ID.A.3" 
        "HSS.ID.A.1" 
        "HSS.ID.A.2"
        "3A-DA-11" 
        "3B-AP-14" 
        "P5"
        "OK.L1.AP.PD.05"
        "OK.A1.D.1.1" 
        "OK.PA.D.1.1"
        "OK.PA.A.2.2"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("histograms2" 
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.A"   ; STEMworks
        "HSS.ID.A.3" 
        "HSS.ID.A.1" 
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "3B-AP-14" 
        "9-12.Data and Analysis.Visualization and Transformation"
        "OK.L1.AP.PD.05"
        "OK.L1.AP.PD.05"
        "OK.A1.D.1.1"
        "OK.PA.D.1.1"
        "OK.PA.A.2.2"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("custom-scatter-plots"
        "OK.A1.F.1.4"
        "OK.A2.F.1.8"
        "OK.L1.AP.M.01"
        "OK.L1.AP.M.02"
        "HSA.SSE.A.1.B"
        "1B-AP-10"     ; STEMworks
        "1B-AP-12"     ; STEMworks
        "2-AP-11"      ; STEMworks
        "2-AP-17"      ; STEMworks
        "2-AP-19"      ; STEMworks
        "3B-AP-14"     ; STEMworks
        "3B-NI-05"
        "2-DA-08"
        "P3"
        "6-8.Data and Analysis.Inference and Models" 
        "9-12.Algorithms and Programming.Control"
        )

    ("linearity"
        "6.EE.B.6" ; STEMworks
        "8.F.A.2"
        "8.F.B.4"
        "8.EE.B.5"
        "HSF.IF.A" ; STEMworks  <- recommend we keep this, and remove sub-standards
        "HSF.IF.A.2"
        "HSF.IF.B.5"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        )

    ("linearity2"
        "6.EE.B.6" ; STEMworks
        "HSF.IF.A.1"
        "HSF.IF.A.2"
        "HSF.IF.B.5"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        "OK.PA.A.2.3"
        "OK.A1.A.4.1"
        "OK.A1.F.3.1"
        )

    ("linear-regression" 
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
        "1B-DA-06" ; STEMworks 
        "1B-DA-07" ; STEMworks
        "3A-DA-11" 
        "3A-DA-12" ; STEMworks
        "3B-NI-05" 
        "9-12.Data and Analysis.Inference and Models"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        )

    ("measures-of-center"
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.5.C";STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.D";STEMworks
        "HSS.ID.A.2";STEMworks
        "6-8.Data and Analysis.Inference and Models"
        "OK.PA.D.1.2"
        )

    ("measures-of-spread" 
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.C"; STEMworks
        "HSS.ID.A.2";STEMworks
        "HSS.ID.A.1" 
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "P5" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        )

    ("method-chaining" 
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
        "OK.L1.AP.M.02"
        "OK.A1.D.2.1"
        )

    ("displaying-categorical-data"  
        "2-DA-08" 
        "3A-DA-11" 
        "P5"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        )

    ("random-samples" 
        "HSS.IC.B.3" 
        "2-DA-08" 
        "2-DA-09"
        "OK.PA.A.2.2"
        "OK.PA.D.2.2"
        "OK.L1.IC.C.02"
        )

    ("scatter-plots"
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

    ("table-methods" 
        "2-DA-08"
        "OK.A1.D.2.1"
        "OK.L1.AP.M.02"
        )

    ("threats-to-validity" 
        "HSS.IC.B.6" 
        "3B-NI-07" 
        "2-IC-21" ; STEMworks
        "P1" 
        "6-8.Data and Analysis.Collection" 
        "9-12.Data and Analysis.Inference and Models"
        "OK.L1.IC.C.02"
        )
    ))
