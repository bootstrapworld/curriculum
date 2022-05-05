---

# The Numbers Inside Video Games

---
# Reverse Engineering a Video Game

Take turns playing the @starter-file{ninja-cat} in pairs.

Turn to @printable-exercise{pages/NoticeAndWonder.adoc}. 

1. Write down what you _notice_ about the game.
*"Notice"s should be statements, not questions. What stood out to you? What do you remember?*

1. Write down what you _wonder_ about the game? 
*What questions do you have about how it works?*

<!--
This pedagogy has a @link{https://www.learning-space.org/Page/96, rich grounding in literature}, and is used throughout this course. In the "Notice" phase, students are asked to crowd-source their observations. No observation is too small or too silly! By listening to other students' observations, students may find themselves taking a closer look at the game. The "Wonder" phase involves students raising questions, but they must also explain the context for those questions. Sharon Hessney (moderator for the NYTimes excellent @link{https://www.nytimes.com/column/whats-going-on-in-this-graph, What's going on in this Graph?} activity) sometimes calls this "what do you wonder...and *why*?". Both of these phases should be done in groups or as a whole class, with adequate time given to each.
-->

---
# Reverse Engineering a Video Game

Complete @printable-exercise{pages/ReverseEngineerGame.adoc} with your partner.

<!-- 
Common Misconceptions:
- Students are likely to describe what the character is _doing_, as opposed to _what changes_. For example: "The dog is moving to the left" is not actualy describing the property being changed (position, place, location, etc).
- Students may write down what they _hope_ is changeable, as opposed to what actually changes. It's common for students to say they cat's costume is changing, because they assume the cat will somehow "level up" if they get enough points.
-->

---
# Reverse Engineering a Video Game

While we see images on a screen, the computer only sees a small set of numbers, which uniquely model the state of the game. The way those numbers change determines how the game behaves, and we can add features to the game if we're willing to keep track of more numbers.

- If the x- and y-coordinates are each numbers, how many numbers does it take to represent a single frame of the video game?
- How are those numbers changing - or _varying_ - as the game plays? When do they increase? Decrease?
- How many numbers would we need if the dog could also move up and down?
- How many numbers would we need to have a two-player game?
- How many numbers would we need if the entire game was in 3d?
- How many numbers would we need to make a modern game?

---
# Connecting to Real Games 

What are your favorite current video games?

<!--
	Project their list on the board and select one to discuss as a class.
-->

---
# Connecting to Real Games 

Let's focus on one of the games we just brainstormed.

* How long do you think it took to create that game?
* How _many people_ do you think it takes to create a game like that?
* How _much money_ does it take to create a game like that?

*Optional:* Use the Internet to research these questions and compare the actual numbers to your estimates.

<!--
There's a lot of variability, especially between game consoles and cell phone games! But here's a few sample numbers:

@table{4}
| Title								| Time		| Team Size 	| Budget
| Call of Duty: Modern Warfare 2	| 2 years	| 500+			| 50m+
| Final Fantasy VII					| 3 years	| 100+			| 40-45m
| Shadow of the Tomb Raider			| 3+ years	| 100+			| 75m+

The goal here is not to discourage students from the possibility of eventually creating a game like their favorite game, but to manage expectations given our limited resources (time, money, and people).  By starting with this game project, students are learning transferable skills that can help them later on in learning new programming languages and creating bigger projects.
-->

---
# Connecting to Real Games 

Are we likely to create games like the ones you researched?

<!--
The 3d, two-player version of NinjaCat needed a lot more numbers than the simple one you saw here, _but the actual concepts at work are the same_. Even if we don't have time to make games like the ones we chose here, you'll learn the same concepts just by making a simpler one.
-->
