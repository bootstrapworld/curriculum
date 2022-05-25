---
{layout="Math Title Slide"}
# Solving Word Problems with the Design Recipe

---
{layout="Launch"}
# The Design Recipe 

A word problem is a description of a situation, but seeing the math behind the words can be challenging!

In this lesson, you're going to learn a strategy for breaking down word problems, called the *Design Recipe*. You've actually seen most of the steps of the Design Recipe, but you _haven't_ seen how to put them together. There's also one part you haven't seen yet: _writing a purpose statement_.

---
{layout="Launch"}
# The Design Recipe 

* On @printable-exercise{matching-wp-purpose.adoc}, we see four word problems and four purposes statements. Take 2 minutes to read them and see if you can find any that describe the same thing and should be matched to each other.
* What pairs did you come up with?
* What do you Notice about those purpose statements? Do they have anything in common?

---
{layout="Launch"}
# The Design Recipe 

Purpose statements should have enough details to allow us to write examples without looking at the word problem!

* Turn to @printable-exercise{pages/create-examples-contracts-purpose-1.adoc}, read the purpose statements, and write examples that satisfy each of the contracts and purpose statements.
* For more practice, complete @opt-printable-exercise{pages/create-examples-contracts-purpose-2.adoc}.

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

Turn to @printable-exercise{fixing-purpose.adoc} and identify: 

1. What important information got left out of each of the purpose statements?

1. What unnecessary information got included?

---
{layout="Synthesize"}
# The Design Recipe 

* What are the important elements of purpose statements?
* Why are purpose statements useful?

---
{layout="Launch-DN"}
# Rocket Height! 

Open the @starter-file{rocket-height} and look at the code before you click run.

What do you Notice? What do you Wonder?

---
{layout="Launch-DN"}
# Rocket Height! 

Click Run to see the simulation start running on your computer.

* What happens when you press the spacebar? 
* What were you expecting to happen? 
* What happens when you press `b`? 
* Is `rocket-height` working? 
* Close the window with the rocket, so you can see the code.

---
{layout="Launch-DN"}
# Rocket Height! 

Let's investigate why we weren't alerted to the problem when the computer checked the function definition against the examples.{style="font-size:17pt"}

* Type @show{(code '(rocket-height 0))} into the interactions area.{style="font-size:17pt"}
* As the program is currently written, what happens when we give the `rocket-height` function an input of 0? {style="font-size:17pt"}
* Is that what we want it to do? {style="font-size:17pt"}
* As the program is currently written, what happens when we give the `rocket-height` function an input of 10?{style="font-size:17pt"} 
* Is that what we want it to do?{style="font-size:17pt"}
* Why did the examples pass? {style="font-size:17pt"}

<!--
We should always test a function definition against at least 2 examples!
-->

---
{layout="Investigate"}
# Rocket Height! 

Let's use the Design Recipe to fix `rocket-height` and get comfortable with writing *purpose statements*.

Complete @printable-exercise{pages/rocket-height.adoc}.

<!--
As students work, circle the room and make sure that their @vocab{purpose statements} are strong enough that they could write examples without looking at the original word problem. Encourage students to circle what's changing in their examples and label with descriptive variables.
-->


---
{layout="Investigate"}
# Rocket Height

@image{images/rocket-height-contract.png, a}{width="700"}


---
{layout="Investigate"}
# Rocket Height

@image{images/rocket-height-dr.png, a}{width="700"}



---
{layout="Investigate-DN"}
# Rocket Height! 

Once you've completed the Design Recipe page for `rocket-height`, type the code into definitions area, replacing any missing and incorrect code with your own.

Be sure to add the contract, purpose statement, and examples.

Save your work when you're done!


---
{layout="Investigate-DN"}
# Rocket Height!

At the bottom of the Definitions area, you'll see some commented lines of code with instructions. 

You already know what `(start rocket-height)` does. 
- What about `(space rocket-height)`?
- Try out `(everything rocket-height)`, too!

---
{layout="Synthesize"}
# Rocket Height! 

- What problems did you fix in the starter file?
- What did the other functions do?

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
