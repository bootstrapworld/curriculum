#lang racket

(provide *csta-standards-list*)
    ;;;;;;;;;;;;;;;;;;;  CSTA Standards ;;;;;;;;;;;;;;;;;;

(define *csta-standards-list*
  '(

    ; CSTA CS Standards
    ; these standards are organized by concept (CS, AP, DA, NI, etc),
    ; then grade band (1B, 3A, etc), then number (01, 02, 03, etc)


    ;;;;;;;;;;;;;;;; Computing Systems ;;;;;;;;;;;;;;;;;
    ("1B-CS-01"
     "Describe how internal and external parts of computing devices function to form a system."
     )
    ("1B-CS-02"
     "Model how computer hardware and software work together as a system to accomplish tasks."
     )
    ("1B-CS-03"
     "Determine potential solutions to solve simple hardware and software problems using common troubleshooting strategies."
     )
    ("2-CS-01"
     "Recommend improvements to the design of computing devices, based on an analysis of how users interact with the devices."
     )
    ("2-CS-02"
     "Design projects that combine hardware and software components to collect and exchange data."
     )
    ("2-CS-03"
     "Systematically identify and fix problems with computing devices and their components."
     )
    ("3A-CS-01"
     "Explain how abstractions hide the underlying implementation details of computing systems embedded in everyday objects."
     )
    ("3A-CS-02"
     "Compare levels of abstraction and interactions between application software, system software, and hardware layers"
     )
    ("3A-CS-03"
     "Develop guidelines that convey systematic troubleshooting strategies that others can use to identify and fix errors"
     )
    ("3B-CS-01"
     "Categorize the roles of operating system software."
     )
    ("3B-CS-02"
     "Illustrate ways computing systems implement logic, input, and output through hardware components"
     )

    ;;;;;;;;;;;;;; Networks and the Internet ;;;;;;;;;;;;;;;;;;;;;;
    ("1B-NI-04"
     "Model how information is broken down into smaller pieces, transmitted as packets through multiple devices over networks and the Internet, and reassembled at the destination."
     )
    ("1B-NI-05"
     "Discuss real-world cybersecurity problems and how personal information can be protected."
     )
    ("2-NI-04"
     "Model the role of protocols in transmitting data across networks and the Internet."
     )
    ("2-NI-05"
     "Explain how physical and digital security measures protect electronic information."
     )
    ("2-NI-06"
     "Apply multiple methods of encryption to model the secure transmission of information"
     )
    ("3A-NI-04"
     "Evaluate the scalability and reliability of networks, by describing the relationship between routers, switches, servers, topology, and addressing."
     )
    ("3A-NI-05"
     "Give examples to illustrate how sensitive data can be affected by malware and other attacks"
     )
    ("3A-NI-06"
     "Recommend security measures to address various scenarios based on factors such as efficiency, feasibility, and ethical impacts."
     )
    ("3A-NI-07"
     "Compare various security measures, considering tradeoffs between the usability and security of a computing system"
     )
    ("3A-NI-08"
     "Explain tradeoffs when selecting and implementing cybersecurity recommendations."
     )
    ("3B-NI-03"
     "Describe the issues that impact network functionality (e.g., bandwidth, load, delay, topology)."
     )
    ("3B-NI-04"
     "Compare ways software developers protect devices and information from unauthorized access."
     )
    ("3B-NI-05"
     "Use data analysis tools and techniques to identify patterns in data representing complex systems"
     "scatter-plots"
     "linear-regression"
     "advanced-displays"
     "correlations"
     )
    ("3B-NI-06"
     "Select data collection tools and techniques to generate data sets that support a claim or communicate information."
     "project-research-paper"
     )
    ("3B-NI-07"
     "Evaluate the ability of models and simulations to test and support the refinement of hypotheses."
     "threats-to-validity"
     "correlations"
     )


    ;;;;;;;;;;;;;; Data and Analysis ;;;;;;;;;;;;;;;;;;;;;;
    ("1B-DA-06"
     "Organize and present collected data visually to highlight relationships and support a claim."
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "standard-deviation"
     "box-plots"
     "linear-regression"
     "histograms2"
     "correlations"
     )
    ("1B-DA-07"
     "Use data to highlight or propose cause-and-effect relationships, predict outcomes, or communicate an idea."
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "linear-regression"
     "hoc-data"
     )
    ("2-DA-07"
     "Represent data using multiple encoding schemes."
     "project-video-game"
     )
    ("2-DA-08"
     "Collect data using computational tools and transform the data to make it more useful and reliable."
     "project-research-paper"
     "project-exploration-paper"
     "table-methods"
     "random-samples"
     "advanced-displays"
     "grouped-samples"
     "bar-and-pie-charts"
     )
    ("2-DA-09"
     "Refine computational models based on the data they have generated."
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "random-samples"
     "grouped-samples"
     "correlations"
     )
    ("3A-DA-09"
     "Translate between different bit representations of real-world phenomena, such as characters, numbers, and images."
     "hoc-winter-parley"
     )
    ("3A-DA-10"
     "Evaluate the tradeoffs in how data elements are organized and where data is stored."
     )
    ("3A-DA-11"
     "Create interactive data visualizations using software tools to help others better understand real-world phenomena."
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
    ("3A-DA-12"
     "Create computational models that represent the relationships among different elements of data collected from a phenomenon or process."
     "project-research-paper"
     "project-exploration-paper"
     "scatter-plots"
     "linear-regression"
     )

    ;;;;;;;;;;;;;; Algorithms and Programming ;;;;;;;;;;;;;;;;;;;;;;
    ("1B-AP-08"
     "Compare and refine multiple algorithms for the same task and determine which is the most appropriate."
     )
    ("1B-AP-09"
     "Create programs that use variables to store and modify data."
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
    ("1B-AP-10"
     "Create programs that include sequences, events, loops, and conditionals."
     "re-adding-collisions"
     "re-key-events"
     "re-structures-reactors-animations"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "advanced-displays"
     "project-video-game"
     "player-animation"
     "functions-for-character-animation"
     "piecewise-functions-conditionals"
     )
    ("1B-AP-11"
     "Decompose (break down) problems into smaller, manageable subproblems to facilitate the program development process."
     "re-nested-structures"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "choosing-your-dataset"
     "project-video-game"
     "problem-decomposition"
     )
    ("1B-AP-12"
     "Modify, remix, or incorporate portions of an existing program into one's own work, to develop something new or add more advanced features."
     "hoc-winter-parley"
     "re-refactoring"
     "re-key-events"
     "re-structures-reactors-animations"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     "advanced-displays"
     "project-video-game"
     "player-animation"
     "making-game-images"
     "piecewise-functions-conditionals"
     )
    ("1B-AP-13"
     "Use an iterative process to plan the development of a program by including others' perspectives and considering user preferences."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("1B-AP-14"
     "Observe intellectual property rights and give appropriate attribution when creating or remixing programs."
     "project-video-game"
     "making-game-images"
     )
    ("1B-AP-15"
     "Test and debug (identify and fix errors) a program or algorithm to ensure it runs as intended."
     "hoc-winter-parley"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "checking-your-work"
     "project-video-game"
     "debugging"
     "functions-make-life-easier"
     )
    ("1B-AP-16"
     "Take on varying roles, with teacher guidance, when collaborating with peers during the design, implementation, and review stages of program development."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("1B-AP-17"
     "Describe choices made during program development using code comments, presentations, and demonstrations."
     "re-functions-that-ask-questions"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("2-AP-10"
     "Use flowcharts and/or pseudocode to address complex problems as algorithms"
     "re-structures-reactors-animations"
     )
    ("2-AP-11"
     "Create clearly named variables that represent different data types and perform operations on their values."
     "re-structures-reactors-animations"
     "re-intro-to-data-structures"
     "project-research-paper"
     "project-exploration-paper"
     "advanced-displays"
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
    ("2-AP-12"
     "Design and iteratively develop programs that combine control structures, including nested loops and compound conditionals"
     "re-nested-structures"
     "re-making-pong"
     "re-adding-levels"
     "re-build-your-own-animation"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("2-AP-13"
     "Decompose problems and subproblems into parts to facilitate the design, implementation, and review of programs"
     "re-nested-structures"
     "re-refactoring"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "defining-table-functions"
     "project-video-game"
     "problem-decomposition"
     )
    ("2-AP-14"
     "Create procedures with parameters to organize code and make it easier to reuse."
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
    ("2-AP-15"
     "Seek and incorporate feedback from team members and users to refine a solution that meets user needs."
     "project-video-game"
     )
    ("2-AP-16"
     "Incorporate existing code, media, and libraries into original programs, and give attribution."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "making-game-images"
     )
    ("2-AP-17"
     "Systematically test and refine programs using a range of test cases"
     "re-making-pong"
     "re-scoring"
     "re-key-events"
     "re-functions-that-ask-questions"
     "project-research-paper"
     "project-exploration-paper"
     "method-chaining"
     "advanced-displays"
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
    ("2-AP-18"
     "Distribute tasks and maintain a project timeline when collaboratively developing computational artifacts."
     )
    ("2-AP-19"
     "Document programs in order to make them easier to follow, test, and debug."
     "project-research-paper"
     "project-exploration-paper"
     "advanced-displays"
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
    ("3A-AP-13"
     "Create prototypes that use algorithms to solve computational problems by leveraging prior student knowledge and personal interests."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3A-AP-14"
     "Use lists to simplify solutions, generalizing computational problems instead of repeatedly using simple variables"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3A-AP-15"
     "Justify the selection of specific control structures when tradeoffs involve implementation, readability, and program performance, and explain the benefits and drawbacks of choices made."
     )
    ("3A-AP-16"
     "Design and iteratively develop computational artifacts for practical intent, personal expression, or to address a societal issue by using events to initiate instructions."
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
    ("3A-AP-17"
     "Decompose problems into smaller components through systematic analysis, using constructs such as procedures, modules, and/or objects."
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
    ("3A-AP-18"
     "Create artifacts by using procedures within a program, combinations of data and procedures, or independent but interrelated programs."
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
    ("3A-AP-19"
     "Systematically design and develop programs for broad audiences by incorporating feedback from users"
     )
    ("3A-AP-20"
     "Evaluate licenses that limit or restrict use of computational artifacts when using resources such as libraries"
     "making-game-images"
     )
    ("3A-AP-21"
     "Evaluate and refine computational artifacts to make them more usable and accessible."
     )
    ("3A-AP-22"
     "Design and develop computational artifacts working in team roles using collaborative tools"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("3A-AP-23"
     "Document design decisions using text, graphics, presentations, and/or demonstrations in the development of complex programs."
     "project-research-paper"
     "project-exploration-paper"
     "choosing-your-dataset"
     )
    ("3B-AP-08"
     "Describe how artificial intelligence drives many software and physical systems."
     )
    ("3B-AP-09"
     "Implement an artificial intelligence algorithm to play a game against a human opponent or solve a problem."
     )
    ("3B-AP-10"
     "Use and adapt classic algorithms to solve computational problems."
     "inequalities3-sam"
     "inequalities2-compound"
     "inequalities1-simple"
     "distance-formula"
     )
    ("3B-AP-11"
     "Evaluate algorithms in terms of their efficiency, correctness, and clarity."
     )
    ("3B-AP-12"
     "Compare and contrast fundamental data structures and their uses."
     )
    ("3B-AP-13"
     "Illustrate the flow of execution of a recursive algorithm"
     "re-structures-reactors-animations"
     )
    ("3B-AP-14"
     "Construct solutions to problems using student-created components, such as procedures, modules and/or objects."
     "re-timers"
     "re-adding-levels"
     "re-adding-collisions"
     "project-research-paper"
     "project-exploration-paper"
     "advanced-displays"
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
    ("3B-AP-15"
     "Analyze a large-scale computational problem and identify generalizable patterns that can be applied to a solution"
     "re-nested-structures"
     "re-refactoring"
     )
    ("3B-AP-16"
     "Demonstrate code reuse by creating programming solutions using libraries and APIs."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("3B-AP-17"
     "Plan and develop programs for broad audiences using a software life cycle process."
     )
    ("3B-AP-18"
     "Explain security issues that might lead to compromised computer programs"
     )
    ("3B-AP-19"
     "Develop programs for multiple computing platforms."
     )
    ("3B-AP-20"
     "Use version control systems, integrated development environments (IDEs), and collaborative tools and practices (code documentation) in a group software project."
     )
    ("3B-AP-21"
     "Develop and use a series of test cases to verify that a program performs according to its design specifications."
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
    ("3B-AP-22"
     "Modify an existing program to add additional functionality and discuss intended and unintended implications (e.g., breaking other functionality)."
     "re-timers"
     "re-scoring"
     "re-functions-that-ask-questions"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "player-animation"
     )
    ("3B-AP-23"
     "Evaluate key qualities of a program through a process such as a code review"
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("3B-AP-24"
     "Compare multiple programming languages and discuss how their features make them suitable for solving different types of problems."
     )

    ;;;;;;;;;;;;;; Impacts of Computing ;;;;;;;;;;;;;;;;;;;;;;
    ("1B-IC-18"
     "Discuss computing technologies that have changed the world, and express how those technologies influence, and are influenced by, cultural practices."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("1B-IC-19"
     "Brainstorm ways to improve the accessibility and usability of technology products for the diverse needs and wants of users."
     )
    ("1B-IC-20"
     "Seek diverse perspectives for the purpose of improving computational artifacts."
     )
    ("1B-IC-21"
     "Use public domain or creative commons media, and refrain from copying or using material created by others without permission."
     "project-video-game"
     "making-game-images"
     )
    ("2-IC-20"
     "Compare tradeoffs associated with computing technologies that affect people's everyday activities and career options."
     )
    ("2-IC-21"
     "Discuss issues of bias and accessibility in the design of existing technologies"
     "project-research-paper"
     "project-exploration-paper"
     "threats-to-validity"
     )
    ("2-IC-22"
     "Collaborate with many contributors through strategies such as crowdsourcing or surveys when creating a computational artifact."
     )
    ("2-IC-23"
     "Describe tradeoffs between allowing information to be public and keeping information private and secure."
     "ethics-privacy-and-bias"
     )
    ("3A-IC-24"
     "Evaluate the ways computing impacts personal, ethical, social, economic, and cultural practices"
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3A-IC-25"
     "Test and refine computational artifacts to reduce bias and equity deficits."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3A-IC-26"
     "Demonstrate ways a given algorithm applies to problems across disciplines."
     )
    ("3A-IC-27"
     "Use tools and methods for collaboration on a project to increase connectivity of people in different cultures and career fields"
     )
    ("3A-IC-28"
     "Explain the beneficial and harmful effects that intellectual property laws can have on innovation."
     )
    ("3A-IC-29"
     "Explain the privacy concerns related to the collection and generation of data through automated processes that may not be evident to users."
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3A-IC-30"
     "Evaluate the social and economic implications of privacy in the context of safety, law, or ethics."
     "project-research-paper"
     "project-exploration-paper"
     "ethics-privacy-and-bias"
     )
    ("3B-IC-25"
     "Evaluate computational artifacts to maximize their beneficial effects and minimize harmful effects on society."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3B-IC-26"
     "Evaluate the impact of equity, access, and influence on the distribution of computing resources in a global society."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("3B-IC-27"
     "Predict how computational innovations that have revolutionized aspects of our culture might evolve."
     )
    ("3B-IC-28"
     "Debate laws and regulations that impact the development and use of software."
     )
    ))

