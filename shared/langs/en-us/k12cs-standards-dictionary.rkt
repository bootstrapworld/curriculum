#lang racket

(provide *k12cs-standards-list*)

(define *k12cs-standards-list*
'(
; K12CS Frameworkss

  ;;;;;;;;;;;;;; Practices ;;;;;;;;;;;;;;;;;;;;;;
  ("P1"
   "Fostering an Inclusive Computing Culture"
  )
  ("P2"
   "Collaborating Around Computing"
  )
  ("P3"
   "Recognizing and Defining Computational Problems"
  )
  ("P4"
   "Developing and Using Abstractions"
  )
  ("P5"
   "Creating Computational Artifacts"
  )
  ("P6"
   "Testing and Refining Computational Artifacts"
  )
  ("P7"
   "Communicating About Computing"
  )

  ;;;;;;;;;;;;;; Computing Systems ;;;;;;;;;;;;;;;;;;;;;;
  ("9-12.Computing Systems.Devices"
   "Computing devices are often integrated with other systems, including biological, mechanical, and social systems. These devices can share data with one another. The usability, dependability, security, and accessibility of these devices, and the systems they are integrated with, are important considerations in their design as they evolve."
  )
  ("6-8.Computing Systems.Devices"
   "The interaction between humans and computing devices presents advantages, disadvantages, and unintended consequences. The study of human–computer interaction can improve the design of devices and extend the abilities of humans."
  )
  ("9-12.Computing Systems.Hardware and Software"
   "Levels of interaction exist between the hardware, software, and user of a computing system. The most common levels of software that a user interacts with include system software and applications. System software controls the flow of information between hardware components used for input, output, storage, and processing."
  )
  ("6-8.Computing Systems.Hardware and Software"
   "Hardware and software determine a computing system’s capability to store and process information. The design or selection of a computing system involves multiple considerations and potential tradeoffs, such as functionality, cost, size, speed, accessibility, and aesthetics."
  )
  ("9-12.Computing Systems.Troubleshooting"
   "Troubleshooting complex problems involves the use of multiple sources when researching, evaluating, and implementing potential solutions. Troubleshooting also relies on experience, such as when people recognize that a problem is similar to one they have seen before or adapt solutions that have worked in the past."
  )
  ("6-8.Computing Systems.Troubleshooting"
   "Comprehensive troubleshooting requires knowledge of how computing devices and components work and interact. A systematic process will identify the source of a problem, whether within a device or in a larger system of connected devices."
  )

  ;;;;;;;;;;;;;; Networks and the Internet ;;;;;;;;;;;;;;;;;;;;;;
  ("9-12.Networks and the Internet.Network Communication and Organization"
   "Network topology is determined, in part, by how many devices can be supported. Each device is assigned an address that uniquely identifies it on the network. The scalability and reliability of the Internet are enabled by the hierarchy and redundancy in networks."
  )
  ("6-8.Networks and the Internet.Network Communication and Organization"
   "Computers send and receive information based on a set of rules called protocols. Protocols define how messages between computers are structured and sent. Considerations of security, speed, and reliability are used to determine the best path to send and receive data."
  )
  ("9-12.Networks and the Internet.Cybersecurity"
   "Network security depends on a combination of hardware, software, and practices that control access to data and systems. The needs of users and the sensitivity of data determine the level of security implemented."
  )
  ("6-8.Networks and the Internet.Cybersecurity"
   "The information sent and received across networks can be protected from unauthorized access and modification in a variety of ways, such as encryption to maintain its confidentiality and restricted access to maintain its integrity. Security measures to safeguard online information proactively address the threat of breaches to personal and private data."
  )


  ;;;;;;;;;;;;;; Data and Analysis ;;;;;;;;;;;;;;;;;;;;;;
  ("9-12.Data and Analysis.Collection"
   "Data is constantly collected or generated through automated processes that are not always evident, raising privacy concerns. The different collection methods and tools that are used influence the amount and quality of the data that is observed and recorded."
  )
  ("6-8.Data and Analysis.Collection"
   "People design algorithms and tools to automate the collection of data by computers. When data collection is automated, data is sampled and converted into a form that a computer can process. For example, data from an analog sensor must be converted into a digital form. The method used to automate data collection is influenced by the availability of tools and the intended use of the data."
  )
  ("9-12.Data and Analysis.Storage"
   "Data can be composed of multiple data elements that relate to one another. For example, population data may contain information about age, gender, and height. People make choices about how data elements are organized and where data is stored. These choices affect cost, speed, reliability, accessibility, privacy, and integrity."
  )
  ("6-8.Data and Analysis.Storage"
   "Applications store data as a representation. Representations occur at multiple levels, from the arrangement of information into organized formats (such as tables in software) to the physical storage of bits. The software tools used to access information translate the low-level representation of bits into a form understandable by people."
  )
  ("9-12.Data and Analysis.Visualization and Transformation"
   "Data can be transformed to remove errors, highlight or expose relationships, and/or make it easier for computers to process."
  )
  ("6-8.Data and Analysis.Visualization and Transformation"
   "Computer models can be used to simulate events, examine theories and inferences, or make predictions with either few or millions of data points. Computer models are abstractions that represent phenomena and use data and algorithms to emphasize key features and relationships within a system. As more data is automatically collected, models can be refined."
  )
  ("9-12.Data and Analysis.Inference and Models"
   "The accuracy of predictions or inferences depends upon the limitations of the computer model and the data the model is built upon. The amount, quality, and diversity of data and the features chosen can affect the quality of a model and ability to understand a system. Predictions or inferences are tested to validate models."
  )
  ("6-8.Data and Analysis.Inference and Models"
   "People transform, generalize, simplify, and present large data sets in different ways to influence how other people interpret and understand the underlying information. Examples include visualization, aggregation, rearrangement, and application of mathematical operations."
  )

  ;;;;;;;;;;;;;; Algorithms and Programming ;;;;;;;;;;;;;;;;;;;;;;
  ("9-12.Algorithms and Programming.Algorithms"
   "People evaluate and select algorithms based on performance, reusability, and ease of implementation. Knowledge of common algorithms improves how people develop software, secure data, and store information."
  )
  ("6-8.Algorithms and Programming.Algorithms"
   "Algorithms affect how people interact with computers and the way computers respond. People design algorithms that are generalizable to many situations. Algorithms that are readable are easier to follow, test, and debug."
  )
  ("9-12.Algorithms and Programming.Variables"
   "Data structures are used to manage program complexity. Programmers choose data structures based on functionality, storage, and performance tradeoffs."
  )
  ("6-8.Algorithms and Programming.Variables"
   "Programmers create variables to store data values of selected types. A meaningful identifier is assigned to each variable to access and perform operations on the value by name. Variables enable the flexibility to represent different situations, process different sets of data, and produce varying outputs."
  )
  ("9-12.Algorithms and Programming.Control"
   "Programmers consider tradeoffs related to implementation, readability, and program performance when selecting and combining control structures."
  )
  ("6-8.Algorithms and Programming.Control"
   "Programmers select and combine control structures, such as loops, event handlers, and conditionals, to create more complex program behavior."
  )
  ("9-12.Algorithms and Programming.Modularity"
   "Complex programs are designed as systems of interacting modules, each with a specific role, coordinating for a common overall purpose. These modules can be procedures within a program; combinations of data and procedures; or independent, but interrelated, programs. Modules allow for better management of complex tasks."
  )
  ("6-8.Algorithms and Programming.Modularity"
   "Programs use procedures to organize code, hide implementation details, and make code easier to reuse. Procedures can be repurposed in new programs. Defining parameters for procedures can generalize behavior and increase reusability."
  )
  ("9-12.Algorithms and Programming.Program Development"
   "Diverse teams can develop programs with a broad impact through careful review and by drawing on the strengths of members in different roles. Design decisions often involve tradeoffs. The development of complex programs is aided by resources such as libraries and tools to edit and manage parts of the program. Systematic analysis is critical for identifying the effects of lingering bugs."
  )
  ("6-8.Algorithms and Programming.Program Development"
   "People design meaningful solutions for others by defining a problem’s criteria and constraints, carefully considering the diverse needs and wants of the community, and testing whether criteria and constraints were met."
  )

  ;;;;;;;;;;;;;; Impacts of Computing ;;;;;;;;;;;;;;;;;;;;;;
  ("9-12.Impacts of Computing.Culture"
   "The design and use of computing technologies and artifacts can improve, worsen, or maintain inequitable access to information and opportunities."
  )
  ("6-8.Impacts of Computing.Culture"
   "Advancements in computing technology change people’s everyday activities. Society is faced with tradeoffs due to the increasing globalization and automation that computing brings."
  )
  ("9-12.Impacts of Computing.Social Interactions"
   "Many aspects of society, especially careers, have been affected by the degree of communication afforded by computing. The increased connectivity between people in different cultures and in different career fields has changed the nature and content of many careers."
  )
  ("6-8.Impacts of Computing.Social Interactions"
   "People can organize and engage around issues and topics of interest through various communication platforms enabled by computing, such as social networks and media outlets. These interactions allow issues to be examined using multiple viewpoints from a diverse audience."
  )
  ("9-12.Impacts of Computing.Safety, Law, and Ethics"
   "Laws govern many aspects of computing, such as privacy, data, property, information, and identity. These laws can have beneficial and harmful effects, such as expediting or delaying advancements in computing and protecting or infringing upon people’s rights. International differences in laws and ethics have implications for computing."
  )
  ("6-8.Impacts of Computing.Safety, Law, and Ethics"
   "There are tradeoffs between allowing information to be public and keeping information private and secure. People can be tricked into revealing personal information when more public information is available about them online."
  )

 ))

