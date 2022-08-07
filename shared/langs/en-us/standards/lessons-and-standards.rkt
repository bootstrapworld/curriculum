#lang racket

(provide *lessons-and-standards*)

(define *lessons-and-standards*
  '(
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CORE

    ("computing-needs-all-voices"
        "OK.6.IC.C.01"
        "9-12.Impacts of Computing.Social Interactions"
        )

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

    ("functions-make-life-easier" 
        "6.EE.B.6" ; STEMworks
        "HSF.IF.B"
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
        "6-8.Algorithms and Programming.Variables" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.PA.A.1.1"
        "OK.PA.A.1.2"
        "OK.A1.F.1.3"
        "OK.A1.A.1.1"
        "OK.8.AP.PD.02"
        "OK.L2.AP.PD.03"
        "OK.MAP.5"
        "OK.MAP.6"
        "OK.3.AP.PD.01"
        )

    ("functions-examples-definitions"
        "HSF.IF.C"
        "6.EE.B.6" ; STEMworks
        )

    ("functions-dr" 
        "8.F.B"
        "7.EE.B"
        "HSF.BF.A.1"
        "HSF.IF.C"
        "OK.6.AP.A.01"
        "OK.6.AP.PD.05"
        "OK.7.AP.A.01"
        "OK.7.AP.PD.05"
        "OK.8.AP.A.01"
        "OK.8.AP.PD.04"
        "OK.8.AP.PD.05"
        "OK.PA.A.1.2"
        "OK.PA.A.1.3"
        "OK.PA.A.2"
        "OK.PA.A.2.1"
        "OK.L2.AP.PD.05"
        "OK.MAP.7"
        "OK.3.AP.PD.01"
        "OK.3.AP.PD.04"
        "OK.4.AP.PD.04"
        "OK.5.AP.PD.04"
        "MS-SEP5-2"
        "MS-SEP5-5"
        "HS-SEP5-2"
        )

    ("functions-problem-solving-together" 
        "6.EE.B.6"
        "7.EE.B"
        "7.EE.B.4"
        "8.F.B"
        "OK.PA.A.1.3"
        "OK.PA.A.2"
        "OK.PA.A.2.1"
        "OK.8.AP.A.01"
        "OK.6.AP.PD.03"
        "OK.7.AP.PD.03"
        "OK.8.AP.PD.03"
        "OK.L2.AP.PD.05"
        "2-AP-11"
        "2-AP-17"
        "2-AP-19"
        "3B-AP-14"
        "3B-AP-21"
        "OK.3.AP.PD.01"
        "OK.L2.AP.M.01"
        "MS-SEP5-2"
        "MS-SEP5-5"
        "HS-SEP5-2"
        )

    ("defining-values"
        "6-8.Algorithms and Programming.Variables"
        "6.EE.B.6"
        "7.EE.B.4"
        "HSA.SSE.A.1"
        "IA.6.EE.B.6"
        "OK.7.A.3.3"
        "OK.PA.A.3.1" 
        "OK.A1.F.3"
        "OK.A1.F.3.1"
        "OK.3.A.V.01" ; identical standard
        "OK.4.AP.V.01"; identical standard
        "OK.5.AP.V.01"; identical standard
        "1B-AP-09"
        "2-AP-11"
        )

    ("debugging" 
        "1B-AP-15"
        "OK.3.AP.PD.03"
        "OK.4.AP.PD.03"
        "OK.5.AP.PD.03" 
        "OK.L1.CS.T.01"
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
        "9-12.Algorithms and Programming.Control"
        "MS-SEP5-2"
        "MS-SEP5-5"
        "HS-SEP5-2"
        )

    ("simple-data-types"
        "OK.6.A.1.3"
        "OK.7.N.1.2"
        "OK.7.N.1.1"
        "OK.7.N.1.3"
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
        "OK.PA.GM.1"
        "OK.PA.GM.1.1"
        "OK.PA.GM.1.2"
        "OK.G.2D.1.5"
        "OK.G.RT.1.1"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-10"
        "3B-AP-14" ; STEMworks
        "3B-AP-21" ; STEMworks
        "MS-SEP5-2"
        "MS-SEP5-5"
        "HS-SEP5-2"
        "HS-SEP5-3"
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
        "OK.4.AP.A.01"
        "OK.5.AP.A.01"
        "OK.6.AP.M.01"
        "OK.8.AP.A.01"
        "OK.6.A.1.1"
        "OK.7.GM.4.1"
        "OK.7.GM.4.2"
        "OK.6.AP.PD.01"
        "3A-AP-18"
        "MS-SEP5-3"
        ) 

    ("function-composition" 
        "IA.HSF.BF.A.1.B"
        "IA.HSF.BF.A.1.C"
        "6.EE.B.6" ; STEMworks
        "HSF.BF.A.1.C"
        "HSF.BF.A" ; STEMworks
        "OK.A1.F.1.3"
        "OK.A1.F.3"
        "OK.PA.A.3.1"
        "OK.A1.F.3.2"
        "OK.A1.F.3.3"
        "OK.5.AP.A.01"
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        "3B-AP-21" ; STEMworks
        "MS-SEP5-3"
        )

    ("function-notation"
        "HSF.IF.A" ; STEMworks  <- recommend we keep this, and remove sub-standards
        "HSF.IF.A.2"
        "HSF.IF.B.5"
        )

    ("functions-can-be-linear"
        "HSF.IF.C"
        "HSF.BF.A.1" 
        "8.EE.B"
        "8.F.A.2"
        "8.F.B.4"
        "8.EE.B.5"
        "8.EE.B.6"
        "HSF.IF.B.5"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        "OK.PA.A.2.4"
        "OK.A1.F.2.1"
        )

    ("functions-vertical-line-test"
        "HSF.IF.C"
        "HSF.BF.A.1" 
        )

    ("function-definition-linear"
        "8.EE.B"
        "8.EE.B.5"
        "6.EE.B.6" ; STEMworks
        "HSF.IF.A.1"
        "HSF.IF.A.2"
        "HSF.IF.C"
        "HSF.IF.C.9"
        "OK.PA.A.2.1"
        "OK.PA.A.2.2"
        "OK.PA.A.2.3"
        "OK.A1.A.4"
        "OK.A1.A.4.1"
        "OK.A1.F.3"
        "OK.A1.F.3.1"
        "OK.PA.A.2.4"
        "OK.A1.F.2.1"
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
        "OK.PA.A.2"
        "OK.PA.A.2.1"
        "OK.MAP.3"
        "OK.3.AP.M.02"
        "OK.4.AP.M.02"
        "OK.5.AP.M.02"
        "OK.6.AP.PD.01"
        "OK.7.AP.PD.01"
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
        "OK.6.AP.M.01"
        "OK.7.AP.M.01"
        "OK.8.AP.M.01"
        "OK.6.AP.PD.01"
        "OK.7.AP.PD.01"
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
        "OK.A1.D.2.2"
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
        "OK.6.AP.C.01"
        "OK.7.AP.C.01"
        "OK.6.AP.M.01"
        "OK.7.AP.M.01"
        "OK.8.AP.M.01"
        "OK.L1.AP.A.01" 
        "3B-AP-10"
        "OK.L2.AP.M.03"
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
        "OK.3.AP.M.02"
        "OK.4.AP.M.02"
        "OK.5.AP.M.02"
        "OK.3.AP.PD.02"
        "OK.4.AP.PD.02"
        "OK.5.AP.PD.02"
        "OK.6.AP.PD.01"
        "OK.7.AP.PD.01"
        "OK.6.AP.PD.02"
        "OK.7.AP.PD.02"
        )

    ("numbers-inside-video games" 
        "OK.L1.CS.D.01"
        )

    ("order-of-operations" 
        "OK.PA.A.3"
        "OK.A1.A.3"
        "OK.7.A.4.2"
        "HSA.SSE.A.2"
        "HSA.SSE.B"
        "OK.MAP.2"
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
        "OK.L2.AP.PD.07"
        "OK.3.AP.M.02"
        "OK.4.AP.M.02"
        "OK.5.AP.M.02"
        "OK.6.AP.PD.01"
        "OK.7.AP.PD.01"
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
        "OK.7.CS.T.01"
        "OK.8.CS.T.01"
        "OK.4.AP.M.01"
        "OK.5.AP.M.01"
        "OK.6.AP.M.01"
        "OK.7.AP.M.01"
        "OK.8.AP.M.01"
        "OK.L1.AP.M.01"
        )

    ("surface-area-rect-prism"
        "6.EE.B.6" ; STEMworks
        "6.G.A.4"
        "7.G.B.6"
        "OK.PA.GM.2"
        "OK.PA.GM.2.1"
        "OK.PA.GM.2.2"
        "OK.7.AP.A.01"
        "OK.7.GM.1.1"
        "OK.G.3D.1.1"
        "OK.L1.AP.A.01" 
        "2-AP-11"  ; STEMworks
        "2-AP-17"  ; STEMworks
        "2-AP-19"  ; STEMworks
        )

    ("project-video-game"
        "2-DA-07"
        "1B-AP-09"
        "1B-AP-10"
        "1B-AP-11"
        "1B-AP-12"
        "1B-AP-13"
        "1B-AP-14"
        "1B-AP-15"
        "1B-AP-16"
        "2-AP-11"
        "2-AP-13"
        "2-AP-14"
        "2-AP-15"
        "2-AP-16"
        "2-AP-17"
        "2-AP-19"
        "3A-AP-16"
        "3A-AP-17"
        "3A-AP-18"
        "3A-AP-22"
        "3B-AP-14"
        "3B-AP-16"
        "3B-AP-21"
        "3B-AP-22"
        "3B-AP-23"
        "1B-IC-21"
        )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATA SCIENCE
    
    ("checking-your-work" 
        "2-AP-17" 
        "3B-AP-21" 
        "1B-AP-15" ; STEMworks
        "2-AP-17"  ; STEMworks
        "3B-AP-21" ; STEMworks
        "9-12.Computing Systems.Troubleshooting" 
        "6-8.Computing Systems.Troubleshooting"
        "OK.L1.IC.C.02"
        "HS-SEP5-4"
        "HS-SEP5-4"
        )

    ("choosing-your-dataset" 
        "6.SP.A.1" ; STEMworks
        "3A-AP-16" 
        "3A-AP-23" 
        "3B-AP-14" 
        "1B-AP-11" ; STEMworks
        "3A-AP-17" ; STEMworks
        "3A-DA-11" 
        "OK.L1.DA.CVT.01"
        "OK.L1.IC.C.02"
        "OK.PA.D.1"
        "OK.A1.D.1.1"
        "OK.PA.D.1.1"
        "OK.PA.A.2.2"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        "OK.8.IC.SI.01"
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
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
        "6-8.Data and Analysis.Visualization and Transformation"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        "MS-SEP4-1" ; NGSS
        "MS-SEP4-2" ; NGSS
        )
    
    ("defining-table-functions" 
        "6.EE.B.6" ; STEMworks
        "2-AP-13" 
        "2-AP-14" 
        "2-AP-17" 
        "3A-AP-17" 
        "3A-AP-18" 
        "9-12.Algorithms and Programming.Modularity" 
        "6-8.Algorithms and Programming.Modularity"
        "OK.L1.AP.M.01"
        "OK.L1.AP.M.02" 
        "OK.A1.D.2.1"
        "OK.3.AP.PD.01"
        )

    ("bar-and-pie-charts"  
        "2-DA-08" 
        "3A-DA-11" 
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        "OK.6.DA.S.01"
        "OK.7.DA.S.01"
        "6.RP.A"
        "7.RP.A"
        "7.RP.A.3"
        "7.SP.B"
        "HSS.ID.A"
        "MS-SEP4-2" ; NGSS
        )

    ("ds-intro" 
        "6.SP.A.1" ; STEMworks
        "SL.9-10.1" 
        "OK.8.DA.CVT.01"
        "OK.5.DA.IM.01"
        "MS-SEP1-1"
        "MS-SEP1-3"
        "HS-SEP1-3"
        "HS-SEP1-5"
        "HS-SEP1-9"
        )

    ("ethics-privacy-and-bias" 
        "3A-AP-16" 
        "2-IC-23" ; STEMworks
        "3A-IC-24"; STEMworks
        "3A-IC-29"; STEMworks
        "3A-IC-30"; STEMworks
        "9-12.Data and Analysis.Collection" 
        "9-12.Impacts of Computing.Culture" 
        "9-12.Impacts of Computing.Safety, Law, and Ethics"
        "OK.L1.IC.C.01"
        "OK.L1.IC.SLE.02"
        "OK.L1.IC.SLE.03"
        "OK.L2.IC.C.01"
        "OK.L2.IC.SLE.01"
        )

    ("grouped-samples"
        "6.EE.B.6" ; STEMworks
        "8.SP.A.1"
        "2-DA-08" 
        "2-DA-09" 
        "2-AP-11" 
        "OK.PA.A.2.2"
        "OK.L1.IC.C.02"
        "OK.A1.D.1.1"
        "OK.PA.D.1.1"
        "OK.8.DA.S.01"
        "OK.8.DA.CVT.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        "OK.L1.AP.A.01"
        "OK.3.AP.C.01"
        "MS-SEP4-7"
        "MS-SEP5-3"
        )

    ("histograms" 
        "6.SP.B.4" ; STEMworks
        "HSS.ID.A.3" 
        "HSS.ID.A.1" 
        "HSS.ID.A.2"
        "3A-DA-11" 
        "3B-AP-14" 
        "OK.L1.AP.PD.05"
        "OK.A1.D.1.1" 
        "OK.PA.D.1.1"
        "OK.PA.A.2.2"
        "OK.8.DA.S.01"
        "OK.7.D.1.2"
        "OK.6.D.1.3"
        "MS-SEP4-2" ; NGSS
        "MS-SEP5-1" ; NGSS
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
        "MS-SEP4-2" ; NGSS
        "MS-SEP5-1"
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
        "6-8.Data and Analysis.Inference and Models" 
        "9-12.Algorithms and Programming.Control"
        "MS-SEP4-2"
        "MS-SEP5-1"
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
        "OK.L2.DA.CVT.01"
        "OK.MAP.7"
        "OK.3.DA.IM.01"
        "OK.4.DA.IM.01"
        "MS-SEP2-2"
        "MS-SEP2-3"
        "MS-SEP2-5"
        "HS-SEP2-1"
        "HS-SEP2-3"
        "HS-SEP2-7"
        "HS-SEP4-1"
        "MS-SEP4-2"
        "HS-SEP4-3"
        "MS-SEP5-1"
        "HS-SEP5-1"
        "HS-SEP5-2"
        )

    ("measures-of-center"
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.5.C";STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.D";STEMworks
        "HSS.ID.A.2";STEMworks
        "HSS.ID.A.3"
        "6-8.Data and Analysis.Inference and Models"
        "OK.PA.D.1.2"
        "MS-SEP4-5"
        )

    ("box-plots" 
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.C"; STEMworks
        "HSS.ID.A.2";STEMworks
        "HSS.ID.A.1" 
        "HSS.ID.A.3"
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        "OK.6.D.1.3"
        "OK.6.DA.CVT.01"
        "OK.7.DA.CVT.01"
        "OK.7.D.1.2"
        "OK.8.DA.S.01"
        "OK.L2.DA.CVT.02"
        "MS-SEP4-2"
        )

    ("standard-deviation" 
        "6.SP.A"   ; STEMworks
        "6.SP.A.2" ; STEMworks
        "6.SP.B.4" ; STEMworks
        "6.SP.B.5" ; STEMworks
        "6.SP.B.5.C"; STEMworks
        "HSS.ID.A.2";STEMworks
        "HSS.ID.A.1" 
        "HSS.ID.A.2" 
        "HSS.ID.A.3"
        "1B-DA-06" ; STEMworks
        "3A-DA-11" 
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Inference and Models"
        ;"HS-SEP4-2" granular NGSS standards are not yet enabled
        "OK.6.D.1.3"
        "OK.6.DA.CVT.01"
        "OK.7.DA.CVT.01"
        "OK.7.D.1.2"
        "OK.8.DA.S.01"
        "OK.L2.DA.CVT.02"
        "MS-SEP4-5"
        "HS-SEP4-5"
        )

    ("method-chaining" 
        "1B-AP-10" ; STEMworks
        "2-AP-17" 
        "2-AP-13" 
        "3A-AP-17" 
        "3A-AP-18" 
        "9-12.Algorithms and Programming.Control" 
        "6-8.Algorithms and Programming.Control" 
        "9-12.Algorithms and Programming.Modularity"
        "OK.L1.AP.M.01"
        "OK.L1.AP.M.02"
        "OK.A1.D.2.1"
        "OK.4.AP.A.01"
        "OK.7.AP.M.01"
        "OK.8.AP.M.01"
        "OK.3.AP.C.01"
        "OK.4.AP.M.01"
        "OK.5.AP.M.01"
        "OK.4.AP.PD.03"
        "OK.5.AP.PD.03"
        )

    ("random-samples" 
        "HSS.IC.B.3" 
        "7.SP.A"
        "7.SP.A.1"
        "2-DA-08" 
        "2-DA-09"
        "OK.PA.A.2.2"
        "OK.PA.D.2.2"
        "OK.L1.IC.C.02"
        "OK.6.AP.PD.04"
        "OK.7.AP.PD.04"
        "MS-SEP4-2"
        "MS-SEP4-7"
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
        "9-12.Data and Analysis.Visualization and Transformation" 
        "6-8.Data and Analysis.Visualization and Transformation"
        "OK.PA.D.1.3"
        "OK.L1.DA.IM.01"
        "MS-SEP4-1"
        "MS-SEP4-2"
        "MS-SEP5-1"
        )

    ("table-methods" 
        "2-DA-08"
        "OK.A1.D.2.1"
        "OK.L1.AP.M.02"
        "OK.7.AP.A.01"
        "OK.L2.AP.M.03"
        )

    ("threats-to-validity" 
        "HSS.IC.B.6" 
        "3B-NI-07" 
        "2-IC-21" ; STEMworks
        "6-8.Data and Analysis.Collection" 
        "9-12.Data and Analysis.Inference and Models"
        "OK.L1.IC.C.02"
        "OK.8.IC.SI.01"
        "OK.3.DA.IM.01"
        )

    ("data-collection"
        "9-12.Data and Analysis.Collection"
        "6-8.Data and Analysis.Collection"
        "OK.A1.D.1.2"
        "OK.3.DA.CVT.01"
        "OK.4.DA.CVT.01"
        "OK.5.DA.CVT.01"
        "MS-SEP3-1"
        "MS-SEP3-2"
        "MS-SEP3-3"
        "MS-SEP3-4"
        "HS-SEP3-1"
        "HS-SEP3-4"
        )

    ("project-exploration-paper"
        "1B-DA-06"
        "1B-DA-07"
        "2-DA-08"
        "2-DA-09"
        "3A-DA-11"
        "3A-DA-12"
        "1B-AP-09"
        "1B-AP-10"
        "1B-AP-11"
        "1B-AP-12"
        "1B-AP-13"
        "1B-AP-15"
        "1B-AP-16"
        "1B-AP-17"
        "2-AP-11"
        "2-AP-12"
        "2-AP-13"
        "2-AP-14"
        "2-AP-16"
        "2-AP-17"
        "2-AP-19"
        "3A-AP-13"
        "3A-AP-14"
        "3A-AP-16"
        "3A-AP-17"
        "3A-AP-18"
        "3A-AP-22"
        "3A-AP-23"
        "3B-AP-14"
        "3B-AP-16"
        "3B-AP-21"
        "3B-AP-22"
        "3B-AP-23"
        "1B-IC-18"
        "2-IC-21"
        "3A-IC-24"
        "3A-IC-25"
        "3A-IC-29"
        "3A-IC-30"
        "3B-IC-25"
        "3B-IC-26"
        "MS-SEP1-1" ; NGSS
        "MS-SEP1-2" ; NGSS
        "MS-SEP1-4" ; NGSS
        "MS-SEP1-6" ; NGSS
        "MS-SEP1-8" ; NGSS
        "HS-SEP1-2" ; NGSS
        "HS-SEP1-3" ; NGSS
        "HS-SEP1-5" ; NGSS
        "HS-SEP1-7" ; NGSS
        "MS-SEP2-1" ; NGSS
        "MS-SEP2-2" ; NGSS
        "MS-SEP2-3" ; NGSS
        "MS-SEP2-5" ; NGSS
        "HS-SEP2-1" ; NGSS
        "HS-SEP2-3" ; NGSS
        "HS-SEP2-4" ; NGSS
        "MS-SEP3-1" ; NGSS
        "HS-SEP3-1" ; NGSS
        "HS-SEP3-5" ; NGSS
        "MS-SEP4-1" ; NGSS
        "MS-SEP4-2" ; NGSS
        "MS-SEP4-3" ; NGSS
        "MS-SEP4-4" ; NGSS
        "MS-SEP4-5" ; NGSS
        "MS-SEP4-7" ; NGSS
        "HS-SEP4-3" ; NGSS
        "MS-SEP5-1" ; NGSS
        "MS-SEP5-2" ; NGSS
        "MS-SEP5-3" ; NGSS
        "MS-SEP5-4" ; NGSS
        "HS-SEP5-2" ; NGSS
        "HS-SEP5-3" ; NGSS
        "HS-SEP5-5" ; NGSS
        "MS-SEP6-1" ; NGSS
        "MS-SEP6-2" ; NGSS
        "HS-SEP6-1" ; NGSS
        )

    ("project-research-paper"
        "1B-DA-06"
        "1B-DA-07"
        "2-DA-08"
        "2-DA-09"
        "3A-DA-11"
        "3A-DA-12"
        "1B-AP-09"
        "1B-AP-10"
        "1B-AP-11"
        "1B-AP-12"
        "1B-AP-13"
        "1B-AP-15"
        "1B-AP-16"
        "1B-AP-17"
        "2-AP-11"
        "2-AP-12"
        "2-AP-13"
        "2-AP-14"
        "2-AP-16"
        "2-AP-17"
        "2-AP-19"
        "3A-AP-13"
        "3A-AP-14"
        "3A-AP-16"
        "3A-AP-17"
        "3A-AP-18"
        "3A-AP-22"
        "3A-AP-23"
        "3B-AP-14"
        "3B-AP-16"
        "3B-AP-21"
        "3B-AP-22"
        "3B-AP-23"
        "1B-IC-18"
        "2-IC-21"
        "3A-IC-24"
        "3A-IC-25"
        "3A-IC-29"
        "3A-IC-30"
        "3B-IC-25"
        "3B-IC-26"
        "3B-NI-06"
        "MS-SEP1-1" ; NGSS
        "MS-SEP1-2" ; NGSS
        "MS-SEP1-4" ; NGSS
        "MS-SEP1-6" ; NGSS
        "MS-SEP1-8" ; NGSS
        "HS-SEP1-2" ; NGSS
        "HS-SEP1-3" ; NGSS
        "HS-SEP1-5" ; NGSS
        "HS-SEP1-7" ; NGSS
        "MS-SEP2-1" ; NGSS
        "MS-SEP2-2" ; NGSS
        "MS-SEP2-3" ; NGSS
        "MS-SEP2-5" ; NGSS
        "HS-SEP2-1" ; NGSS
        "HS-SEP2-3" ; NGSS
        "HS-SEP2-4" ; NGSS
        "MS-SEP3-1" ; NGSS
        "HS-SEP3-1" ; NGSS
        "HS-SEP3-5" ; NGSS
        "MS-SEP4-1" ; NGSS
        "MS-SEP4-2" ; NGSS
        "MS-SEP4-3" ; NGSS
        "MS-SEP4-4" ; NGSS
        "MS-SEP4-5" ; NGSS
        "MS-SEP4-7" ; NGSS
        "HS-SEP4-3" ; NGSS
        "MS-SEP5-1" ; NGSS
        "MS-SEP5-2" ; NGSS
        "MS-SEP5-3" ; NGSS
        "MS-SEP5-4" ; NGSS
        "HS-SEP5-2" ; NGSS
        "HS-SEP5-3" ; NGSS
        "HS-SEP5-5" ; NGSS
        "MS-SEP6-1" ; NGSS
        "MS-SEP6-2" ; NGSS
        "HS-SEP6-1" ; NGSS
        "MS-SEP7-1" ; NGSS
        "MS-SEP7-3" ; NGSS
        "HS-SEP7-2" ; NGSS
        "MS-SEP8-2" ; NGSS
        )   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REACTIVE

    ("re-intro-to-data-structures" 
        "1B-AP-12" 
        "1B-AP-17"
        "2-AP-11"
        "2-AP-14"
        "9-12.Algorithms and Programming.Variables"
        "6-8.Algorithms and Programming.Variables"
        )

    ("re-structures-reactors-animations" 
        "1B-AP-09" 
        "1B-AP-10"
        "1B-AP-12"
        "2-AP-10"
        "2-AP-11"
        "3B-AP-13"
        )

    ("re-functions-that-ask-questions" 
        "1B-AP-17" 
        "2-AP-14"
        "2-AP-17"
        "3B-AP-21"
        "3B-AP-22"
        "6-8.Algorithms and Programming.Control"
        )

    ("re-key-events" 
        "1B-AP-09" 
        "1B-AP-10"
        "1B-AP-12"
        "2-AP-14"
        "2-AP-17"
        )

    ("re-refactoring" 
        "1B-AP-11" 
        "1B-AP-12"
        "1B-AP-15"
        "2-AP-13"
        "2-AP-14"
        "3A-AP-15"
        "3A-AP-17"
        "6-8.Algorithms and Programming.Modularity"
        )

    ("re-your-own-drawing-functions" 
        "1B-AP-09" 
        "2-AP-14"
        "3A-AP-16"
        )

    ("re-build-your-own-animation" 
        "1B-AP-09" 
        "2-AP-12"
        "3A-AP-16"
        )

    ("re-adding-collisions" 
        "1B-AP-09" 
        "1B-AP-10"
        "3B-AP-14"
        )

    ("re-scoring" 
        "2-AP-14"
        "2-AP-17"
        "3A-AP-18"
        "3B-AP-22"
        )

    ("re-adding-levels" 
        "2-AP-12"
        "3A-AP-18"
        "3B-AP-14"
        )

    ("re-making-pong" 
        "2-AP-12"
        "2-AP-17"
        )

    ("re-nested-structures" 
        "1B-AP-11" 
        "2-AP-12"
        "2-AP-13"
        "3A-AP-15"
        "3A-AP-17"
        )

    ("re-timers" 
        "3A-AP-18"
        "3B-AP-14"
        "3B-AP-22"
        )

    ))
