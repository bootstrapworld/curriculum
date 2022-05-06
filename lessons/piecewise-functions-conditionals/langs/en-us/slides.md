---

# Piecewise Functions and Conditionals

---
# Intro to Piecewise Functions

How would you explain a _function_ to someone else? What are some rules that all functions follow?

<!--
A function has exactly one output for each input.
-->

---
# Intro to Piecewise Functions

Today we are going to act out a special kind of function.

* If your birthday is in the summer, make an O with your arms
* If your birthday is in the fall, make an X with your arms or body.
* If your birthday is in the winter, put your hand on your head.
* If your birthday is in the spring, flap your arms like a chicken.

<!-- 
Debrief how students decided what to do. You might do this while students are still in motion or it might work better with your class to stop the activity before discussing it.

_Example Questions: Ask a student with their hands on their head why they aren't flapping their arms like a chicken.
Ask a student making an O with their arms how they knew what to do._
-->

---
# Intro to Piecewise Functions

* What is the input of the function we just acted out?
* What is the output of the function we just acted out?
* How do we know that you just acted out a function?

<!--
_Since each student ("input") has only one action ("output"), it is still a function_.
-->

---
# Intro to Piecewise Functions

Up until now, all of the functions we have seen can be described by a single rule. 

In this activity your behavior followed a _set of rules_ for which each input still had exactly one output. 

This is called a _piecewise function_ in math, and a _conditional_ in programming. 

The world is full of piecewise functions and conditionals!

---
# Intro to Piecewise Functions

Let's try acting out another set of rules.

* Everyone wearing sneakers put your hands on your head.
* Everyone wearing a t-shirt make a T with your arms.
* Everyone wearing pants put your hands on your hips.
* Everyone wearing a t-shirt make an O with your arms.

<!--
_Some students should have nothing to do. Others should look confused as to what to do. They may be wearing sneakers and pants and not be able to put their hands on their head and on their hips at the same time. They may be wearing a tshirt and not be able to make a T and an O with their arms simultaneously._
-->

---
# Intro to Piecewise Functions

This set of rules doesn't seem to have worked quite as well as the last...

_A function has exactly one output for each input._

Why doesn't this set of directions represent a function?

<!--
_Because people wearing a tshirt were told to do two conflicting things! And people wearing sneakers and pants were told to do two conflicting things!_

-->

---
# Intro to Piecewise Functions

Work with your partner to think of real-world examples of piecewise functions.

_Here are a few examples to get you started:_

* Places like movie theaters and museums often have different ticket prices for students, children, and senior citizens. That means the total price can't be determined simply by asking how many tickets there are -- the price-per-person is conditioned on what kind of ticket is being purchased!

* The US Postal Service charges a different rate for differently-sized letters and packages. That means the total price can't be determined just by asking how many things are being mailed -- the price is conditioned on what kind of things are shipped!

<!-- Many phone plans include a certain price-per-gigabyte for data, but only up to a maximum cutoff amout. After that, the price-per-gigabyte gets a lot higher. That means we can't calculate the cost simply by knowing how many gigabytes there are -- the cost is conditioned on what the cutoff is!
-->

---
# Intro to Piecewise Functions

Share one of the examples you and your partner came up with.

<!--
_You may also want to discuss whether square root and absolute values are piecewise functions._
-->

---
# Conditionals in Programming 

So far, all of the functions we've written had a _single rule_. The rule for `gt` was to take a number and make a solid, green triangle of that size. The rule for `bc` was to take a number and make a solid, blue circle of that size.

What if we want to write functions that apply different rules, based on certain conditions?

---
# Conditionals in Programming 

- Open the @starter-file{red-shape}.
- Complete @printable-exercise{pages/red-shape-explore.adoc} in your student workbooks.

_Your teacher may also have you work with the @opt-starter-file{mood-generator} using @printable-exercise{pages/MoodGenerator-explore.adoc}_

---
# Conditionals in Programming 

What happened when you gave `red-shape` a shape that wasn't defined in the program?

<!--
_The program told us that the shape was unknown. Think about other functions that don't work when we give them an invalid input, like dividing by zero!_
-->

---
# Conditionals in Programming 

What is the syntax for writing piecewise functions?

<!--
@ifproglang{pyret}{_Pyret allows us to write if-expressions, which contain:_

. _the keyword `if`, followed by a condition._
. _a colon (`:`), followed by a rule for what the function should do if the condition is_ `true`
. _an `else:`, followed by a rule for what to do if the condition is_ `false`

_We can chain them together to create multiple rules, with the last `else:` being our fallback in case every other condition is `false`._
}

@ifproglang{wescheme}{_WeScheme allows us to write piecewise functions as follows:_

. _the keyword `cond`, followed by a list of conditions_
. _each condition is a boolean expression, followed by a rule for what the function should do if the condition is_ `true`.
. _ending with an `else` statement, being our fallback in case every other condition is_ `false`.
}
-->

---
# Extending the Design Recipe 

Let's see how the Design Recipe could help us to write a piecewise function.

* Turn to @printable-exercise{redshape-dr.adoc}
* How do the Contract and Purpose Statement compare to other Contracts we've seen?
* How do the examples compare to other examples we've seen?
<!--
_The Contract and Purpose Statements don't change: we still write down the name, Domain and Range of our function, and we still write down all the information we need in our Purpose Statement (of course, now we have more important information to write - like our condition(s)!)._

_The examples are also pretty similar: we write the name of the function, followed by some example inputs, and then we write what the function produces with those inputs._
-->

---
# Extending the Design Recipe 

* Circle and label everything that is *change*able on @printable-exercise{redshape-dr.adoc}.
* What changes? What did you label?

If there are more unique labels in the examples than there are things in the Domain, we're probably looking at a piecewise function.

In this case, there are more things to circle-and-label in the examples than there are things in our Domain. Think back to our examples of piecewise functions (ticket sales, postage, cell-phone data plans, etc): knowing the input isn't enough - we also need to know the conditions!

<!--
Up until now, there's been a pattern that students may not have noticed: the number of things in the Domain of a function was _always_ equal to the number of labels in the example step, which was _always_ equal to the number of variables in the definition. Make sure you explicitly draw students' attention to this here, and point out that this pattern *no longer holds* when it comes to piecewise functions. When it doesn't hold, that's how we _know_ we need a piecewise function!
-->

---
# Extending the Design Recipe 

* How many examples are needed to fully test a piecewise function with four "pieces"?

* What changes in a piecewise function?

<!--	
1. _More than two! In fact, we need an example for every option - every "piece"! (And in some cases there is a "default" `else` or `otherwise` option, which we should write an example to test, too!)_
2. _The input, and also the **rule the function applies to the input**_
-->

---
# Additional Practice:

* @opt-starter-file{alices-restaurant}
* @opt-printable-exercise{pages/restaurant-intro.adoc}
* @opt-printable-exercise{pages/restaurant-explore.adoc}
* @opt-printable-exercise{pages/restaurant-dr.adoc}

<!--
If you have more time for working with Piecewise Functions, you may want to have students create a _visual representation_ of how the computer moves through a conditional function.
-->