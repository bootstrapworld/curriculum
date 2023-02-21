#lang racket

(provide *ma-standards-list*)

(define *ma-standards-list*
  `(
    ; Massachusetts-specific Digital Literacy Standards
    ("K-2.CAS.a.1"
     "Demonstrate proper ergonomics (e.g., body position, stretching) when using devices."
     )
    ("K-2.CAS.a.2"
     "Use electrical devices safely and in moderation (e.g., unplug devices by pulling the plug rather than the cord, do not mix water/food and electric devices, avoid gaming and walking)."
     )
    ("K-2.CAS.a.3"
     "Care for devices appropriately (e.g., handling devices gently, completely shutting down devices when not in use, storing devices in the appropriate container)."
     )
    ("K-2.CAS.a.4"
     "Explain that a password helps protect the privacy of information."
     )
    ("K-2.CAS.a.5"
     "Identify safe and unsafe examples of online communications."
     )
    ("K-2.CAS.a.6"
     "Explain why we keep personal information (e.g., name, location, phone number, home address) private."
     )
    ("K-2.CAS.a.7"
     "Identify which personal information (e.g., user name or real name, school name or home address) should and should not be shared online and with whom."
     )
    ("K-2.CAS.a.8"
     "Explain why it is necessary to report inappropriate electronic content or contact."
     )
    ("K-2.CAS.b.1"
     "Define good digital citizenship as using technology safely, responsibly, and ethically."
     )
    ("K-2.CAS.b.2"
     "Demonstrate responsible use of computers, peripheral devices, and resources as outlined in school rules (Acceptable Use Policy [AUP] for K-2)."
     )
    ("K-2.CAS.b.3"
     "Explain that most digital artifacts have owners."
     )
    ("K-2.CAS.b.4"
     "Explain the importance of giving credit to media creators/owners when using their work."
     )
    ("K-2.CAS.c.1"
     "Identify and describe how people (e.g., students, parents, police officers) use many types of technologies in their daily work and personal lives."
     )
    ("K-2.CAS.c.2"
     "Recognize when the purpose of content is to provide information or to influence you to act."
     )
    ("K-2.DTC.a.1"
     "Operate a variety of digital tools (e.g., open/close, find, save/print, navigate, use input/output devices)."
     )
    ("K-2.DTC.a.2"
     "Identify, locate, and use letters, numbers, and special keys on a keyboard (e.g., Space Bar, Shift, Delete)."
     )
    ("K-2.DTC.a.3"
     "Create a simple digital artifact."
     )
    ("K-2.DTC.a.4"
     "Use appropriate digital tools individually and collaboratively to create, review, and revise simple artifacts that include text, images and audio."
     )
    ("K-2.DTC.b.1"
     "Collaboratively use digital tools and media resources to communicate key ideas and details in a way that informs, persuades, and/or entertains."
     )
    ("K-2.DTC.b.2"
     "Use a variety of digital tools to exchange information and feedback with teachers."
     )
    ("K-2.DTC.b.3"
     "Use a variety of digital tools to present information to others."
     )
    ("K-2.DTC.c.1"
     "Conduct basic keyword searches to gather information from teacher-provided digital sources (e.g., online library catalog, databases)."
     )
    ("K-2.DTC.c.2"
     "Create an artifact individually and collaboratively that answers a research question, while clearly expressing thoughts and ideas."
     )
    ("K-2.DTC.c.3"
     "Acknowledge and name sources of information or media (e.g., title of book, author of book, website)."
     )
    ("K-2.CS.a.1"
     "Identify different kinds of computing devices in the classroom and other places (e.g., laptops, tablets, smart phones, desktops)."
     )
    ("K-2.CS.a.2"
     "Identify visible components of computing devices (e.g., keyboard, screen, monitor, printer, pointing device)."
     )
    ("K-2.CS.a.3"
     "Explain that computing devices function when applications, programs, or commands are executed."
     )
    ("K-2.CS.a.4"
     "Operate a variety of computing systems (e.g., turn on, use input/output devices such as a mouse, keyboard, or touch screen; find, navigate, launch a program)."
     )
    ("K-2.CS.b.1"
     "Explain that computing devices are machines that are not alive, but can be used to help humans with tasks."
     )
    ("K-2.CS.b.2"
     "Recognize that some tasks are best completed by humans and others by computing devices (e.g., a human might be able to rescue someone in a normal environment, but robots would be better to use in a dangerous environment)."
     )
    ("K-2.CS.b.3"
     "Recognize that different tools can solve the same problem (e.g., pen and paper, calculators, and smart phones can all be used to solve simple mathematical problems)."
     )
    ("K-2.CS.c.1"
     "Explain that networks link computers and devices locally and around the world allowing people to access and communicate information."
     )
    ("K-2.CT.a.1"
     "List the attributes of a common object, for example, cars have a color, type (e.g., pickup, van, sedan), number of seats, etc."
     )
    ("K-2.CT.b.1"
     "Define an algorithm as a sequence of defined steps."
     )
    ("K-2.CT.b.2"
     "Create a simple algorithm, individually and collaboratively, without using computers to complete a task (e.g., making a sandwich, getting ready for school, checking a book out of the library)."
     )
    ("K-2.CT.b.3"
     "Enact an algorithm using tangible materials (e.g., manipulatives, your body) or present the algorithm in a visual medium (e.g., storyboard)."
     )
    ("K-2.CT.c.1"
     "Identify different kinds of information (e.g., text, charts, graphs, numbers, pictures, audio, video, collections of objects)."
     )
    ("K-2.CT.c.2"
     "Identify, research, and collect information on a topic, issue, problem, or question using age-appropriate digital technologies."
     )
    ("K-2.CT.c.3"
     "Individually and collaboratively propose a solution to a problem or question based on an analysis of information."
     )
    ("K-2.CT.c.4"
     "Individually and collaboratively create information visualizations (e.g., charts, infographics)."
     )
    ("K-2.CT.c.5"
     "Explain that computers can save information as data that can be stored, searched, retrieved, and deleted."
     )
    ("K-2.CT.d.1"
     "Define a computer program as a set of commands created by people to do something."
     )
    ("K-2.CT.d.2"
     "Explain that computers only follow the programÕs instructions.")
    ("K-2.CT.d.3"
     "Individually or collaboratively create a simple program using visual instructions or tools that do not require a textual programming language (e.g., ÒunpluggedÓ programming activities, a block-based programming language)."
     )
    ("K-2.CT.e.1"
     "Describe how models represent a real-life system (e.g., globe, map, solar system, digital elevation model, weather map)."
     )
    ("K-2.CT.e.2"
     "Define simulation and identify the concepts illustrated by a simple simulation (e.g., growth and health, butterfly life cycle)."
     )
    ("3-5.CAS.a.1"
     "Describe how to use proper ergonomics (e.g., body position, lighting, positioning of equipment, taking breaks) when using devices."
     )
    ("3-5.CAS.a.2"
     "Describe the threats to safe and efficient use of devices (e.g., SPAM, spyware, phishing, viruses) associated with various forms of technology use (e.g., downloading and executing software programs, following hyperlinks, opening files)."
     )
    ("3-5.CAS.a.3"
     "Identify appropriate and inappropriate uses of technology when posting to social media, sending e-mail or texts, and browsing the Internet."
     )
    ("3-5.CAS.a.4"
     "Explain the proper use and operation of security technologies (e.g., passwords, virus protection software, spam filters, popup blockers, cookies)."
     )
    ("3-5.CAS.a.5"
     "Describe ways to employ safe practices and avoid the potential risks/dangers associated with various forms of online communications, downloads, linking, Internet purchases, advertisements, and inappropriate content within constrained environments."
     )
    ("3-5.CAS.a.6"
     "Identify different types of cyberbullying (e.g., harassment, flaming, excluding people, outing, and impersonation)."
     )
    ("3-5.CAS.a.7"
     "Explain that if you encounter cyberbullying or other inappropriate content, you should immediately tell a responsible adult (e.g., teacher, parent)."
     )
    ("3-5.CAS.b.1"
     "Demonstrate responsible use of computers, peripheral devices, and resources as outlined in school rules (Acceptable Use Policy [AUP])."
     )
    ("3-5.CAS.b.2"
     "Describe the difference between digital artifacts that are open or free and those that are protected by copyright."
     "making-game-images"
     )
    ("3-5.CAS.b.3"
     "Explain the guidelines for the fair use of downloading, sharing, or modifying of digital artifacts"
     )
    ("3-5.CAS.b.4"
     "Describe the purpose of copyright and the possible consequences for inappropriate use of digital artifacts that are protected by copyright."
     )
    ("3-5.CAS.b.5"
     "Explain that laws exist (e.g., Section 508, Telecommunication Act of 1996) that help ensure that people with disabilities can access electronic and information technology."
     )
    ("3-5.CAS.c.1"
     "Explain the different forms of web advertising (e.g., search ads, pay-per-click ads, banner ads, targeted ads, in-game ads, e-mail ads)."
     )
    ("3-5.CAS.c.2"
     "Explain why websites, digital resources, and artifacts may include advertisements and collect personal information."
     )
    ("3-5.CAS.c.3"
     "Define the digital divide as unequal access to technology on the basis of differences, such as income, education, age, and geographic location."
     )
    ("3-5.CAS.c.4"
     "Use critical thinking to explain how access to technology helps empower individuals and groups (e.g., gives them access to information, the ability to communicate with others around the world, allows them to buy and sell things)."
     )
    ("3-5.CAS.c.5"
     "Identify resources in the community that can give people access to technology (e.g., libraries, community centers, education programs, schools, hardware/software donation programs)."
     )
    ("3-5.CAS.c.6"
     "Identify ways in which people with disabilities access and use technology (e.g., audio players and recorders, FM listening systems, magnifiers)."
     )
    ("3-5.CAS.c.7"
     "Identify the impact of social media and cyberbullying on individuals, families, and society."
     )
    ("3-5.DTC.a.1"
     "Type five words-per-minute times grade level (e.g., for Grade 5, type 25 words/minute)."
     )
    ("3-5.DTC.a.2"
     "Navigate between local, networked, or online/cloud environments and transfer files between each (upload/download)."
     )
    ("3-5.DTC.a.3"
     "Use digital tools (local and online) to manipulate and publish multimedia artifacts."
     )
    ("3-5.DTC.b.1"
     "Communicate key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using digital tools and media-rich resources"
     )
    ("3-5.DTC.b.2"
     "Collaborate through online digital tools under teacher supervision."
     )
    ("3-5.DTC.c.1"
     "Identify digital information sources to answer research questions (e.g., online library catalog, online encyclopedias, databases, websites)."
     )
    ("3-5.DTC.c.2"
     "Perform searches to locate information using two or more key words and techniques to refine and limit such searches."
     )
    ("3-5.DTC.c.3"
     "Evaluate digital sources for accuracy, relevancy, and appropriateness."
     )
    ("3-5.DTC.c.4"
     "Gather and organize information from digital sources by quoting, paraphrasing, and/or summarizing."
     )
    ("3-5.DTC.c.5"
     "Create an artifact that answers a research question and clearly communicates thoughts and ideas."
     ; TODO(Flannery): do any of the social studies lessons align here?
     )
    ("3-5.DTC.c.6"
     "Cite text-based sources using a school- or district-adopted format."
     )
    ("3-5.DTC.c.7"
     "Provide basic source information (e.g., Uniform Resource Locator [URL], date accessed) for non-text-based sources (e.g., images, audio, video)."
     )
    ("3-5.CS.a.1"
     "Identify a broad range of computing devices (e.g., computers, smart phones, tablets, robots, e-textiles) and appropriate uses for them."
     )
    ("3-5.CS.a.2"
     "Describe the function and purpose of various input and output devices (e.g., monitor, keyboard, speakers, controller, probes, sensors, Bluetooth transmitters, synthesizers)."
     )
    ("3-5.CS.a.3"
     "Demonstrate an appropriate level of proficiency (connect and record data, print, send command, connect to Internet, search) in using a range of computing devices (e.g., probes, sensors, printers, robots, computers)."
     )
    ("3-5.CS.a.4"
     "Identify and solve simple hardware and software problems that may occur during everyday use (e.g., power, connections, application window or toolbar)."
     )
    ("3-5.CS.a.5"
     "Describe the differences between hardware and software."
     )
    ("3-5.CS.a.6"
     "Identify and explain that some computing functions are always active (e.g., locations function on smart phones)."
     )
    ("3-5.CS.b.1"
     "Compare and contrast human and computer performance on similar tasks (e.g., sorting alphabetically, finding a path across a cluttered room) to understand which is best suited to the task."
     )
    ("3-5.CS.b.2"
     "Explain how hardware and applications (e.g., Global Positioning System [GPS] navigation for driving directions, text-to-speech translation, language translation) can enable everyone, including people with disabilities, to do things they could not do otherwise."
     )
    ("3-5.CS.b.3"
     "Explain advantages and limitations of technology (e.g., a spell-checker can check thousands of words faster than a human could look them up, however, a spell-checker might not know whether ÔunderservedÕ is correct or if the authorÕs intent was to type Ôundeserved.Õ"
     )
    ("3-5.CS.c.1"
     "Describe how a network is made up of a variety of components and identify the common components (e.g., links, nodes, networking devices)."
     )
    ("3-5.CS.c.2"
     "Describe the need for authentication of users and devices as it relates to access permissions, privacy, and security."
     )
    ("3-5.CS.c.3"
     "Define and explain why devices are numbered/labeled in networks (e.g., the World Wide Web Uniform Resource Locator [URL], the Internet Protocol [IP] address, the Machine Access Code [MAC])."
     )
    ("3-5.CS.c.4"
     "Recognize that there are many sources of and means for accessing information within a network (e.g., websites, e-mail protocols, search engines)"
     )
    ("3-5.CS.d.1"
     "Identify common services (e.g., driving directions apps that access remote map services, digital personal assistants that access remote information services)."
     )
    ("3-5.CT.a.1"
     "Use numbers or letters to represent information in another form (e.g., secret codes, Roman numerals, abbreviations)."
     )
    ("3-5.CT.a.2"
     "Organize information in different ways to make it more useful/relevant (e.g., sorting, tables)."
     ; TODO(Flannery): do any of the social studies lessons align here?
     )
    ("3-5.CT.a.3"
     "Make a list of sub-problems to consider, while addressing a larger problem."
     )
    ("3-5.CT.b.1"
     "Define an algorithm as a sequence of instructions that can be processed by a computer."
     )
    ("3-5.CT.b.2"
     "Recognize that different solutions exist for the same problem (or sub-problem)."
     )
    ("3-5.CT.b.3"
     "Use logical reasoning to predict outcomes of an algorithm."
     )
    ("3-5.CT.b.4"
     "Individually and collaboratively create an algorithm to solve a problem (e.g., move a character/robot/person through a maze)."
     )
    ("3-5.CT.b.5"
     "Detect and correct logical errors in various algorithms (e.g., written, mapped, live action, or digital)."
     )
    ("3-5.CT.c.1"
     "Describe examples of databases from everyday life (e.g., library catalogs, school records, telephone directories, contact lists)."
     )
    ("3-5.CT.c.2"
     "Individually and collaboratively collect and manipulate data to answer a question using a variety of computing methods (e.g., sorting, totaling, averaging) and tools (such as a spreadsheet) to collect, organize, graph, and analyze data."
     )
    ("3-5.CT.d.1"
     "Individually and collaboratively create, test, and modify a program in a graphical environment (e.g., block-based visual programming language)."
     )
    ("3-5.CT.d.2"
     "Use arithmetic operators, conditionals, and repetition in programs."
     )
    ("3-5.CT.d.3"
     "Use interactive debugging to detect and correct simple program errors."
     )
    ("3-5.CT.d.4"
     "Recognize that programs need known starting values (e.g., set initial score to zero in a game)."
     )
    ("3-5.CT.e.1"
     "Individually and collaboratively create a simple model of a system (e.g., water cycle, solar system) and explain what the model shows and does not show."
     ; MODELING!!
     )
    ("3-5.CT.e.2"
     "Identify the concepts, features, and behaviors illustrated by a simulation (e.g., object motion, weather, ecosystem, predator/prey) and those that were not included."
     ; MODELING!!
     )
    ("3-5.CT.e.3"
     "Individually and collaboratively use data from a simulation to answer a question."
     ; MODELING!!
     )

    ("6-8.CAS.a.1"
     "Identify threats and actively protect devices and networks from viruses, intrusion, vandalism, and other malicious activities."
     )
    ("6-8.CAS.a.2"
     "Describe how cyberbullying can be prevented and managed."
     )
    ("6-8.CAS.a.3"
     "Explain the connection between the persistence of data on the Internet, personal online identity, and personal privacy."
     )
    ("6-8.CAS.a.4"
     "Describe and use safe, appropriate, and responsible practices (netiquette) when participating in online communities (e.g., discussion groups, blogs, social networking sites)."
     )
    ("6-8.CAS.a.5"
     "Differentiate between appropriate and inappropriate content on the Internet."
     )
    ("6-8.CAS.b.1"
     "Explain how copyright law and licensing protect the owner of intellectual property."
     "making-game-images"
     )
    ("6-8.CAS.b.2"
     "Explain possible consequences of violating intellectual property law and plagiarism."
     )
    ("6-8.CAS.b.3"
     "Apply fair use for using copyrighted materials (e.g., images, music, video, text)."
     )
    ("6-8.CAS.b.4"
     "Identify the legal consequences of sending or receiving inappropriate content (e.g., cyberbullying, harassment, sexting)."
     )
    ("6-8.CAS.b.5"
     "Differentiate among open source and proprietary software licenses and their  applicability to different types of software and media."
     )
    ("6-8.CAS.b.6"
     "Demonstrate compliance with the schoolÕs Acceptable Use Policy [AUP]."
     )
    ("6-8.CAS.b.7"
     "Identify software license agreements and application permissions."
     )
    ("6-8.CAS.b.8"
     "Explain positive and malicious purposes of hacking."
     )
    ("6-8.CAS.b.9"
     "License original content and extend license for sharing in the public domain (e.g., creative commons)."
     )
    ("6-8.CAS.c.1"
     "Describe current events and emerging technologies in computing and the effects they may have on education, the workplace, individuals, communities, and global society."
     )
    ("6-8.CAS.c.2"
     "Identify and discuss the technology proficiencies needed in the classroom and the workplace, and how to meet the needs."
     )
    ("6-8.CAS.c.3"
     "Relate the distribution of computing resources in a global society to issues of equity, access, and power."
     )
    ("6-8.CAS.c.4"
     "Evaluate how media and technology can be used to distort, exaggerate, and misrepresent information."
     "measures-of-center"
     "threats-to-validity"
     )
    ("6-8.CAS.c.5"
     "Evaluate the bias of digital information sources, including websites."
     )
    ("6-8.DTC.a.1"
     "Identify and explain the strengths, weaknesses, and capabilities of a variety of digital tools."
     )
    ("6-8.DTC.a.2"
     "Identify the kinds of content associated with different file types and why different file types exist (e.g., formats for word processing, images, music, three-dimensional drawings.)."
     )
    ("6-8.DTC.a.3"
     "Integrate information from multiple file formats into a single artifact."
     )
    ("6-8.DTC.a.4"
     "Individually and collaboratively use advanced tools to design and create online content (e.g., digital portfolio, multimedia, blog, webpage)."
     "making-game-images"
     "functions-for-character-animation"
     "inequalities3-sam"
     "inequalities-collision"
     "distance-formula"
     "player-animation"
     "project-video-game"
     )
    ("6-8.DTC.a.5"
     "Individually and collaboratively develop and conduct an online survey."
     "data-collection"
     )
    ("6-8.DTC.b.1"
     "Communicate and publish key ideas and details individually or collaboratively in a way that informs, persuades, and/or entertains using a variety of digital tools and media-rich resources."
     "project-research-paper"
     )
    ("6-8.DTC.b.2"
     "Collaborate synchronously and asynchronously through online digital tools."
     )
    ("6-8.DTC.b.3"
     "Demonstrate ability to communicate appropriately through various online tools (e.g., email, social media, texting, blog comments)."
     )
    ("6-8.DTC.c.1"
     "Perform advanced searches to locate information using a variety of digital sources (e.g., Boolean Operators, limiters like reading level, subject, media type)."
     )
    ("6-8.DTC.c.2"
     "Evaluate quality of digital sources for reliability, including currency, relevancy, authority, accuracy, and purpose of digital information."
     )
    ("6-8.DTC.c.3"
     "Gather, organize, and analyze information from digital sources by quoting, paraphrasing, and/or summarizing."
     )
    ("6-8.DTC.c.4"
     "Create an artifact, individually and collaboratively, that answers a research question and communicates results and conclusions."
     "project-research-paper"
     )
    ("6-8.DTC.c.5"
     "Use digital citation tools to cite sources using a school- or district-adopted format (e.g., Modern Language Association [MLA]), including proper citation for all text and nontext sources (e.g., images, audio, video)."
     )
    ("6-8.CS.a.1"
     "Describe the main functions of an operating system."
     )
    ("6-8.CS.a.2"
     "Recognize that there is a wide range of application software."
     )
    ("6-8.CS.a.3"
     "Identify and describe the function of the main internal parts of a basic computing device (e.g., motherboard, hard drive, Central Processing Unit [CPU])."
     )
    ("6-8.CS.a.4"
     "Identify and describe the use of sensors, actuators, and control systems in an embodied system (e.g., a robot, an e-textile, installation art, smart room)."
     )
    ("6-8.CS.a.5"
     "Individually and collaboratively design and demonstrate the use of a device (e.g., robot, e-textile) to accomplish a task."
     )
    ("6-8.CS.a.6"
     "Use a variety of computing devices (e.g., probes, sensors, handheld devices, Global Positioning System [GPS]) to individually and collaboratively collect, analyze, and present information for content-related problems."
     )
    ("6-8.CS.a.7"
     "Identify steps involved in diagnosing and solving routine hardware and software problems (e.g., power, connections, application window or toolbar, cables, ports, network resources, video, sound) that occur during everyday computer use."
     )
    ("6-8.CS.b.1"
     "Explain why some problems can be solved more easily by computers or humans based on a general understanding of types of tasks at which each excels."
     )
    ("6-8.CS.b.2"
     "Describe how humans and machines interact to solve problems that cannot be solved by either alone (e.g., Òbig dataÓ experiments that involve drawing conclusions by analyzing vast amounts of data)."
     )
    ("6-8.CS.c.1"
     "Explain the difference between physical (wired), local and wide area, wireless, and mobile networks."
     )
    ("6-8.CS.c.2"
     "Model the components of a network, including devices, routers, switches, cables, wires, and transponders."
     )
    ("6-8.CS.c.3"
     "Describe how information, both text and non-text, is translated and communicated between digital devices over a computer network."
     )
    ("6-8.CS.d.1"
     "Identify capabilities of devices that are enabled through services (e.g., a wearable device that stores fitness data in the cloud, a mobile device that uses location services for navigation)."
     )
    ("6-8.CT.a.1"
     "Describe how data is abstracted by listing attributes of everyday items to represent, order and compare those items (e.g., street address as an abstraction for locations; car make, model, and license plate number as an abstraction for cars)."
     )
    ("6-8.CT.a.2"
     "Define a simple function that represents a more complex task/problem and can be reused to solve similar tasks/problems."
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
    ("6-8.CT.a.3"
     "Use decomposition to define and apply a hierarchical classification scheme to a complex system, such as the human body, animal classification, or in computing."
     )
    ("6-8.CT.b.1"
     "Design solutions that use repetition and conditionals."
     "piecewise-functions-conditionals"
     "player-animation"
     "table-methods"
     "codap-transformers-1"
     "codap-transformers-2"
     "defining-table-functions"
     )
    ("6-8.CT.b.2"
     "Use logical reasoning to predict outputs given varying inputs."
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
    ("6-8.CT.b.3"
     "Individually and collaboratively decompose a problem and create a sub-solution for each of its parts (e.g., video game, robot obstacle course, making dinner)."
     "problem-decomposition"
     "inequalities-collision"
     )
    ("6-8.CT.b.4"
     "Recognize that more than one algorithm can solve a given problem."
     )
    ("6-8.CT.b.5"
     "Recognize that boundaries need to be taken into account for an algorithm to produce correct results."
     "inequalities3-sam"
     )
    ("6-8.CT.c.1"
     "Demonstrate that numbers can be represented in different base systems (e.g., binary, octal, and hexadecimal) and text can be represented in different ways (e.g., American Standard Code for Information Interchange [ASCII])."
     )
    ("6-8.CT.c.2"
     "Describe how computers store, manipulate, and transfer data types and files (e.g., integers, real numbers, Boolean Operators) in a binary system."
     )
    ("6-8.CT.c.3"
     "Create, modify, and use a database (e.g., define field formats, add new records, manipulate data), individually and collaboratively, to analyze data and propose solutions for a task/problem."
     )
    ("6-8.CT.c.4"
     "Perform a variety of operations such as sorting, filtering, and searching in a database to organize and display information in a variety of ways such as number formats (scientific notation and percentages), charts, tables, and graphs."
     "table-methods"
     "codap-transformers-1"
     "codap-transformers-2"
     )
    ("6-8.CT.c.5"
     "Select and use data-collection technology (e.g., probes, handheld devices, geographic mapping systems) to individually and collaboratively gather, view, organize, analyze, and report results for content-related problems."
     "data-collection"
     )
    ("6-8.CT.d.1"
     "Individually and collaboratively compare algorithms to solve a problem, based on a given criteria (e.g., time, resource, accessibility)."
     )
    ("6-8.CT.d.2"
     "Use functions to hide the detail in a program."
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
    ("6-8.CT.d.3"
     "Create a program, individually and collaboratively, that implements an algorithm to achieve a given goal."
     )
    ("6-8.CT.d.4"
     "Implement problem solutions using a programming language, including all of the following: looping behavior, conditional statements, expressions, variables, and functions."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     "codap-transformers-1"
     "codap-transformers-2"
     "piecewise-functions-conditionals"
     "player-animation"
     )
    ("6-8.CT.d.5"
     "Trace programs step-by-step in order to predict their behavior."
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
    ("6-8.CT.d.6"
     "Use an iterative approach in development and debugging to understand the dimensions of a problem clearly."
     "debugging"
     )
    ("6-8.CT.e.1"
     "Create a model of a real-world system and explain why some details, features and behaviors were required in the model and why some could be ignored."
     ; MODELING!!
     )
    ("6-8.CT.e.2"
     "Use and modify simulations to analyze and illustrate a concept in depth (e.g., light rays/mechanical waves interaction with materials, genetic variation)."
     ; MODELING!!
     )
    ("6-8.CT.e.3"
     "Select and use computer simulations, individually and collaboratively, to gather, view, analyze, and report results for content-related problems (e.g., migration, trade, cellular function)."
     ; MODELING!!
     )
    ("9-12.CAS.a.1"
     "Evaluate and design an ergonomic work environment."
     )
    ("9-12.CAS.a.2"
     "Explain safe practices when collaborating online, including how to anticipate potentially dangerous situations."
     )
    ("9-12.CAS.a.3"
     "Construct strategies to combat cyberbullying/harassment."
     )
    ("9-12.CAS.a.4"
     "Identify the mental health consequences of cyberbullying/harassment."
     )
    ("9-12.CAS.a.5"
     "Explain how peer pressure in social computing settings influences choices."
     )
    ("9-12.CAS.a.6"
     "Apply strategies for managing negative peer pressure and encouraging positive peer pressure."
     )
    ("9-12.CAS.b.1"
     "Model mastery of the schoolÕs Acceptable Use Policy [AUP]."
     )
    ("9-12.CAS.b.2"
     "Identify computer-related laws and analyze their impact on digital privacy, security, intellectual property, network access, contracts, and consequences of sexting and harassment."
     )
    ("9-12.CAS.b.3"
     "Discuss the legal and ethical implications associated with malicious hacking and software piracy."
     )
    ("9-12.CAS.b.4"
     "Interpret software license agreements and application permissions."
     )
    ("9-12.CAS.c.1"
     "Explain the impact of the digital divide on access to critical information."
     )
    ("9-12.CAS.c.2"
     "Discuss the impact of computing technology on business and commerce (e.g., automated tracking of goods, automated financial transaction, e-commerce, cloud computing)."
     )
    ("9-12.CAS.c.3"
     "Describe the role that assistive technology can play in peopleÕs lives."
     )
    ("9-12.CAS.c.4"
     "Create a digital artifact that is designed to be accessible (e.g., closed captioning for audio, alternative text for images)."
     )
    ("9-12.CAS.c.5"
     "Analyze the beneficial and harmful effects of computing innovations (e.g., social networking, delivery of news and other public media, intercultural communication)."
     )
    ("9-12.CAS.c.6"
     "Cultivate a positive web presence (e.g., digital resume, portfolio, social media)."
     )
    ("9-12.CAS.c.7"
     "Identify ways to use technology to support lifelong learning."
     )
    ("9-12.CAS.c.8"
     "Analyze the impact of values and points of view that are presented in media messages (e.g., racial, gender, political)."
     )
    ("9-12.CAS.c.9"
     "Discuss the social and economic implications associated with malicious hacking, software piracy, and cyber terrorism."
     )
    ("9-12.DTC.a.1"
     "Use digital tools to design and develop a significant digital artifact (e.g., multipage website, online portfolio, simulation)."
     "project-research-paper"
     "project-exploration-paper"
     "project-video-game"
     )
    ("9-12.DTC.a.2"
     "Select digital tools or resources based on their efficiency and effectiveness to use for a project or assignment, and justify the selection."
     )
    ("9-12.DTC.b.1"
     "Communicate and publish key ideas and details to a variety of audiences using digital tools and media-rich resources."
     )
    ("9-12.DTC.b.2"
     "Collaborate on a substantial project with outside experts or others through online digital tools (e.g., science fair project, community service project, capstone project)."
     )
    ("9-12.DTC.c.1"
     "Generate, evaluate, and prioritize questions that can be researched through digital resources or tools."
     "ds-intro"
     "project-research-paper"
     "project-exploration-paper"
     )
    ("9-12.DTC.c.2"
     "Perform advanced searches to locate information and/or design a data-collection approach to gather original data (e.g., qualitative interviews, surveys, prototypes, simulations)."
     )
    ("9-12.DTC.c.3"
     "Evaluate digital sources needed to solve a given problem (e.g., reliability, point of view, relevancy)."
     )
    ("9-12.DTC.c.4"
     "Gather, organize, analyze, and synthesize information using a variety of digital tools."
     "data-collection"
     )
    ("9-12.DTC.c.5"
     "Create an artifact that answers a research question, communicates results and conclusions, and cites sources."
     "project-research-paper"
     "project-exploration-paper"
     )
    ("9-12.CS.a.1"
     "Select computing devices (e.g., probe, sensor, tablet) to accomplish a real-world task (e.g., collecting data in a field experiment) and justify the selection."
     )
    ("9-12.CS.a.2"
     "Examine how the components of computing devices are controlled by and react to programmed commands."
     )
    ("9-12.CS.a.3"
     "Apply strategies for identifying and solving routine hardware and software problems that occur in everyday life (e.g., update software patches, virus scan, empty trash, run utility software, close all programs, reboot, use help sources)."
     )
    ("9-12.CS.a.4"
     "Explain and demonstrate how specialized computing devices can be used for problem solving, decision-making and creativity in all subject areas."
     )
    ("9-12.CS.a.5"
     "Describe how computing devices manage and allocate shared resources (e.g., memory, Central Processing Unit [CPU])."
     )
    ("9-12.CS.a.6"
     "Examine the historical rate of change in computing devices (e.g., power/energy, computation capacity, speed, size, ease of use) and discuss the implications for the future."
     )
    ("9-12.CS.b.1"
     "Identify a problem that cannot be solved by humans or machines alone and design a solution for it by decomposing the task into sub-problems suited for a human or machine to accomplish (e.g., a human-computer team playing chess, forecasting weather, piloting airplanes)."
     )
    ("9-12.CS.c.1"
     "Explain how network topologies and protocols enable users, devices, and systems to communicate with each other."
     )
    ("9-12.CS.c.2"
     "Examine common network vulnerabilities (e.g., cyberattacks, identity theft, privacy) and their associated responses."
     )
    ("9-12.CS.c.3"
     "Examine the issues (e.g., latency, bandwidth, firewalls, server capability) that impact network functionality."
     )
    ("9-12.CS.d.1"
     "Compare the value of using an existing service versus building the equivalent functionality (e.g., using a reference search engine versus creating a database of references for a project)."
     )
    ("9-12.CS.d.2"
     "Explain the concept of quality of service (e.g., security, availability, performance) for services providers (e.g., online storefronts that must supply secure transactions for buyer and seller)."
     )
    ("9-12.CT.a.1"
     "Discuss and give an example of the value of generalizing and decomposing aspects of a problem in order to solve it more effectively."
     "problem-decomposition"
     "inequalities-collision"
     "re-nested-structures"
     )
    ("9-12.CT.b.1"
     "Recognize that the design of an algorithm is distinct from its expression in a programming language."
     )
    ("9-12.CT.b.2"
     "Represent algorithms using structured language, such as pseudocode."
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
    ("9-12.CT.b.3"
     "Explain how a recursive solution to a problem repeatedly applies the same solution to smaller instances of the problem."
     ; I hope to god we teach this someday
     )
    ("9-12.CT.b.4"
     "Describe that there are ways to characterize how well algorithms perform and that two algorithms can perform differently for the same task."
     )
    ("9-12.CT.b.5"
     "Explain that there are some problems which cannot be computationally solved."
     )
    ("9-12.CT.c.1"
     "Describe how data types, structures, and compression in programs affect data storage and quality (e.g., digital image file sizes are affected by resolution and color depth)."
     )
    ("9-12.CT.c.2"
     "Create an appropriate multidimensional data structure that can be filtered, sorted, and searched (e.g., array, list, record)."
     "codap-transformers-1"
     "codap-transformers-2"
     "table-methods"
     "defining-table-functions"
     )
    ("9-12.CT.c.3"
     "Create, evaluate, and revise data visualization for communication and knowledge."
     "bar-and-pie-charts"
     "codap-bar-charts"
     "codap-exploring"
     "histograms"
     "histograms2"
     "box-plots"
     "advanced-displays"
     "scatter-plots"
     "correlations"
     "linear-regression"
     )
    ("9-12.CT.c.4"
     "Analyze a complex data set to answer a question or test a hypothesis (e.g., analyze a large set of weather or financial data to predict future patterns)."
     )
    ("9-12.CT.c.5"
     "Identify different problems (e.g., large or multipart problems, problems that need specific expertise, problems that affect many constituents) that can benefit from collaboration when processing and analyzing data to develop new insights and knowledge."
     )
    ("9-12.CT.d.1"
     "Use a development process in creating a computational artifact that leads to a minimum viable product and includes reflection, analysis, and iteration (e.g., a data-set analysis program for a science and engineering fair, capstone project that includes a program, term research project based on program data)."
     "project-research-paper"
     )
    ("9-12.CT.d.2"
     "Decompose a problem by defining functions which accept parameters and produce return values."
     )
    ("9-12.CT.d.3"
     "Select the appropriate data structure to represent information for a given problem (e.g., records, arrays, lists)."
     "table-methods"
     "defining-table-functions"
     "codap-transformers-1"
     "codap-transformers-2"
     )
    ("9-12.CT.d.4"
     "Analyze trade-offs among multiple approaches to solve a given problem (e.g., space/time performance, maintainability, correctness, elegance)."
     )
    ("9-12.CT.d.5"
     "Use appropriate looping structures in programs (e.g., FOR, WHILE, RECURSION)."
     "table-methods"
     "defining-table-functions"
     "codap-transformers-1"
     "codap-transformers-2"
     )
    ("9-12.CT.d.6"
     "Use appropriate conditional structures in programs (e.g., IF-THEN, IF-THEN-ELSE, SWITCH)."
     "piecewise-functions-conditionals"
     "player-animation"
     "re-key-events"
     )
    ("9-12.CT.d.7"
     "Use a programming language or tool feature correctly to enforce operator precedence."
     "order-of-operations"
     )
    ("9-12.CT.d.8"
     "Use global and local scope appropriately in program design (e.g., for variables)."
     "project-video-game"
     "project-research-paper"
     "project-exploration-paper"
     "flags"
     )
    ("9-12.CT.d.9"
     "Select and employ an appropriate component or library to facilitate programming solutions (e.g., turtle, Global Positioning System [GPS], statistics library)."
     )
    ("9-12.CT.d.10"
     "Use an iterative design process, including learning from making mistakes, to gain a better understanding of the problem domain."
     "project-video-game"
     "project-research-paper"
     "project-exploration-paper"
     "flags"
     )
    ("9-12.CT.d.11"
     "Engage in systematic testing and debugging methods to ensure program correctness."
     "debugging"
     )
    ("9-12.CT.d.12"
     "Demonstrate how to document a program so that others can understand its design and implementation."
     "functions-dr"
     )
    ("9-12.CT.e.1"
     "Create models and simulations to help formulate, test, and refine hypotheses."
     ; MODELING!
     )
    ("9-12.CT.e.2"
     "Form a model from a hypothesis generated from research and run a simulation to collect and analyze data to test that hypothesis."
     ; MODELING!
     )
    ))

