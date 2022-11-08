#lang racket

(provide *standards-and-lessons*)

(define cc-states
  '("AL" "AR" "CA" "CO" "CT" "DE" "GA" "HI" "ID" "IL"
    "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MS" "MO"
    "MT" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OR"
    "PA" "RI" "SD" "TN" "UT" "VT" "WA" "WV" "WI" "WY"))

(define (all-cc-states std)
  (map (lambda (state) (string-append state "." std)) cc-states))

(define *standards-and-lessons*
  `(
    ;;;;;;;;;;;;;;;;;;;  Common Core Math Standards ;;;;;;;;;;;;;;;;;;
    ; Grade 5
    (,(all-cc-states "5.OA.A")
     "order-of-operations"
     )
    (,(all-cc-states "5.OA.A.1")
     "order-of-operations"
     )
    (,(all-cc-states "5.MD.B")
     ;"Represent and interpret data."
     ;Flannery?
     )
    (,(all-cc-states "5.MD.C")
     ;"Geometric measurement: understand concepts of volume."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.3")
     ;"Recognize volume as an attribute of solid figures and understand concepts of volume measurement."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.3.A")
     ;"A cube with side length 1 unit, called a "unit cube," is said to have "one cubic unit" of volume, and can be used to measure volume."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.5")
     ;"A solid figure which can be packed without gaps or overlaps using n unit cubes is said to have a volume of n cubic units."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.5")
     ;"Relate volume to the operations of multiplication and addition and solve real world and mathematical problems involving volume."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.5.A")
     ;"Find the volume of a right rectangular prism with whole-number side lengths by packing it with unit cubes, and show that the volume is the same as would be found by multiplying the edge lengths, equivalently by multiplying the height by the area of the base. Represent threefold whole-number products as volumes, e.g., to represent the associative property of multiplication."
     ;Rachel?
     )
    (,(all-cc-states "5.MD.C.5.B")
     ;"Apply the formulas V = l × w × h and V = b × h for rectangular prisms to find volumes of right rectangular prisms with whole-number edge lengths in the context of solving real world and mathematical problems."
     ;Rachel?
     )
    (,(all-cc-states "5.G.A")
     "hoc-winter-parley"
     )
    (,(all-cc-states "5.G.A.1")
     "coordinates"
     )
    (,(all-cc-states "5.G.A.2")
     "hoc-winter-parley"
     )
    (,(all-cc-states "5.G.B")
     "hoc-winter-parley"
     )

    ; Grade 6
    (,(all-cc-states "6.EE.B.6")
     "linear-regression"
     "grouped-samples"
     "defining-table-functions"
     "surface-area-rect-prism"
     "problem-decomposition"
     "player-animation"
     "inequalities3-sam"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-definition-linear"
     "function-composition"
     "distance-formula"
     "piecewise-functions-conditionals"
     "defining-values"
     "functions-dr"
     "functions-examples-definitions"
     "functions-make-life-easier"
     )
    (,(all-cc-states "6.EE.A.1")
     ;"Write and evaluate numerical expressions involving whole-number exponents."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.A.2")
     ;"Write, read, and evaluate expressions in which letters stand for numbers."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.A.2.A")
     ;"Write expressions that record operations with numbers and with letters standing for numbers."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.A.2.C")
     ;"Evaluate expressions at specific values of their variables. Include expressions that arise from formulas used in real-world problems. Perform arithmetic operations, including those involving whole-number exponents, in the conventional order when there are no parentheses to specify a particular order (Order of Operations)."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.A.3")
     ;"Apply the properties of operations to generate equivalent expressions."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.A.4")
     ;"Identify when two expressions are equivalent (i.e., when the two expressions name the same number regardless of which value is substituted into them)."
     ;Rachel?
     )
    (,(all-cc-states "6.EE.B")
     "inequalities1-simple"
     "inequalities2-compound"
     )
    (,(all-cc-states "6.EE.B.5")
     ;"Reason about and solve one-variable equations and inequalities."
     ;Flannery?
     )
    (,(all-cc-states "6.EE.B.8")
     "inequalities3-sam"
     "inequalities1-simple"
     )
    (,(all-cc-states "6.NS.C.6.A")
     ;"Recognize opposite signs of numbers as indicating locations on opposite sides of 0 on the number line; recognize that the opposite of the opposite of a number is the number itself, e.g., -(-3) = 3, and that 0 is its own opposite."
     ;Rachel?
     )
     (,(all-cc-states "6.NS.C.6.C")
     "hoc-winter-parley"
     )
    (,(all-cc-states "6.RP.A")
     "bar-and-pie-charts"
     "flags"
     )
    (,(all-cc-states "6.RP.A.1")
     "flags"
     )
    (,(all-cc-states "6.RP.A.3")
     "hoc-data"
     )
    (,(all-cc-states "6.RP.A.3.D")
     "flags"
     )
    (,(all-cc-states "6.G.A")
     "surface-area-rect-prism"
     )
    (,(all-cc-states "6.G.A.4")
     "surface-area-rect-prism"
     )
    (,(all-cc-states "6.SP.A")
     "measures-of-center"
     "histograms"
     "histograms2"
     "box-plots"
     )
    (,(all-cc-states "6.SP.A.1")
     "ds-intro"
     "choosing-your-dataset"
     "data-cycle"
     )
    (,(all-cc-states "6.SP.A.2")
     "measures-of-center"
     "histograms"
     "histograms2"
     "box-plots"
     "standard-deviation"
     )
    (,(all-cc-states "6.SP.A.3")
     "standard-deviation"
     "box-plots"
     )
    (,(all-cc-states "6.SP.B")
     "measures-of-center"
     "histograms2"
     "box-plots"
     "project-exploration-paper"
     "project-research-paper"
     )
    (,(all-cc-states "6.SP.B.4")
     "standard-deviation"
     "box-plots"
     "histograms2"
     "histograms"
     "project-exploration-paper"
     "project-research-paper"
     )
    (,(all-cc-states "6.SP.B.5")
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "project-exploration-paper"
     "project-research-paper"
     )
    (,(all-cc-states "6.SP.B.5.C")
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "project-exploration-paper"
     "project-research-paper"
     )
    (,(all-cc-states "6.SP.B.5.D")
     "measures-of-center"
     "project-exploration-paper"
     "project-research-paper"
     )

    ; Grade 7
    (,(all-cc-states "7.RP.A")
      "flags"
      "making-game-images"
    )
    (,(all-cc-states "7.RP.A.1")
     "flags"
     )
    (,(all-cc-states "7.RP.A.2.A")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "7.RP.A.2.B")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "7.RP.A.3")
     "hoc-data"
     )
    (,(all-cc-states "7.EE.A")
     ;"Use properties of operations to generate equivalent expressions."
     ;Rachel?
     )
    (,(all-cc-states "7.EE.A.2")
     "problem-decomposition"
     )
    (,(all-cc-states "7.EE.B")
     "problem-decomposition"
     "player-animation"
     "inequalities3-sam"
     "distance-formula"
     "piecewise-functions-conditionals"
     "functions-dr"
     )
    (,(all-cc-states "7.EE.B.4")
     "inequalities2-compound"
     "inequalities1-simple"
     "defining-values"
     "functions-dr"
     "functions-make-life-easier"
     )
    (,(all-cc-states "7.G.A")
     "hoc-winter-parley"
     )
    (,(all-cc-states "7.G.B.4")
     "functions-dr"
     )
    (,(all-cc-states "7.G.B.6")
     "surface-area-rect-prism"
     "functions-dr"
     )
    (,(all-cc-states "7.SP.B")
     "bar-and-pie-charts"
     )
    (,(all-cc-states "7.SP.A")
     "random-samples"
     )
    (,(all-cc-states "7.SP.A.1")
     "random-samples"
     "hoc-data"
     )
    (,(all-cc-states "7.SP.A.2")
     "random-samples"
     )
    (,(all-cc-states "7.SP.B")
     ;"Draw informal comparative inferences about two populations."
     ; We should do this explicitly in more lessons, post-filtering
     "project-exploration-paper"
     "project-research-paper"
     "hoc-data"
     )
    (,(all-cc-states "7.SP.B.3")
     ;"Informally assess the degree of visual overlap of two numerical data distributions with similar variabilities, measuring the difference between the centers by expressing it as a multiple of a measure of variability."
     ; We should do this explicitly in more lessons, post-filtering
     "project-exploration-paper"
     "project-research-paper"
     )
    (,(all-cc-states "7.SP.B.4")
     ;"Use measures of center and measures of variability for numerical data from random samples to draw informal comparative inferences about two populations."
     ; We should do this explicitly in more lessons, post-filtering
     "project-exploration-paper"
     "project-research-paper"
     )

    ; Grade 8
    (,(all-cc-states "8.EE.B")
     "function-definition-linear"
     "functions-can-be-linear"
     )
    (,(all-cc-states "8.EE.B.5")
     "function-definition-linear"
     "functions-can-be-linear"
     )
    (,(all-cc-states "8.F.A.1")
     "contracts"
     "functions-vertical-line-test"
     )
    (,(all-cc-states "8.F.A.2")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "8.F.A.3")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "8.F.B")
     "functions-for-character-animation"
     "functions-dr"
     "functions-make-life-easier"
     "function-definition-linear"
     "problem-decomposition"
     )
    (,(all-cc-states "8.F.B.4")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "8.F.B.5")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "8.G.A.1")
     "making-game-images"
     )
    (,(all-cc-states "8.G.B")
     "distance-formula"
     )
    (,(all-cc-states "8.G.B.7")
     "distance-formula"
     )
    (,(all-cc-states "8.G.B.8")
     "distance-formula"
     )
    (,(all-cc-states "8.SP.A.3")
     "linear-regression"
     )
    (,(all-cc-states "8.SP.A.1")
     "scatter-plots"
     "linear-regression"
     "grouped-samples"
     "correlations"
     )
    (,(all-cc-states "8.SP.A.2")
     "scatter-plots"
     "linear-regression"
     "correlations"
     )
    (,(all-cc-states "8.SP.A.3")
     "linear-regression"
     )

    ; High School
    (,(all-cc-states "HSS.IC.B.3")
     "random-samples"
     )
    (,(all-cc-states "HSN.Q.A")
     "flags"
     )
    (,(all-cc-states "HSN.Q.A")
     ;"Reason quantitatively and use units to solve problems."
     ;Modeling?
     )
    (,(all-cc-states "HSN.Q.A.1")
     ;"Use units as a way to understand problems and to guide the solution of multi-step problems; choose and interpret units consistently in formulas; choose and interpret the scale and the origin in graphs and data displays."
     ;Modeling?
     )
    (,(all-cc-states "HSN.Q.A.2")
     ;"Define appropriate quantities for the purpose of descriptive modeling."
     ;Modeling?
     )
    
    (,(all-cc-states "HSA.SSE.A.1")
     "defining-values"
     "functions-make-life-easier"
     "functions-dr"
     )
    (,(all-cc-states "HSA.SSE.A.1.A")
     "player-animation"
     "piecewise-functions-conditionals"
     )
    (,(all-cc-states "HSA.SSE.A.1.B")
     "custom-scatter-plots"
     "player-animation"
     "piecewise-functions-conditionals"
     )
    (,(all-cc-states "HSA.SSE.A.2")
     ;"Use the structure of an expression to identify ways to rewrite it."
     "order-of-operations"
     ;Rachel?
     )
    (,(all-cc-states "HSA.SSE.B")
     ;"Write expressions in equivalent forms to solve problems."
     "order-of-operations"
     ;Rachel?
     )
    (,(all-cc-states "HSA.CED.A")
     "problem-decomposition"
     "inequalities3-sam"
     "functions-dr"
     "surface-area-rect-prism"
     )
    (,(all-cc-states "HSA.CED.A.1")
     "inequalities3-sam"
     )
    (,(all-cc-states "HSA.CED.A.2")
     "inequalities3-sam"
     )
    (,(all-cc-states "HSA.CED.A.3")
     "inequalities3-sam"
     )
    ("HSA.REI.A.1"
     ;"Explain each step in solving a simple equation as following from the equality of numbers asserted at the previous step, starting from the assumption that the original equation has a solution. Construct a viable argument to justify a solution method."
     ; Rachel?
     )
    (,(all-cc-states "HSF.IF.A")
     "functions-make-life-easier"
     "function-notation"
     )
    (,(all-cc-states "HSF.IF.A.1")
     "functions-vertical-line-test"
     "contracts"
     )
    (,(all-cc-states "HSF.IF.A.2")
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     "flags"
     "contracts"
     )
    (,(all-cc-states "HSF.IF.B")
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     )
    (,(all-cc-states "HSF.IF.B.5")
     "functions-can-be-linear"
     "function-definition-linear"
     )
    (,(all-cc-states "HSF.IF.C")
     "function-definition-linear"
     "functions-vertical-line-test"
     "functions-can-be-linear"
     "functions-dr"
     "functions-examples-definitions"
     )
    (,(all-cc-states "HSF.IF.C.7.A")
     ;"Graph linear and quadratic functions and show intercepts, maxima, and minima."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.IF.C.7.E")
     ;"Graph exponential and logarithmic functions, showing intercepts and end behavior, and trigonometric functions, showing period, midline, and amplitude."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.IF.C.9")
     "function-definition-linear"
     "functions-can-be-linear"
     "problem-decomposition"
     )
    (,(all-cc-states "HSF.IF.C.9")
     "function-definition-linear"
     "functions-can-be-linear"
     )
    (,(all-cc-states "HSF.BF.A")
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     )
    (,(all-cc-states "HSF.BF.A.1")
     "inequalities2-compound"
     "inequalities1-simple"
     "function-definition-linear"
     "functions-dr"
     "problem-decomposition"
     "function-notation"
     "functions-for-character-animation"
     "defining-table-functions"
     )
    (,(all-cc-states "HSF.BF.A.1.B")
     "function-composition"
     )
    (,(all-cc-states "HSF.BF.A.1.C")
     "problem-decomposition"
     "inequalities3-sam"
     "function-composition"
     "inequalities-collision"
     )
    (,(all-cc-states "HSF.BF.B")
     "problem-decomposition"
     "inequalities3-sam"
     "inequalities-collision"
     )
    (,(all-cc-states "HSF.BF.B.4")
     ;"Find inverse functions."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.BF.B.4.A")
     ;"Solve an equation of the form f(x) = c for a simple function f that has an inverse and write an expression for the inverse."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.BF.B.4.B")
     ;"Verify by composition that one function is the inverse of another."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.BF.B.4.C")
     ;"Read values of an inverse function from a graph or a table, given that the function has an inverse."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.BF.B.4.D")
     ;"Produce an invertible function from a non-invertible function by restricting the domain."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.BF.B.5")
     ;"Understand the inverse relationship between exponents and logarithms and use this relationship to solve problems involving logarithms and exponents."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A")
     ;"Construct and compare linear, quadratic, and exponential models and solve problems."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.1")
     ;"Distinguish between situations that can be modeled with linear functions and with exponential functions."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.1.A")
     ;"Prove that linear functions grow by equal differences over equal intervals, and that exponential functions grow by equal factors over equal intervals."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.1.B")
     ;"Recognize situations in which one quantity changes at a constant rate per unit interval relative to another."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.1.C")
     ;"Recognize situations in which a quantity grows or decays by a constant percent rate per unit interval relative to another."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.2")
     ;"Construct linear and exponential functions, including arithmetic and geometric sequences, given a graph, a description of a relationship, or two input-output pairs (include reading these from a table)."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.3")
     ;"Observe using graphs and tables that a quantity increasing exponentially eventually exceeds a quantity increasing linearly, quadratically, or (more generally) as a polynomial function."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.A.4")
     ;"For exponential models, express as a logarithm the solution to abct = d where a, c, and d are numbers and the base b is 2, 10, or e; evaluate the logarithm using technology."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.B")
     ;"Interpret expressions for functions in terms of the situation they model."
     ;Emmanuel?
     )
    (,(all-cc-states "HSF.LE.B.5")
     ;"Interpret the parameters in a linear or exponential function in terms of a context."
     ;Emmanuel?
     )
    (,(all-cc-states "HSS.ID.A")
     "bar-and-pie-charts"
     "measures-of-center"
     "histograms"
     "histograms2"
     "box-plots"
     )
    (,(all-cc-states "HSS.ID.A.1")
     "standard-deviation"
     "box-plots"
     "histograms2"
     "histograms"
     )
    (,(all-cc-states "HSS.ID.A.2")
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "histograms"
     )
    (,(all-cc-states "HSS.ID.A.3")
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "histograms2"
     "histograms"
     )
    (,(all-cc-states "HSS.ID.B")
     ;"Summarize, represent, and interpret data on two categorical and quantitative variables."
     "scatter-plots"
     "correlations"
     )
    (,(all-cc-states "HSS.ID.B.6")
     "scatter-plots"
     "correlations"
     "hoc-data"
     )
    (,(all-cc-states "HSS.ID.B.6.A")
     "linear-regression"
     )
    (,(all-cc-states "HSS.ID.B.6.C")
     "linear-regression"
     )
    (,(all-cc-states "HSS.ID.C")
     "linear-regression"
     )
    (,(all-cc-states "HSS.ID.C.7")
     "linear-regression"
     )
    (,(all-cc-states "HSS.ID.C.8")
     "scatter-plots"
     "linear-regression"
     "correlations"
     )
    (,(all-cc-states "HSS.ID.C.9")
     "linear-regression"
     "correlations"
     )
    (,(all-cc-states "HSS.ID.B.6.A")
     "linear-regression"
     )
    (,(all-cc-states "HSS.ID.B.6.C")
     "linear-regression"
     )
    (,(all-cc-states "HSS.IC.A")
     "random-samples"
     )
    (,(all-cc-states "HSS.IC.A.1")
     "random-samples"
     )
    (,(all-cc-states "HSS.IC.A.2")
     ;"Decide if a specified model is consistent with results from a given data-generating process, e.g., using simulation."
     ;Modeling?
     )
    (,(all-cc-states "HSS.IC.B")
     "data-collection"
     "hoc-data"
     )
    (,(all-cc-states "HSS.IC.B.3")
     "data-collection"
     )
    (,(all-cc-states "HSS.IC.B.4")
     "data-collection"
     )
    (,(all-cc-states "HSS.IC.B.6")
     "threats-to-validity"
     )
    (,(all-cc-states "HSS.CP.A.1")
     "inequalities2-compound"
     )
    (,(all-cc-states "HSS.CP.B.9")
     "combinatorics-combination"
     "combinatorics-permutation"
     )

    ;;;;;;;;;;;;;;;;;;;  Common Core ELA Standards ;;;;;;;;;;;;;;;;;;
    (,(all-cc-states "SL.9-10.1")
     "ds-intro"
     )

    ;;;;;;;;;;;;;;;;;;;  Oklahoma Standards ;;;;;;;;;;;;;;;;;;
    ("OK.SP.1.5"
     "combinatorics-combination"
     "combinatorics-permutation"
     )
    ("OK.A1.D.1.2"
     "data-collection"
     )
    ("OK.3.DA.CVT.01"
     "data-collection"
     )
    ("OK.4.DA.CVT.01"
     "data-collection"
     )
    ("OK.5.DA.CVT.01"
     "data-collection"
     )
    ("OK.PA.D.2.2"
     "random-samples"
     )
    ("OK.6.AP.PD.04"
     "random-samples"
     )
    ("OK.7.AP.PD.04"
     "random-samples"
     )
    ("OK.PA.D.1.2"
     "measures-of-center"
     )
    ("OK.6.DA.CVT.01"
     "standard-deviation"
     "box-plots"
     )
    ("OK.7.DA.CVT.01"
     "standard-deviation"
     "box-plots"
     )
    ("OK.L2.DA.CVT.02"
     "standard-deviation"
     "box-plots"
     )
    ("OK.L2.DA.CVT.01"
     "linear-regression"
     )
    ("OK.3.DA.IM.01"
     "threats-to-validity"
     "linear-regression"
     )
    ("OK.4.DA.IM.01"
     "linear-regression"
     )
    ("OK.A2.F.1.8"
     "custom-scatter-plots"
     )
    ("OK.8.DA.CVT.01"
     "grouped-samples"
     "ds-intro"
     )
    ("OK.5.DA.IM.01"
     "ds-intro"
     )
    ("OK.L1.IC.C.01"
     "ethics-privacy-and-bias"
     )
    ("OK.L1.IC.SLE.02"
     "ethics-privacy-and-bias"
     )
    ("OK.L1.IC.SLE.03"
     "ethics-privacy-and-bias"
     )
    ("OK.L2.IC.C.01"
     "ethics-privacy-and-bias"
     )
    ("OK.L2.IC.SLE.01"
     "ethics-privacy-and-bias"
     )
    ("OK.3.AP.C.01"
     "method-chaining"
     "grouped-samples"
     )
    ("OK.PA.D.1.3"
     "scatter-plots"
     "linear-regression"
     "correlations"
     )
    ("OK.L1.DA.IM.01"
     "scatter-plots"
     "linear-regression"
     "correlations"
     )
    ("OK.A1.D.2.1"
     "table-methods"
     "method-chaining"
     "defining-table-functions"
     )
    ("OK.6.DA.S.01"
     "bar-and-pie-charts"
     )
    ("OK.7.DA.S.01"
     "bar-and-pie-charts"
     )
    ("OK.L1.AP.PD.05"
     "histograms2"
     "histograms"
     )
    ("OK.L1.DA.CVT.01"
     "choosing-your-dataset"
     )
    ("OK.PA.D.1"
     "choosing-your-dataset"
     )
    ("OK.A1.D.1.1"
     "histograms2"
     "histograms"
     "grouped-samples"
     "choosing-your-dataset"
     )
    ("OK.PA.D.1.1"
     "histograms2"
     "histograms"
     "grouped-samples"
     "choosing-your-dataset"
     )
    ("OK.8.DA.S.01"
     "standard-deviation"
     "box-plots"
     "histograms2"
     "histograms"
     "grouped-samples"
     "bar-and-pie-charts"
     "choosing-your-dataset"
     )
    ("OK.7.D.1.2"
     "standard-deviation"
     "box-plots"
     "histograms2"
     "histograms"
     "grouped-samples"
     "bar-and-pie-charts"
     "choosing-your-dataset"
     )
    ("OK.6.D.1.3"
     "standard-deviation"
     "box-plots"
     "histograms2"
     "histograms"
     "grouped-samples"
     "bar-and-pie-charts"
     "choosing-your-dataset"
     )
    ("OK.8.IC.SI.01"
     "threats-to-validity"
     "choosing-your-dataset"
     )
    ("OK.3.AP.PD.02"
     "making-game-images"
     )
    ("OK.4.AP.PD.02"
     "making-game-images"
     )
    ("OK.5.AP.PD.02"
     "making-game-images"
     )
    ("OK.6.AP.PD.02"
     "making-game-images"
     )
    ("OK.7.AP.PD.02"
     "making-game-images"
     )
    ("OK.PA.A.3"
     "order-of-operations"
     )
    ("OK.A1.A.3"
     "order-of-operations"
     )
    ("OK.7.A.4.2"
     "order-of-operations"
     )
    ("OK.MAP.2"
     "order-of-operations"
     )
    ("OK.L2.AP.PD.07"
     "player-animation"
     )
    ("OK.A1.A.3.1"
     "problem-decomposition"
     )
    ("OK.7.CS.T.01"
     "problem-decomposition"
     )
    ("OK.8.CS.T.01"
     "problem-decomposition"
     )
    ("OK.4.AP.M.01"
     "method-chaining"
     "problem-decomposition"
     )
    ("OK.5.AP.M.01"
     "method-chaining"
     "problem-decomposition"
     )
    ("OK.PA.GM.2"
     "surface-area-rect-prism"
     )
    ("OK.PA.GM.2.1"
     "surface-area-rect-prism"
     )
    ("OK.PA.GM.2.2"
     "surface-area-rect-prism"
     )
    ("OK.7.GM.1.1"
     "surface-area-rect-prism"
     )
    ("OK.G.3D.1.1"
     "surface-area-rect-prism"
     )
    ("OK.L1.IC.C.02"
     "threats-to-validity"
     "random-samples"
     "grouped-samples"
     "choosing-your-dataset"
     "checking-your-work"
     )
    ("OK.PA.A.2.2"
     "random-samples"
     "histograms2"
     "histograms"
     "grouped-samples"
     "choosing-your-dataset"
     "function-definition-linear"
     "functions-can-be-linear"
     )
    ("OK.PA.A.2.4"
     "function-definition-linear"
     "functions-can-be-linear"
     )
    ("OK.A1.F.2.1"
     "function-definition-linear"
     "functions-can-be-linear"
     )
    ("OK.PA.A.2.3"
     "function-definition-linear"
     )
    ("OK.A1.A.4"
     "function-definition-linear"
     )
    ("OK.A1.A.4.1"
     "function-definition-linear"
     )
    ("OK.MAP.3"
     "functions-for-character-animation"
     )
    ("OK.3.AP.M.02"
     "player-animation"
     "making-game-images"
     "functions-for-character-animation"
     )
    ("OK.4.AP.M.02"
     "player-animation"
     "making-game-images"
     "functions-for-character-animation"
     )
    ("OK.5.AP.M.02"
     "player-animation"
     "making-game-images"
     "functions-for-character-animation"
     )
    ("OK.7.AP.PD.01"
     "player-animation"
     "making-game-images"
     "inequalities-collision"
     "functions-for-character-animation"
     )
    ("OK.A1.A.2"
     "inequalities3-sam"
     )
    ("OK.6.AP.C.01"
     "inequalities3-sam"
     )
    ("OK.7.AP.C.01"
     "inequalities3-sam"
     )
    ("OK.L1.AP.A.01"
     "grouped-samples"
     "surface-area-rect-prism"
     "inequalities3-sam"
     )
    ("OK.L2.AP.M.03"
     "table-methods"
     "inequalities3-sam"
     )
    ("OK.6.A.3.1"
     "inequalities2-compound"
     "inequalities1-simple"
     )
    ("OK.PA.A.4.3"
     "inequalities3-sam"
     "inequalities2-compound"
     "inequalities1-simple"
     )
    ("OK.A1.A.2.2"
     "inequalities3-sam"
     "inequalities2-compound"
     )
    ("OK.A1.D.2.2"
     "inequalities2-compound"
     )
    ("OK.6.AP.A.01"
     "functions-dr"
     )
    ("OK.6.AP.PD.05"
     "functions-dr"
     )
    ("OK.7.AP.A.01"
     "table-methods"
     "surface-area-rect-prism"
     "simple-data-types"
     "functions-dr"
     )
    ("OK.7.AP.PD.05"
     "functions-dr"
     )
    ("OK.8.AP.A.01"
     "making-game-images"
     "functions-for-character-animation"
     "flags"
     "functions-dr"
     )
    ("OK.8.AP.PD.04"
     "functions-dr"
     )
    ("OK.8.AP.PD.05"
     "functions-dr"
     )
    ("OK.PA.A.1.3"
     "functions-dr"
     )
    ("OK.PA.A.2"
     "functions-for-character-animation"
     "functions-dr"
     )
    ("OK.PA.A.2.1"
     "functions-for-character-animation"
     "function-definition-linear"
     "functions-can-be-linear"
     "functions-dr"
     )
    ("OK.L2.AP.PD.05"
     "functions-dr"
     )
    ("OK.MAP.7"
     "linear-regression"
     "functions-dr"
     )
    ("OK.3.AP.PD.04"
     "functions-dr"
     )
    ("OK.4.AP.PD.04"
     "functions-dr"
     )
    ("OK.5.AP.PD.04"
     "functions-dr"
     )
    ("OK.6.AP.PD.03"
     )
    ("OK.7.AP.PD.03"
     )
    ("OK.8.AP.PD.03"
     )
    ("OK.L2.AP.M.01"
     )
    ("OK.7.A.3.3"
     "inequalities3-sam"
     "inequalities2-compound"
     "inequalities1-simple"
     "defining-values"
     )
    ("OK.PA.A.3.1"
     "function-composition"
     "defining-values"
     )
    ("OK.A1.F.3"
     "function-definition-linear"
     "function-composition"
     "defining-values"
     )
    ("OK.A1.F.3.1"
     "function-definition-linear"
     "defining-values"
     )
    ("OK.3.A.V.01"
     "defining-values"
     )
    ("OK.4.AP.V.01"
     "defining-values"
     )
    ("OK.5.AP.V.01"
     "defining-values"
     )
    ("OK.PA.A.1.2"
     "functions-for-character-animation"
     "functions-dr"
     "functions-make-life-easier"
     )
    ("OK.A1.A.1.1"
     "functions-make-life-easier"
     )
    ("OK.8.AP.PD.02"
     "functions-make-life-easier"
     )
    ("OK.L2.AP.PD.03"
     "functions-make-life-easier"
     )
    ("OK.MAP.5"
     "functions-make-life-easier"
     )
    ("OK.MAP.6"
     "functions-make-life-easier"
     )
    ("OK.3.AP.PD.01"
     "defining-table-functions"
     "functions-dr"
     "functions-make-life-easier"
     )
    ("OK.6.A.1.1"
     "flags"
     "coordinates"
     )
    ("OK.L1.CS.D.01"
     "numbers-inside-video games"
     "coordinates"
     )
    ("OK.PA.GM.1"
     "distance-formula"
     )
    ("OK.PA.GM.1.1"
     "distance-formula"
     )
    ("OK.PA.GM.1.2"
     "inequalities-collision"
     "distance-formula"
     )
    ("OK.G.2D.1.5"
     "inequalities-collision"
     "distance-formula"
     )
    ("OK.G.RT.1.1"
     "inequalities-collision"
     "distance-formula"
     )
    ("OK.A1.F.3.2"
     "function-composition"
     )
    ("OK.A1.F.3.3"
     "function-composition"
     )
    ("OK.MAP.1"
     "flags"
     )
    ("OK.MAP.4"
     "flags"
     )
    ("OK.PA.A.4"
     "flags"
     )
    ("OK.3.AP.A.01"
     "flags"
     )
    ("OK.3.AP.M.01"
     "flags"
     )
    ("OK.4.AP.C.01"
     "flags"
     )
    ("OK.4.AP.A.01"
     "method-chaining"
     "flags"
     )
    ("OK.5.AP.A.01"
     "function-composition"
     "flags"
     )
    ("OK.6.AP.M.01"
     "problem-decomposition"
     "inequalities3-sam"
     "inequalities-collision"
     "flags"
     )
    ("OK.7.GM.4.1"
     "making-game-images"
     "flags"
     )
    ("OK.7.GM.4.2"
     "making-game-images"
     "flags"
     )
    ("OK.6.AP.PD.01"
     "player-animation"
     "making-game-images"
     "inequalities-collision"
     "functions-for-character-animation"
     "flags"
     )
    ("OK.7.AP.M.01"
     "method-chaining"
     "problem-decomposition"
     "inequalities3-sam"
     "inequalities-collision"
     )
    ("OK.8.AP.M.01"
     "method-chaining"
     "problem-decomposition"
     "inequalities3-sam"
     "inequalities-collision"
     )
    ("OK.L1.AP.M.01"
     "method-chaining"
     "custom-scatter-plots"
     "defining-table-functions"
     "problem-decomposition"
     "piecewise-functions-conditionals"
     )
    ("OK.L1.AP.M.02"
     "table-methods"
     "method-chaining"
     "custom-scatter-plots"
     "defining-table-functions"
     "piecewise-functions-conditionals"
     )
    ("OK.6.A.1.3"
     "simple-data-types"
     )
    ("OK.7.N.1.2"
     "simple-data-types"
     )
    ("OK.7.N.1.1"
     "simple-data-types"
     )
    ("OK.7.N.1.3"
     "simple-data-types"
     )
    ("OK.8.AP.C.01"
     "simple-data-types"
     )
    ("OK.3.AP.PD.03"
     "flags"
     "debugging"
     )
    ("OK.4.AP.PD.03"
     "method-chaining"
     "debugging"
     )
    ("OK.5.AP.PD.03"
     "method-chaining"
     "debugging"
     )
    ("OK.L1.CS.T.01"
     "debugging"
     )
    ("OK.A1.F.1.2"
     "contracts"
     )
    ("OK.PA.A.1.1"
     "player-animation"
     "piecewise-functions-conditionals"
     "functions-make-life-easier"
     "contracts"
     )
    ("OK.A1.F.1.3"
     "function-composition"
     "functions-make-life-easier"
     "contracts"
     )
    ("OK.A1.F.1.4"
     "custom-scatter-plots"
     "contracts"
     )
    ("OK.5.GM.1.1"
     "contracts"
     )
    ("OK.6.GM.2.2"
     "contracts"
     )
    ("OK.G.2D.1.8"
     "contracts"
     )
    ("OK.6.IC.C.01"
     "computing-needs-all-voices"
     )

    ;;;;;;;;;;;;;;; MA Digital Literacy Standards ;;;;;;;;
    ("MA.3-5.CAS.b.2"
     "making-game-images"
    )
    ("MA.3-5.DTC.c.5"
     ;"Create an artifact that answers a research question and clearly communicates thoughts and ideas."
     ; TODO(Flannery): do any of the social studies lessons align here?
    )
    ("MA.3-5.CT.a.2"
     ;"Organize information in different ways to make it more useful/relevant (e.g., sorting, tables)."
     ; TODO(Flannery): do any of the social studies lessons align here?
    )
    ("MA.3-5.CT.b.2"
      ;"Recognize that different solutions exist for the same problem (or sub-problem)."
    )
    ("MA.3-5.CT.c.2"
     "Individually and collaboratively collect and manipulate data to answer a question using a variety of computing methods (e.g., sorting, totaling, averaging) and tools (such as a spreadsheet) to collect, organize, graph, and analyze data."
    )
    ("MA.3-5.CT.d.2"
     "Use arithmetic operators, conditionals, and repetition in programs."
    )
    ("MA.3-5.CT.d.3"
      "Use interactive debugging to detect and correct simple program errors."
    )
    ("MA.3-5.CT.e.1"
     ;"Individually and collaboratively create a simple model of a system (e.g., water cycle, solar system) and explain what the model shows and does not show."
     ; MODELING!!
    )
    ("MA.3-5.CT.e.2"
     ;"Identify the concepts, features, and behaviors illustrated by a simulation (e.g., object motion, weather, ecosystem, predator/prey) and those that were not included."
     ; MODELING!!
    )
    ("MA.3-5.CT.e.3"
     ;"Individually and collaboratively use data from a simulation to answer a question."
     ; MODELING!!
    )
    ("MA.6-8.CAS.b.1"
     "making-game-images"
    )
    ("MA.6-8.CAS.c.4"
     "measures-of-center"
     "threats-to-validity"
    )
    ("MA.6-8.DTC.a.4"
     "making-game-images"
     "functions-for-character-animation"
     "inequalities3-sam"
     "inequalities-collision"
     "distance-formula"
     "player-animation"
     "project-video-game"
    )
    ("MA.6-8.DTC.a.5"
     "data-collection"
    )
    ("MA.6-8.DTC.b.1"
     "project-research-paper"
    )
    ("MA.6-8.DTC.c.4"
     "project-research-paper"
    )
    ("MA.6-8.CT.a.2"
     "functions-make-life-easier"
     "functions-dr"
     "functions-for-character-animation"
     "problem-decomposition"
     "inequalities1-simple"
     "inequalities2-compound"
     "inequalities3-sam"
     "re-refactoring"
     "re-structures-reactors-animations"
     "re-nested-structures"
     "re-intro-to-data-structures"
     "re-functions-that-ask-questions"
     "re-key-events"
     "re-timers"
     "re-scoring"
    )
    ("MA.6-8.CT.b.1"
     "piecewise-functions-conditionals"
     "player-animation"
     "table-methods"
     "codap-transformers-1"
     "codap-transformers-2"
     "defining-table-functions"
    )
    ("MA.6-8.CT.b.2"
     "functions-make-life-easier"
     "functions-dr"
     "functions-for-character-animation"
     "problem-decomposition"
     "inequalities1-simple"
     "inequalities2-compound"
     "inequalities3-sam"
     "re-refactoring"
     "re-structures-reactors-animations"
     "re-nested-structures"
     "re-intro-to-data-structures"
     "re-functions-that-ask-questions"
     "re-key-events"
     "re-timers"
     "re-scoring"
    )
    ("MA.6-8.CT.b.3"
     "problem-decomposition"
     "inequalities-collision"
    )
    ("MA.6-8.CT.b.5"
     "inequalities3-sam"
    )
    ("MA.6-8.CT.c.4"
     "table-methods"
     "codap-transformers-1"
     "codap-transformers-2"
    )
    ("MA.6-8.CT.c.5"
     "data-collection"
    )
    ("MA.6-8.CT.d.2"
     "functions-make-life-easier"
     "functions-dr"
     "functions-for-character-animation"
     "problem-decomposition"
     "inequalities1-simple"
     "inequalities2-compound"
     "inequalities3-sam"
     "re-refactoring"
     "re-structures-reactors-animations"
     "re-nested-structures"
     "re-intro-to-data-structures"
     "re-functions-that-ask-questions"
     "re-key-events"
     "re-timers"
     "re-scoring"
    )
    ("MA.6-8.CT.d.4"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "codap-transformers-1"
     "codap-transformers-2"
     "piecewise-functions-conditionals"
     "player-animation"
    )
    ("MA.6-8.CT.d.5"
     "functions-make-life-easier"
     "functions-dr"
     "functions-for-character-animation"
     "problem-decomposition"
     "inequalities1-simple"
     "inequalities2-compound"
     "inequalities3-sam"
     "re-refactoring"
     "re-structures-reactors-animations"
     "re-nested-structures"
     "re-intro-to-data-structures"
     "re-functions-that-ask-questions"
     "re-key-events"
     "re-timers"
     "re-scoring"
    )
    ("MA.6-8.CT.d.6"
     "debugging"
    )
    ("MA.6-8.CT.e.1"
     ;"Create a model of a real-world system and explain why some details, features and behaviors were required in the model and why some could be ignored."
     ; MODELING!
    )
    ("MA.6-8.CT.e.2"
     ;"Use and modify simulations to analyze and illustrate a concept in depth (e.g., light rays/mechanical waves interaction with materials, genetic variation)."
     ; MODELING!
    )
    ("MA.6-8.CT.e.3"
     ;"Select and use computer simulations, individually and collaboratively, to gather, view, analyze, and report results for content-related problems (e.g., migration, trade, cellular function)."
     ; MODELING!
    )
    ("MA.9-12.DTC.a.1"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
    )
    ("MA.9-12.DTC.c.1"
     "ds-intro"
     "project-research-paper"
     "project-exploration-paper"
    )
    ("MA.9-12.DTC.c.4"
     "data-collection"
    )
    ("MA.9-12.DTC.c.5"
     "project-research-paper"
     "project-exploration-paper"
    )
    ("MA.9-12.CT.a.1"
     "problem-decomposition"
     "inequalities-collision"
     "re-nested-structures"
    )
    ("MA.9-12.CT.b.2"
     "functions-make-life-easier"
     "functions-dr"
     "functions-for-character-animation"
     "problem-decomposition"
     "inequalities1-simple"
     "inequalities2-compound"
     "inequalities3-sam"
     "re-refactoring"
     "re-structures-reactors-animations"
     "re-nested-structures"
     "re-intro-to-data-structures"
     "re-functions-that-ask-questions"
     "re-key-events"
     "re-timers"
     "re-scoring"
    )
    ("MA.9-12.CT.b.3"
     ;"Explain how a recursive solution to a problem repeatedly applies the same solution to smaller instances of the problem."
     ; I hope to god we teach this someday
    )
    ("MA.9-12.CT.c.2"
     "codap-transformers-1"
     "codap-transformers-2"
     "table-methods"
     "defining-table-functions"
    )
    ("MA.9-12.CT.c.3"
     "bar-and-pie-charts"
     "codap-bar-charts"
     "codap-exploring"
     "histograms"
     "histograms2"
     "box-plots"
     "custom-scatter-plots"
     "scatter-plots"
     "correlations"
     "linear-regression"
    )
    ("MA.9-12.CT.c.4"
     "project-research-paper"
     "project-exploration-paper"
     "linear-regression"
     "histograms2"
     "measures-of-center"
    )
    ("MA.9-12.CT.d.1"
     "project-research-paper"
    )
    ("MA.9-12.CT.d.3"
     "table-methods"
     "defining-table-functions"
     "codap-transformers-1"
     "codap-transformers-2"
    )
    ("MA.9-12.CT.d.5"
     "table-methods"
     "defining-table-functions"
     "codap-transformers-1"
     "codap-transformers-2"
    )
    ("MA.9-12.CT.d.6"
     "piecewise-functions-conditionals"
     "player-animation"
     "re-key-events"
    )
    ("MA.9-12.CT.d.7"
     "order-of-operations"
    )
    ("MA.9-12.CT.d.8"
     "project-video-game"
     "project-research-paper"
     "project-exploration-paper"
     "flags"
    )
    ("MA.9-12.CT.d.10"
     "project-video-game"
     "project-research-paper"
     "project-exploration-paper"
     "flags"
    )
    ("MA.9-12.CT.d.11"
     "debugging"
    )
    ("MA.9-12.CT.d.12"
     "functions-dr"
    )
    ("MA.9-12.CT.e.1"
     ;"Create models and simulations to help formulate, test, and refine hypotheses."
     ; MODELING!
    )
    ("MA.9-12.CT.e.2"
     ;"Form a model from a hypothesis generated from research and run a simulation to collect and analyze data to test that hypothesis."
     ; MODELING!
    )

    ;;;;;;;;;;;;;;;;;;;  CSTA Standards ;;;;;;;;;;;;;;;;;;
    ("1B-AP-12"
     "hoc-winter-parley"
     )
    ("1B-AP-15"
     "hoc-winter-parley"
     )
    ("1B-AP-17"
     "re-functions-that-ask-questions"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("1B-DA-07"
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "linear-regression"
     "hoc-data"
     )
    ("1B-IC-18"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("1B-DA-06"
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "standard-deviation"
     "box-plots"
     "linear-regression"
     "histograms2"
     "correlations"
     )
    ("2-DA-09"
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "random-samples"
     "grouped-samples"
     "correlations"
     )
    ("2-DA-08"
     "project-research-paper"
     "project-exploration-paper"
     "table-methods"
     "random-samples"
     "custom-scatter-plots"
     "grouped-samples"
     "bar-and-pie-charts"
     )
    ("2-AP-12"
     "re-nested-structures"
     "re-making-pong"
     "re-adding-levels"
     "re-build-your-own-animation"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("2-AP-10"
     "re-structures-reactors-animations"
     )
    ("2-IC-21"
     "project-research-paper"
     "project-exploration-paper"
     "threats-to-validity"
     )
    ("2-IC-23"
     "ethics-privacy-and-bias"
     )
    ("3A-IC-24"
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3A-IC-29"
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3A-IC-30"
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3A-AP-13"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3A-AP-14"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3A-IC-25"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3B-IC-25"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3B-IC-26"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3B-NI-05"
     "scatter-plots"
     "linear-regression"
     "custom-scatter-plots"
     "correlations"
     )
    ("3B-NI-07"
     "threats-to-validity"
     "correlations"
     )
    ("3B-NI-06"
     "project-research-paper"
     )
    ("3B-AP-13"
     "re-structures-reactors-animations"
     )
    ("3A-AP-15"
     "re-nested-structures"
     "re-refactoring"
     )
    ("3A-DA-12"
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "linear-regression"
     )
    ("3A-AP-23"
     "project-research-paper"
     "project-exploration-paper"
     "choosing-your-dataset"
     )
    ("3A-DA-09"
     "hoc-winter-parley"
     )
    ("3A-DA-11"
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "standard-deviation"
     "box-plots"
     "linear-regression"
     "histograms2"
     "histograms"
     "bar-and-pie-charts"
     "choosing-your-dataset"
     )
    ("1B-AP-14"
     "project-video-game"
     "making-game-images"
     )
    ("2-AP-16"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "making-game-images"
     )
    ("3A-AP-20"
     "making-game-images"
     )
    ("1B-IC-21"
     "project-video-game"
     "making-game-images"
     )
    ("3B-AP-22"
     "re-timers"
     "re-scoring"
     "re-functions-that-ask-questions"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "player-animation"
     )
    ("1B-AP-11"
     "re-nested-structures"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "choosing-your-dataset"
     "project-video-game"
     "problem-decomposition"
     )
    ("2-AP-13"
     "re-nested-structures"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "defining-table-functions"
     "project-video-game"
     "problem-decomposition"
     )
    ("3A-AP-17"
     "re-nested-structures"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "defining-table-functions"
     "choosing-your-dataset"
     "project-video-game"
     "problem-decomposition"
     )
    ("2-DA-07"
     "project-video-game"
     )
    ("1B-AP-13"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("1B-AP-16"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("2-AP-15"
     "project-video-game"
     )
    ("3A-AP-22"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("3B-AP-16"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("3B-AP-23"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("1B-AP-10"
     "re-adding-collisions"
     "re-key-events"
     "re-structures-reactors-animations"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "custom-scatter-plots"
     "project-video-game"
     "player-animation"
     "functions-for-character-animation"
     "piecewise-functions-conditionals"
     )
    ("1B-AP-12"
     "re-refactoring"
     "re-key-events"
     "re-structures-reactors-animations"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     "custom-scatter-plots"
     "project-video-game"
     "player-animation"
     "making-game-images"
     "piecewise-functions-conditionals"
     )
    ("1B-AP-09"
     "re-adding-collisions"
     "re-build-your-own-animation"
     "re-your-own-drawing-functions"
     "re-key-events"
     "re-structures-reactors-animations"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "defining-values"
     )
    ("1B-AP-15"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "checking-your-work"
     "project-video-game"
     "debugging"
     "functions-make-life-easier"
     )
    ("2-AP-11"
     "re-structures-reactors-animations"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     "custom-scatter-plots"
     "grouped-samples"
     "project-video-game"
     "surface-area-rect-prism"
     "problem-decomposition"
     "player-animation"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-composition"
     "distance-formula"
     "simple-data-types"
     "piecewise-functions-conditionals"
     "defining-values"
     "functions-make-life-easier"
     )
    ("2-AP-14"
     "re-scoring"
     "re-your-own-drawing-functions"
     "re-refactoring"
     "re-key-events"
     "re-functions-that-ask-questions"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     "defining-table-functions"
     "project-video-game"
     "functions-make-life-easier"
     )
    ("2-AP-17"
     "re-making-pong"
     "re-scoring"
     "re-key-events"
     "re-functions-that-ask-questions"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "custom-scatter-plots"
     "defining-table-functions"
     "checking-your-work"
     "project-video-game"
     "surface-area-rect-prism"
     "problem-decomposition"
     "player-animation"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-composition"
     "distance-formula"
     "piecewise-functions-conditionals"
     "functions-make-life-easier"
     )
    ("2-AP-19"
     "project-research-paper"
     "project-exploration-paper"
     "custom-scatter-plots"
     "project-video-game"
     "surface-area-rect-prism"
     "problem-decomposition"
     "player-animation"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-composition"
     "distance-formula"
     "piecewise-functions-conditionals"
     "functions-make-life-easier"
     )
    ("3B-AP-14"
     "re-timers"
     "re-adding-levels"
     "re-adding-collisions"
     "project-research-paper"
     "project-exploration-paper"
     "custom-scatter-plots"
     "histograms2"
     "histograms"
     "choosing-your-dataset"
     "project-video-game"
     "problem-decomposition"
     "player-animation"
     "inequalities-collision"
     "functions-for-character-animation"
     "distance-formula"
     "piecewise-functions-conditionals"
     "functions-make-life-easier"
     )
    ("3B-AP-21"
     "re-functions-that-ask-questions"
     "project-research-paper"
     "project-exploration-paper"
     "checking-your-work"
     "project-video-game"
     "problem-decomposition"
     "player-animation"
     "inequalities-collision"
     "functions-for-character-animation"
     "function-composition"
     "distance-formula"
     "piecewise-functions-conditionals"
     "functions-make-life-easier"
     )
    ("3B-AP-10"
     "inequalities3-sam"
     "inequalities2-compound"
     "inequalities1-simple"
     "distance-formula"
     )
    ("3A-AP-16"
     "re-build-your-own-animation"
     "re-your-own-drawing-functions"
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     "choosing-your-dataset"
     "project-video-game"
     "player-animation"
     "functions-for-character-animation"
     )
    ("3A-AP-18"
     "re-timers"
     "re-adding-levels"
     "re-scoring"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "defining-table-functions"
     "project-video-game"
     "making-game-images"
     "flags"
     )

    ;;;;;;;;;;;;;;;;;;;  K-12 CS Frameworks ;;;;;;;;;;;;;;;;;;
    ("6-8.Algorithms and Programming.Control"
     "re-intro-to-data-structures"
     "defining-values"
     "functions-dr"
     "inequalities3-sam"
     "inequalities-collision"
     "functions-for-character-animation"
     "re-functions-that-ask-questions"
     "re-refactoring"
     "re-key-events"
     "re-timers"
     "re-timers"
     "method-chaining"
     "codap-transformers-1"
     "codap-transformers-2"
     )
    ("6-8.Data and Analysis.Collection"
     "data-collection"
     "threats-to-validity"
     )
    ("6-8.Data and Analysis.Visualization and Transformation"
     "scatter-plots"
     "correlations"
     "linear-regression"
     )
    ("6-8.Data and Analysis.Inference and Models"
     "standard-deviation"
     "box-plots"
     "measures-of-center"
     "custom-scatter-plots"
     "choosing-your-dataset"
     )
    ("6-8.Computing Systems.Troubleshooting"
     "checking-your-work"
     )
    ("6-8.Computing Systems.Devices"
     "hoc-data"
     )
    ("6-8.Algorithms and Programming.Variables"
     "re-intro-to-data-structures"
     "defining-values"
     "functions-dr"
     "inequalities3-sam"
     "inequalities-collision"
     "functions-for-character-animation"
     "re-functions-that-ask-questions"
     "re-refactoring"
     "re-key-events"
     "re-timers"
     "re-timers"
     "hoc-winter-parley"
     )
    ("6-8.Algorithms and Programming.Modularity"
     "re-refactoring"
     "defining-table-functions"
     "functions-make-life-easier"
     "inequalities3-sam"
     )
    ("9-12.Algorithms and Programming.Variables"
     "re-intro-to-data-structures"
     "re-nested-structures"
     )
    ("9-12.Impacts of Computing.Social Interactions"
     "computing-needs-all-voices"
     )
    ("9-12.Data and Analysis.Inference and Models"
     "threats-to-validity"
     "linear-regression"
     )
    ("9-12.Data and Analysis.Collection"
     "data-collection"
     "ethics-privacy-and-bias"
     )
    ("9-12.Impacts of Computing.Culture"
     "ethics-privacy-and-bias"
     )
    ("9-12.Impacts of Computing.Safety, Law, and Ethics"
     "ethics-privacy-and-bias"
     )
    ("9-12.Data and Analysis.Visualization and Transformation"
     "scatter-plots"
     "standard-deviation"
     "box-plots"
     "histograms2"
     "choosing-your-dataset"
     )
    ("9-12.Computing Systems.Troubleshooting"
     "checking-your-work"
     )
    ("9-12.Algorithms and Programming.Control"
     "method-chaining"
     "custom-scatter-plots"
     "piecewise-functions-conditionals"
     )
    ("9-12.Algorithms and Programming.Modularity"
     "method-chaining"
     "defining-table-functions"
     "functions-make-life-easier"
     )
    ))
