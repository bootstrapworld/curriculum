#lang racket

(provide *ngss-standards-list*)

(define *ngss-standards-list*
'(
; Next-Generation Science Standards (NGSS)
; Science and Engineering Practices

; The 8 NGSS Science and Engineering Practices do not have a predefined numbering system.  For this dictionary, subitems have been numbered for easier comprehension and use.  

; ES = Elementary School (Grades 3-5)
; MS = Middle School (Grades 6-8)
; HS = High School (Grades 9-12)


; SEP1 = Asking Questions and Defining Problems

  ("ES-SEP1-1"
  "Ask questions about what would happen if a variable is changed."
  )
  ("ES-SEP1-2"
  "Identify scientific (testable) and non-scientific (non-testable) questions."
  )
  ("ES-SEP1-3"
  "Ask questions that can be investigated and predict reasonable outcomes based on patterns such as cause and effect relationships."
  )
  ("ES-SEP1-4"
  "Use prior knowledge to describe problems that can be solved."
  )
  ("ES-SEP1-5"
  "Define a simple design problem that can be solved through the development of an object, tool, process, or system and includes several criteria for success and constraints on materials, time, or cost."
  )
  ("MS-SEP1-1"
  "Ask questions that require sufficient and appropriate empirical evidence to answer."
  )
  ("MS-SEP1-2"
  "Ask questions that arise from careful observation of phenomena, models, or unexpected results, to clarify and/or seek additional information."
  )
  ("MS-SEP1-3"
  "Ask questions to identify and/or clarify evidence and/or the premise(s) of an argument."
  )
  ("MS-SEP1-4"
  "Ask questions to determine relationships between independent and dependent variables and relationships in models."
  )
  ("MS-SEP1-5"
  "Ask questions to clarify and/or refine a model, an explanation, or an engineering problem."
  )
  ("MS-SEP1-6"
  "Ask questions that can be investigated within the scope of the classroom, outdoor environment, and museums and other public facilities with available resources and, when appropriate, frame a hypothesis based on observations and scientific principles."
  )
  ("MS-SEP1-7"
  "Define a design problem that can be solved through the development of an object, tool, process or system and includes multiple criteria and constraints, including scientific knowledge that may limit possible solutions."
  )
  ("MS-SEP1-8"
  "Ask questions that challenge the premise(s) of an argument or the interpretation of a data set."
  )
  ("HS-SEP1-1"
  "Ask questions that arise from careful observation of phenomena, or unexpected results, to clarify and/or seek additional information."
  )
  ("HS-SEP1-2"
  "Ask questions that arise from examining models or a theory, to clarify and/or seek additional information and relationships."
  )
  ("HS-SEP1-3"
  "Ask questions to determine relationships, including quantitative relationships, between independent and dependent variables."
  )
  ("HS-SEP1-4"
  "Ask questions to clarify and refine a model, an explanation, or an engineering problem."
  )
  ("HS-SEP1-5"
  "Evaluate a question to determine if it is testable and relevant."
  )
  ("HS-SEP1-6"
  "Ask questions that can be investigated within the scope of the school laboratory, research facilities, or field (e.g., outdoor environment) with available resources and, when appropriate, frame a hypothesis based on a model or theory."
  )
  ("HS-SEP1-7"
  "Ask and/or evaluate questions that challenge the premise(s) of an argument, the interpretation of a data set, or the suitability of the design."
  )
  ("HS-SEP1-8"
  "Define a design problem that involves the development of a process or system with interacting components and criteria and constraints that may include social, technical and/or environmental considerations."
  )
  ("HS-SEP1-9"
  "Analyze complex real-world problems by specifying criteria and constraints for successful solutions."
  )
  
  ; SEP2 = Developing and Using Models
  
  ("ES-SEP2-1"
  "Identify limitations of models."
  )
  ("ES-SEP2-2"
  "Collaboratively develop and/or revise a model based on evidence that shows the relationships among variables for frequent and regular occurring events."
  )
  ("ES-SEP2-3"
  "Develop a model using an analogy, example, or abstract representation to describe a scientific principle or design solution."
  )
  ("ES-SEP2-4"
  "Develop and/or use models to describe and/or predict phenomena."
  )
  ("ES-SEP2-5"
  "Develop a diagram or simple physical prototype to convey a proposed object, tool, or process."
  )
  ("ES-SEP2-6"
  "Use a model to test cause and effect relationships or interactions concerning the functioning of a natural or designed system."
  )
  ("MS-SEP2-1"
  "Evaluate limitations of a model for a proposed object or tool."
  )
  ("MS-SEP2-2"
  "Develop or modify a model—based on evidence – to match what happens if a variable or component of a system is changed."
  )
  ("MS-SEP2-3"
  "Use and/or develop a model of simple systems with uncertain and less predictable factors."
  )
  ("MS-SEP2-4"
  "Develop and/or revise a model to show the relationships among variables, including those that are not observable but predict observable phenomena."
  )
  ("MS-SEP2-5"
  "Develop and/or use a model to predict and/or describe phenomena."
  )
  ("MS-SEP2-6"
  "Develop a model to describe unobservable mechanisms."
  )
  ("MS-SEP2-7"
  "Develop and/or use a model to generate data to test ideas about phenomena in natural or designed systems, including those representing inputs and outputs, and those at unobservable scales."
  )
  ("HS-SEP2-1"
  "Evaluate merits and limitations of two different models of the same proposed tool, process, mechanism, or system in order to select or revise a model that best fits the evidence or design criteria."
  )
  ("HS-SEP2-2"
  "Design a test of a model to ascertain its reliability."
  )
  ("HS-SEP2-3"
  "Develop, revise, and/or use a model based on evidence to illustrate and/or predict the relationships between systems or between components of a system."
  )
  ("HS-SEP2-4"
  "Develop and/or use multiple types of models to provide mechanistic accounts and/or predict phenomena, and move flexibly between model types based on merits and limitations."
  )
  ("HS-SEP2-5"
  "Use a model to provide mechanistic accounts of phenomena."
  )
  ("HS-SEP2-6"
  "Develop a complex model that allows for manipulation and testing of a proposed process or system."
  )
  ("HS-SEP2-7"
  "Develop and/or use a model (including mathematical and computational) to generate data to support explanations, predict phenomena, analyze systems, and/or solve problems."
  )
  
  ; SEP3 = Planning and Carrying Out Investigations
  
  ("ES-SEP3-1"
  "Plan and conduct an investigation collaboratively to produce data to serve as the basis for evidence, using fair tests in which variables are controlled and the number of trials considered."
  )
  ("ES-SEP3-2"
  "Evaluate appropriate methods and/or tools for collecting data."
  )
  ("ES-SEP3-3"
  "Make observations and/or measurements to produce data to serve as the basis for evidence for an explanation of a phenomenon or test a design solution."
  )
  ("ES-SEP3-4"
  "Make predictions about what would happen if a variable changes."
  )
  ("ES-SEP3-5"
  "Test two different models of the same proposed object, tool, or process to determine which better meets criteria for success."
  )
  ("MS-SEP3-1"
  "Plan an investigation individually and collaboratively, and in the design: identify independent and dependent variables and controls, what tools are needed to do the gathering, how measurements will be recorded, and how many data are needed to support a claim."
  )
  ("MS-SEP3-2"
  "Conduct an investigation and/or evaluate and/or revise the experimental design to produce data to serve as the basis for evidence that meet the goals of the investigation."
  )
  ("MS-SEP3-3"
  "Evaluate the accuracy of various methods for collecting data."
  )
  ("MS-SEP3-4"
  "Collect data to produce data to serve as the basis for evidence to answer scientific questions or test design solutions under a range of conditions."
  )
  ("MS-SEP3-5"
  "Collect data about the performance of a proposed object, tool, process, or system under a range of conditions."
  )
  ("HS-SEP3-1"
  "Plan an investigation or test a design individually and collaboratively to produce data to serve as the basis for evidence as part of building and revising models, supporting explanations for phenomena, or testing solutions to problems. Consider possible variables or effects and evaluate the confounding investigation’s design to ensure variables are controlled."
  )
  ("HS-SEP3-2"
  "Plan and conduct an investigation individually and collaboratively to produce data to serve as the basis for evidence, and in the design: decide on types, how much, and accuracy of data needed to produce reliable measurements and consider limitations on the precision of the data (e.g., number of trials, cost, risk, time), and refine the design accordingly."
  )
  ("HS-SEP3-3"
  "Plan and conduct an investigation or test a design solution in a safe and ethical manner including considerations of environmental, social, and personal impacts."
  )
  ("HS-SEP3-4"
  "Select appropriate tools to collect, record, analyze, and evaluate data."
  )
  ("HS-SEP3-5"
  "Make directional hypotheses that specify what happens to a dependent variable when an independent variable is manipulated."
  )
  ("HS-SEP3-6"
  "Manipulate variables and collect data about a complex model of a proposed process or system to identify failure points or improve performance relative to criteria for success or other variables."
  )
  
  ; SEP4 = Analyzing and Interpreting Data
  
  ("ES-SEP4-1"
  "Represent data in tables and/or various graphical displays (bar graphs, pictographs, and/or pie charts) to reveal patterns that indicate relationships."
  )
  ("ES-SEP4-2"
  "Analyze and interpret data to make sense of phenomena, using logical reasoning, mathematics, and/or computation."
  )
  ("ES-SEP4-3"
  "Compare and contrast data collected by different groups in order to discuss similarities and differences in their findings."
  )
  ("ES-SEP4-4"
  "Analyze data to refine a problem statement or the design of a proposed object, tool, or process."
  )
  ("ES-SEP4-5"
  "Use data to evaluate and refine design solutions."
  )
  ("MS-SEP4-1"
  "Construct, analyze, and/or interpret graphical displays of data and/or large data sets to identify linear and nonlinear relationships."
  )
  ("MS-SEP4-2"
  "Use graphical displays (e.g., maps, charts, graphs, and/or tables) of large data sets to identify temporal and spatial relationships."
  )
  ("MS-SEP4-3"
  "Distinguish between causal and correlational relationships in data."
  )
  ("MS-SEP4-4"
  "Analyze and interpret data to provide evidence for phenomena."
  )
  ("MS-SEP4-5"
  "Apply concepts of statistics and probability (including mean, median, mode, and variability) to analyze and characterize data, using digital tools when feasible."
  )
  ("MS-SEP4-6"
  "Consider limitations of data analysis (e.g., measurement error), and/or seek to improve precision and accuracy of data with better technological tools and methods (e.g., multiple trials)."
  )
  ("MS-SEP4-7"
  "Analyze and interpret data to determine similarities and differences in findings."
  )
  ("MS-SEP4-8"
  "Analyze data to define an optimal operational range for a proposed object, tool, process or system that best meets criteria for success."
  )
  ("HS-SEP4-1"
  "Analyze data using tools, technologies, and/or models (e.g., computational, mathematical) in order to make valid and reliable scientific claims or determine an optimal design solution."
  )
  ("HS-SEP4-2"
  "Apply concepts of statistics and probability (including determining function fits to data, slope, intercept, and correlation coefficient for linear fits) to scientific and engineering questions and problems, using digital tools when feasible."
  )
  ("HS-SEP4-3"
  "Consider limitations of data analysis (e.g., measurement error, sample selection) when analyzing and interpreting data."
  )
  ("HS-SEP4-4"
  "Compare and contrast various types of data sets (e.g., self-generated, archival) to examine consistency of measurements and observations."
  )
  ("HS-SEP4-5"
  "Evaluate the impact of new data on a working explanation and/or model of a proposed process or system."
  )
  ("HS-SEP4-6"
  "Analyze data to identify design features or characteristics of the components of a proposed process or system to optimize it relative to criteria for success."
  )
  
  ; SEP5 = Using Mathematics and Computational Thinking
  
  ("ES-SEP5-1"
  "Decide if qualitative or quantitative data are best to determine whether a proposed object or tool meets criteria for success."
  )
  ("ES-SEP5-2"
  "Organize simple data sets to reveal patterns that suggest relationships."
  )
  ("ES-SEP5-3"
  "Describe, measure, estimate, and/or graph quantities such as area, volume, weight, and time to address scientific and engineering questions and problems."
  )
  ("ES-SEP5-4"
  "Create and/or use graphs and/or charts generated from simple algorithms to compare alternative solutions to an engineering problem."
  )
  ("MS-SEP5-1"
  "Use digital tools (e.g., computers) to analyze very large data sets for patterns and trends."
  )
  ("MS-SEP5-2"
  "Use mathematical representations to describe and/or support scientific conclusions and design solutions."
  )
  ("MS-SEP5-3"
  "Create algorithms (a series of ordered steps) to solve a problem."
  )
  ("MS-SEP5-4"
  "Apply mathematical concepts and/or processes (such as ratio, rate, percent, basic operations, and simple algebra) to scientific and engineering questions and problems."
  )
  ("MS-SEP5-5"
  "Use digital tools and/or mathematical concepts and arguments to test and compare proposed solutions to an engineering design problem."
  )
  ("HS-SEP5-1"
  "Create and/or revise a computational model or simulation of a phenomenon, designed device, process, or system."
  )
  ("HS-SEP5-2"
  "Use mathematical, computational, and/or algorithmic representations of phenomena or design solutions to describe and/or support claims and/or explanations."
  )
  ("HS-SEP5-3"
  "Apply techniques of algebra and functions to represent and solve scientific and engineering problems."
  )
  ("HS-SEP5-4"
  "Use simple limit cases to test mathematical expressions, computer programs, algorithms, or simulations of a process or system to see if a model “makes sense” by comparing the outcomes with what is known about the real world."
  )
  ("HS-SEP5-5"
  "Apply ratios, rates, percentages, and unit conversions in the context of complicated measurement problems involving quantities with derived or compound units (such as mg/mL, kg/m3, acre-feet, etc.)."
  )
  
  ; SEP6 = Constructing Explanations and Designing Solutions
  
  ("ES-SEP6-1"
  "Construct an explanation of observed relationships (e.g., the distribution of plants in the back yard)."
  )
  ("ES-SEP6-2"
  "Use evidence (e.g., measurements, observations, patterns) to construct or support an explanation or design a solution to a problem."
  )
  ("ES-SEP6-3"
  "Identify the evidence that supports particular points in an explanation."
  )
  ("ES-SEP6-4"
  "Apply scientific ideas to solve design problems."
  )
  ("ES-SEP6-5"
  "Generate and compare multiple solutions to a problem based on how well they meet the criteria and constraints of the design solution."
  )
  ("MS-SEP6-1"
  "Construct an explanation that includes qualitative or quantitative relationships between variables that predict(s) and/or describe(s) phenomena."
  )
  ("MS-SEP6-2"
  "Construct an explanation using models or representations."
  )
  ("MS-SEP6-3"
  "Construct a scientific explanation based on valid and reliable evidence obtained from sources (including the students’ own experiments) and the assumption that theories and laws that describe the natural world operate today as they did in the past and will continue to do so in the future."
  )
  ("MS-SEP6-4"
  "Apply scientific ideas, principles, and/or evidence to construct, revise and/or use an explanation for real-world phenomena, examples, or events."
  )
  ("MS-SEP6-5"
  "Apply scientific reasoning to show why the data or evidence is adequate for the explanation or conclusion."
  )
  ("MS-SEP6-6"
  "Apply scientific ideas or principles to design, construct, and/or test a design of an object, tool, process or system."
  )
  ("MS-SEP6-7"
  "Undertake a design project, engaging in the design cycle, to construct and/or implement a solution that meets specific design criteria and constraints."
  )
  ("MS-SEP6-8"
  "Optimize performance of a design by prioritizing criteria, making tradeoffs, testing, revising, and re-testing."
  )
  ("HS-SEP6-1"
  "Make a quantitative and/or qualitative claim regarding the relationship between dependent and independent variables."
  )
  ("HS-SEP6-2"
  "Construct and revise an explanation based on valid and reliable evidence obtained from a variety of sources (including students’ own investigations, models, theories, simulations, peer review) and the assumption that theories and laws that describe the natural world operate today as they did in the past and will continue to do so in the future."
  )
  ("HS-SEP6-3"
  "Apply scientific ideas, principles, and/or evidence to provide an explanation of phenomena and solve design problems, taking into account possible unanticipated effects."
  )
  ("HS-SEP6-4"
  "Apply scientific reasoning, theory, and/or models to link evidence to the claims to assess the extent to which the reasoning and data support the explanation or conclusion."
  )
  ("HS-SEP6-5"
  "Design, evaluate, and/or refine a solution to a complex real-world problem, based on scientific knowledge, student-generated sources of evidence, prioritized criteria, and tradeoff considerations."
  )
  
  ; SEP7 = Engaging in Argument from Evidence
  
  ("ES-SEP7-1"
  "Compare and refine arguments based on an evaluation of the evidence presented."
  )
  ("ES-SEP7-2"
  "Distinguish among facts, reasoned judgment based on research findings, and speculation in an explanation."
  )
  ("ES-SEP7-3"
  "Respectfully provide and receive critiques from peers about a proposed procedure, explanation or model by citing relevant evidence and posing specific questions."
  )
  ("ES-SEP7-4"
  "Construct and/or support an argument with evidence, data, and/or a model."
  )
  ("ES-SEP7-5"
  "Use data to evaluate claims about cause and effect."
  )
  ("ES-SEP7-6"
  "Make a claim about the merit of a solution to a problem by citing relevant evidence about how it meets the criteria and constraints of the problem."
  )
  ("MS-SEP7-1"
  "Compare and critique two arguments on the same topic and analyze whether they emphasize similar or different evidence and/or interpretations of facts."
  )
  ("MS-SEP7-2"
  "Respectfully provide and receive critiques about one’s explanations, procedures, models and questions by citing relevant evidence and posing and responding to questions that elicit pertinent elaboration and detail."
  )
  ("MS-SEP7-3"
  "Construct, use, and/or present an oral and written argument supported by empirical evidence and scientific reasoning to support or refute an explanation or a model for a phenomenon or a solution to a problem."
  )
  ("MS-SEP7-4"
  "Make an oral or written argument that supports or refutes the advertised performance of a device, process, or system, based on empirical evidence concerning whether or not the technology meets relevant criteria and constraints."
  )
  ("MS-SEP7-5"
  "Evaluate competing design solutions based on jointly developed and agreed-upon design criteria."
  )
  ("HS-SEP7-1"
  "Compare and evaluate competing arguments or design solutions in light of currently accepted explanations, new evidence, limitations (e.g., trade-offs), constraints, and ethical issues."
  )
  ("HS-SEP7-2"
  "Evaluate the claims, evidence, and/or reasoning behind currently accepted explanations or solutions to determine the merits of arguments."
  )
  ("HS-SEP7-3"
  "Respectfully provide and/or receive critiques on scientific arguments by probing reasoning and evidence and challenging ideas and conclusions, responding thoughtfully to diverse perspectives, and determining what additional information is required to resolve contradictions."
  )
  ("HS-SEP7-4"
  "Construct, use, and/or present an oral and written argument or counter-arguments based on data and evidence."
  )
  ("HS-SEP7-5"
  "Make and defend a claim based on evidence about the natural world or the effectiveness of a design solution that reflects scientific knowledge, and student-generated evidence."
  )
  ("HS-SEP7-6"
  "Evaluate competing design solutions to a real-world problem based on scientific ideas and principles, empirical evidence, and logical arguments regarding relevant factors (e.g. economic, societal, environmental, ethical considerations)."
  )
  
  ; SEP8 = Obtaining, Evaluating, and Communicating Information
  
  ("ES-SEP8-1"
  "Obtain and combine information from books and other reliable media to explain phenomena."
  )
  ("ES-SEP8-2"
  "Read and comprehend grade-appropriate complex texts and/or other reliable media to summarize and obtain scientific and technical ideas and describe how they are supported by evidence."
  )
  ("ES-SEP8-3"
  "Compare and/or combine across complex texts and/or other reliable media to support the engagement in other scientific and/or engineering practices."
  )
  ("ES-SEP8-4"
  "Combine information in written text with that contained in corresponding tables, diagrams, and/or charts to support the engagement in other scientific and/or engineering practices."
  )
  ("ES-SEP8-5"
  "Obtain and combine information from books and/or other reliable media to explain phenomena or solutions to a design problem."
  )
  ("ES-SEP8-6"
  "Communicate scientific and/or technical information orally and/or in written formats, including various forms of media and may include tables, diagrams, and charts."
  )
  ("MS-SEP8-1"
  "Critically read scientific texts adapted for classroom use to determine the central ideas and/or obtain scientific and/or technical information to describe patterns in and/or evidence about the natural and designed world(s)."
  )
  ("MS-SEP8-2"
  "Integrate qualitative and/or quantitative scientific and/or technical information in written text with that contained in media and visual displays to clarify claims and findings."
  )
  ("MS-SEP8-3"
  "Gather, read, synthesize information from multiple appropriate sources and assess the credibility, accuracy, and possible bias of each publication and methods used, and describe how they are supported or not supported by evidence."
  )
  ("MS-SEP8-4"
  "Evaluate data, hypotheses, and/or conclusions in scientific and technical texts in light of competing information or accounts."
  )
  ("MS-SEP8-5"
  "Communicate scientific and/or technical information (e.g. about a proposed object, tool, process, system) in writing and/or through oral presentations."
  )
  ("HS-SEP8-1"
  "Critically read scientific literature adapted for classroom use to determine the central ideas or conclusions and/or to obtain scientific and/or technical information to summarize complex evidence, concepts, processes, or information presented in a text by paraphrasing them in simpler but still accurate terms."
  )
  ("HS-SEP8-2"
  "Compare, integrate and evaluate sources of information presented in different media or formats (e.g., visually, quantitatively) as well as in words in order to address a scientific question or solve a problem."
  )
  ("HS-SEP8-3"
  "Gather, read, and evaluate scientific and/or technical information from multiple authoritative sources, assessing the evidence and usefulness of each source."
  )
  ("HS-SEP8-4"
  "Evaluate the validity and reliability of and/or synthesize multiple claims, methods, and/or designs that appear in scientific and technical texts or media reports, verifying the data when possible."
  )
  ("HS-SEP8-5"
  "Communicate scientific and/or technical information or ideas (e.g. about phenomena and/or the process of development and the design and performance of a proposed process or system) in multiple formats (including orally, graphically, textually, and mathematically)."
  )
 ))

