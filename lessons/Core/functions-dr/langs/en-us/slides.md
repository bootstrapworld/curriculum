---
{layout="Core Title Slide"}
# Solving Word Problems with the Design Recipe{font-size:36pt}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# The Design Recipe 

A word problem is a description of a situation, but seeing the math behind the words can be challenging!

In this lesson, you're going to learn a strategy for breaking down word problems, called the **Design Recipe**. You've actually seen most of the steps of the Design Recipe, but you _haven't_ seen how to put them together. There's also one part you haven't seen yet: _writing a purpose statement_.

<!--
* Code should be easy to read! There may be other people looking at your code who could use a hint about what it does, and even the person who wrote the code could benefit from a note here and there. @vocab{Comments} are parts of a program that the computer ignores - they are for human eyes only!
* The @vocab{Purpose Statement} is a structured way of restating the problem. In a computer program, it's written as a comment in the code - something the computer doesn't read.
* Remind students that the @vocab{Domain} and @vocab{Range} of a function must be a _set_ of possible inputs and outputs. In math, some of these sets have shorthands like Integers, Rationals, etc. In programming, we have shorthands for @vocab{data types} like Number, String, Image, Boolean, etc.
* If students struggle with creating the examples, use the Circle of Evaluation mapping activity or use role-playing to help students build up their understanding around the concept.
-->

---
{layout="Launch"}
# The Design Recipe 

* On @printable-exercise{matching-wp-purpose.adoc}, we see four word problems and four purposes statements. 
* Take 2 minutes to read them and see if you can find any that describe the same thing and should be matched to each other.
* What pairs did you come up with?
* What do you Notice about those purpose statements? Do they have anything in common?

---
{layout="Launch"}
# The Design Recipe 

Purpose statements should have enough details to allow us to write examples without looking at the word problem!

* Turn to @printable-exercise{pages/create-examples-contracts-purpose-1.adoc}, read the purpose statements, and write examples that satisfy each of the contracts and purpose statements.
* @optional for more practice, complete @opt-printable-exercise{pages/create-examples-contracts-purpose-2.adoc}.

---
{layout="Launch"}
# The Design Recipe 

A good purpose statement must have three things:

1. A description of what the function _consumes_

1. A description of what the function _produces_

1. All the _relevant information_ about how to produce that output

---
{layout="Investigate"}
# The Design Recipe 

Turn to @printable-exercise{fixing-purpose.adoc}.

ChatGPT has produced a purpose statement for each word problem... but ran into some difficulties. Fix ChatGPT's purpose statements, and then identify: 

1. What important information was missing from each purpose statement that you would need to solve the problem? 

1. What extra information was included, that wasn't needed to solve the problem?

---
{layout="Synthesize"}
# The Design Recipe 

* What are the important elements of purpose statements?
* Why are purpose statements useful?

<!--
The three steps of the Design Recipe are designed to mirror best practices that you may _already be using in your classroom_. It's merely a collection of those practices, assembled in a structured way with great care taken to connecting each practice with the others.

**Writing the Contract and Purpose Statement is where students _understand_ the word problem.** If you have your students restate the problem in their own words, draw pictures, or underline the inputs and outputs in the word problem, __you're already using this practice!__

**Writing examples and circling-and-labeling what changes is where students _apply_ their understanding** to concrete inputs. If you have your students work through some concrete examples before jumping straight to variables and formulas, and ask them "what's the rule?" or "what's the pattern?", __you're already using this practice!__.

**Writing the definition is where students _formalize and abstract_ this understanding** to work with _any input_. This is where they identify the structure of the rule or pattern, independently of any specific inputs.

The order of the recipe is a recommendation based on 20+ years of research about what works for most students, but that doesn't mean this order works best for _every_ student! Some may find it easier to work through a concrete example or two before thinking about Domain and Range, and there's nothing wrong with that. We encourage you to use the Recipe in your classroom as often as possible, teaching students to be flexible with the tools and representations it includes.
-->

---
{layout="Launch"}
# Rocket Height

A few students found some Artificial Intelligence (A.I.) tools that claim to be able to write Pyret programs for them. 

They asked the A.I. to generate code that makes a rocket blast off, starting on the ground (height=0) when the rocket first blasts off (time=0). The A.I. wrote the program for them.

How do they know if it really solved the problem correctly?

---
{layout="Launch-DN"}
# Rocket Height

* Open the @starter-file{rocket-height} in a new tab, and Save/Remix a copy of your own.
* Read the code before you click Run.
* What do you Notice? What do you Wonder?

---
{layout="Launch-DN"}
# Rocket Height

Click Run to see the simulation start running on your computer.

* What happens when you press the spacebar? 
* What were you expecting to happen? 
* What happens when you press `b`? 
* Is `rocket-height` working? 
* Close the window with the rocket, so you can see the code.

<!--
* What happens when you press the space bar?
** _The seconds change, but the rocket doesn't move!_
* What were you expecting to happen?
** _The rocket would move!_
* What happens when you press `b`?
** _The seconds go back down, but the rocket height stays at 0_
* Is `rocket-height` working?
** _No._
-->
---
{layout="Launch-DN"}
# Rocket Height

Let's investigate why we weren't alerted to the problem when the computer checked the function definition against the examples.{style="font-size:17pt"}

* Type @show{(code '(rocket-height 0))} into the Interactions Area.{style="font-size:17pt"}
* What happens when we give the `rocket-height` function an input of 0? Is that what we want it to do? {style="font-size:17pt"}
* What happens when we give the `rocket-height` function an input of 10? Is that what we want it to do?{style="font-size:17pt"}
* Why did the examples pass? {style="font-size:17pt"}

<!--
We should always test a function definition against at least 2 examples!

What happens when we give the `rocket-height` function an input of 0?
** _It returns 0._
* Is that what we want it to do?
** _Yes!_
* As the program is currently written, what happens when we give the `rocket-height` function an input of 10?
** _It returns 0._
* Is that what we want it to do?
** _No!_
* Why did the examples pass?
** _The programmer only gave one example! We should always provide at least two examples. More complex functions will require us to think about what range of examples will be necessary to test that our function does what we want it to!_
-->

---
{layout="Investigate"}
# Rocket Height

Let's use the Design Recipe to fix `rocket-height` and get comfortable with writing *purpose statements*.

Complete @printable-exercise{pages/rocket-height.adoc}.

<!--
As students work, circle the room and make sure that their @vocab{purpose statements} are strong enough that they could write examples without looking at the original word problem. Encourage students to circle what's changing in their examples and label with descriptive variables.
-->


---
{layout="Investigate"}
# Rocket Height

@image{images/rocket-height-contract.png}{width="700"}


---
{layout="Investigate"}
# Rocket Height

@image{images/rocket-height-dr.png}{width="700"}



---
{layout="Investigate-DN"}
# Rocket Height

Once you've completed the Design Recipe page for `rocket-height`, type the code into Definitions Area, replacing any missing and incorrect code with your own.

Be sure to add the Contract, purpose statement, and examples.

Save your work when you're done!


---
{layout="Investigate-DN"}
# Rocket Height

At the bottom of the Definitions Area, you'll see some commented lines of code with instructions. 

You already know what @show{(code '(blastoff rocket-height))} does. 
- What about @show{(code '(space rocket-height))}?
- Try out @show{(code '(everything rocket-height))}, too!

---
{layout="Synthesize"}
# Rocket Height

- What problems did you fix in the starter file?
- What did the other functions do?

---
{layout="Synthesize"}
# Rocket Height

* Can you make the rocket fly faster? 
* Can you make the rocket fly slower?
* Can you make the rocket sink down instead of fly up?

<!--
For teachers who cover quadratic and exponential functions or have students who need more of a challenge, here are some fun prompts:

- *Changing slope:* Can you make the rocket fly faster? Slower?
- *Changing sign:* Can you make the rocket sink down instead of fly up?
- *Motivating Quadratic Functions:* Can you make the rocket _accelerate over time_, so that it moves faster the longer it flies?
- *Practicing the Quadratic Formula:* Can you make the rocket blast off _and then land again_?
- *More practice:* Can you make the rocket blast off, _reach a maximum height of exactly 1000 meters_, and then land?
- *More practice:* Can you make the rocket blast off, reach a maximum height of exactly 1000 meters, and then land after exactly 100 seconds?
- *Motivating Exponential Functions:* Can you make the rocket fly to the edge of the the universe?
-->

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{pages/create-examples-contracts-purpose-2.adoc}
- @opt-printable-exercise{dr-restaurants.adoc}
- @opt-printable-exercise{dr-direct-variation.adoc}
- @opt-printable-exercise{dr-slope-intercept-1.adoc}
- @opt-printable-exercise{dr-neg-slope.adoc}
- @opt-printable-exercise{dr-geometry-rectangles.adoc}
- @opt-printable-exercise{dr-geometry-rect-prism.adoc}
- @opt-printable-exercise{dr-geometry-circles.adoc}
- @opt-printable-exercise{dr-geometry-cylinder.adoc}
- @opt-printable-exercise{dr-breaking-even.adoc}
- @opt-printable-exercise{dr-marquee.adoc}
- @opt-printable-exercise{dr-blank.adoc}
