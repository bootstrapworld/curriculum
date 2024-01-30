@slidebreak
{layout="Math Title Slide"}
# Piecewise Functions and Conditionals{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Intro to Piecewise Functions

How would you explain a _function_ to someone else? What are some rules that all functions follow?

<!--
A function has exactly one output for each input.
-->

@slidebreak
{layout="Launch"}
# Intro to Piecewise Functions

We are going to act out a special kind of function.

* If your birthday is in the summer, make an O with your arms
* If your birthday is in the fall, make an X with your arms or body.
* If your birthday is in the winter, put your hand on your head.
* If your birthday is in the spring, flap your arms like a chicken.

_What is the input of the function we just acted out? The output? How do we know that you just acted out a function?_

<!-- 
Debrief how students decided what to do. You might do this while students are still in motion or it might work better with your class to stop the activity before discussing it.

_Example Questions: Ask a student with their hands on their head why they aren't flapping their arms like a chicken.
Ask a student making an O with their arms how they knew what to do._

_Since each student ("input") has only one action ("output"), it is still a function_.
-->

@slidebreak
{layout="Launch"}
# Intro to Piecewise Functions

Up until now, all of the functions we have seen can be described by a **single rule**. 

In this activity your behavior followed a _**set of rules**_ for which each input still had exactly one output. 

This is called a **piecewise function** in math, and a **conditional** in programming. The world is full of piecewise functions and conditionals!

@slidebreak
{layout="Launch"}
# Intro to Piecewise Functions

Let's try acting out another set of rules.

* Everyone wearing sneakers put your hands on your head.
* Everyone wearing a t-shirt make a T with your arms.
* Everyone wearing pants put your hands on your hips.
* Everyone wearing a t-shirt make an O with your arms.

_Why does this set of directions **not** represent a function?_

<!--
_Some students should have nothing to do. Others should look confused as to what to do. They may be wearing sneakers and pants and not be able to put their hands on their head and on their hips at the same time. They may be wearing a tshirt and not be able to make a T and an O with their arms simultaneously._

_A function has exactly one output for each input._
This set of directions doesn't represent a function: people wearing a tshirt were told to do two conflicting things! And people wearing sneakers and pants were told to do two conflicting things!_

-->

@slidebreak
{layout="Investigate"}
# Intro to Piecewise Functions

Work with your partner to think of real-world examples of piecewise functions.

Then, we'll share out what we came up with.

<!--
_Here are a few examples to get you started:_{style="font-size:16pt"}

Places like movie theaters and museums often have different ticket prices for students, children, and senior citizens. That means the total price can't be determined simply by asking how many tickets there are -- the price-per-person is conditioned on what kind of ticket is being purchased!{style="font-size:16pt"}

The US Postal Service charges a different rate for differently-sized letters and packages. That means the total price can't be determined just by asking how many things are being mailed -- the price is conditioned on what kind of things are shipped!{style="font-size:16pt"}

Many phone plans include a certain price-per-gigabyte for data, but only up to a maximum cutoff amout. After that, the price-per-gigabyte gets a lot higher. That means we can't calculate the cost simply by knowing how many gigabytes there are -- the cost is conditioned on what the cutoff is!

You may also want to discuss whether square root and absolute values are piecewise functions.
-->

@slidebreak
{layout="Launch"}
# Conditionals in Programming 

The rule for `gt` was to take a number and make a solid, green triangle of that size. The rule for `bc` was to take a number and make a solid, blue circle of that size.

__What if we want to write functions that apply different rules, based on certain conditions?__

@slidebreak
{layout="Investigate-DN"}
# Conditionals in Programming 

- Open the @starter-file{red-shape}
- Complete @printable-exercise{pages/red-shape-explore.adoc}

<!--
If you have more time to devote to piecewise functions and conditionals, we have additional starter files and scaffolds in the Additional Practice materials.
-->

@slidebreak
{layout="Synthesize"}
# Conditionals in Programming 

What happened when you gave `red-shape` a shape that wasn't defined in the program?

What is the syntax for writing piecewise functions?

<!--
_The program told us that the shape was unknown. Think about other functions that don't work when we give them an invalid input, like dividing by zero!_

@ifproglang{pyret}{_Pyret allows us to write if-expressions, which contain:_

1. _the keyword `if`, followed by a condition._
2. _a colon (`:`), followed by a rule for what the function should do if the condition is_ `true`
3. _an `else:`, followed by a rule for what to do if the condition is_ `false`

_We can chain them together to create multiple rules, with the last `else:` being our fallback in case every other condition is `false`._
}

@ifproglang{wescheme}{_WeScheme allows us to write piecewise functions as follows:_

1. _the keyword `cond`, followed by a list of conditions_
2. _each condition is a Boolean expression, followed by a rule for what the function should do if the condition is_ `true`.
3. _ending with an `else` statement, being our fallback in case every other condition is_ `false`.
}
-->

@slidebreak
{layout="Launch-DN"}
# Extending the Design Recipe 

Let's see how the Design Recipe could help us to write a piecewise function.

* Turn to @printable-exercise{red-shape-dr.adoc}
* How do the Contract and Purpose Statement compare to other @dist-link{Contracts.shtml, Contracts} we've seen?
* How do the examples compare to other examples we've seen?

<!--
_The Contract and Purpose Statements don't change: we still write down the name, Domain and Range of our function, and we still write down all the information we need in our Purpose Statement (of course, now we have more important information to write - like our condition(s)!)._

_The examples are also pretty similar: we write the name of the function, followed by some example inputs, and then we write what the function produces with those inputs._
-->

@slidebreak
{layout="Investigate-DN"}
# Extending the Design Recipe 

* Circle and label everything that is *change*able on @printable-exercise{red-shape-dr.adoc}.
* What changes? What did you label?

If there are more unique labels in the examples than there are things in the Domain, we're probably looking at a piecewise function.

Think back to our examples of piecewise functions (ticket sales, postage, cell-phone data plans, etc): knowing the input isn't enough - we also need to know the conditions!

<!--
Up until now, there's been a pattern that students may not have noticed: the number of things in the Domain of a function was _always_ equal to the number of labels in the example step, which was _always_ equal to the number of variables in the definition. Make sure you explicitly draw students' attention to this here, and point out that this pattern *no longer holds* when it comes to piecewise functions. When it doesn't hold, that's how we _know_ we need a piecewise function!

{style="font-size:16pt"}
-->

@slidebreak
{layout="Investigate"}
# Extending the Design Recipe 

In this example, we have four _totally different_ patterns:

- sometimes we produce `(circle 20 "solid" "red")`
- sometimes we produce `(triangle 20 "solid" "red")`
- sometimes we produce `(rectangle 20 20 "solid" "red")`
- sometimes we produce `(star 20 "solid" "red")`
- sometimes we produce `(text "Unknown shape name!" 20 "red")`

@slidebreak
{layout="Investigate"}
# Extending the Design Recipe 

To define a piecewise function, each condition has both a result ("what should we do") and a question ("when should we do it?").

* When do we make circles? When `shape == "circle"`
* When do we make triangles? When `shape == "triangle"`
* When do we make rectangles? When `shape == "rectangle"`
* When do we make stars? When `shape == "star"`
* When do we draw the "Unknown shape name" text? When `shape` is....anything `else`

@slidebreak
{layout="Investigate"}
# Extending the Design Recipe 

Adding the questions to our pattern gives us:

- When `shape == "circle"`...we produce `(circle 20 "solid" "red")`{style="font-size:16pt"}
- When `shape == "triangle"`...we produce `(triangle 20 "solid" "red")`{style="font-size:16pt"}
- When `shape == "rectangle"`...we produce `(rectangle 20 20 "solid" "red")`{style="font-size:16pt"}
- When `shape == "star"`...we produce `(star 20 "solid" "red")`{style="font-size:16pt"}
- When `shape` is anything `else`...we produce `(text "Unknown shape name!" 20 "red")`{style="font-size:16pt"}

@slidebreak
{layout="Investigate"}
# Extending the Design Recipe 

This practically gives away the body of our function definition!{style="font-size:17pt"}

@show{
(code '(define (red-shape shape)
  (cond
    [(string=? shape "circle")     (circle 20 "solid" "red")]
    [(string=? shape "triangle")   (triangle 20 "solid" "red")]
    [(string=? shape "rectangle")  (rectangle 20 20 "solid" "red")]
    [(string=? shape "star")       (star 20 "solid" "red")]
	[else (text "Unknown shape name!" 20 "red")])))
}{style="font-size:17pt"}


@slidebreak
{layout="Synthesize"}
# Extending the Design Recipe 

* How many examples are needed to fully test a piecewise function with four "pieces"?

* What changes in a piecewise function?

<!--	
1. _More than two! In fact, we need an example for every option - every "piece"! (And in some cases there is a "default" `else` or `otherwise` option, which we should write an example to test, too!)_
2. _The input, and also the **rule the function applies to the input**_
-->

@slidebreak
{layout="Supplemental"}
# Additional Practice

Mood Generator:{style="font-size:14pt"}
 
_Note: this file uses emojis. Although they look like images, they are actually characters in a string._{style="font-size:12pt"}
* @opt-starter-file{mood-generator}{style="font-size:12pt"}
* @printable-exercise{pages/mood-generator-explore.adoc}{style="font-size:12pt"}
* @opt-printable-exercise{mood-generator-dr.adoc}{style="font-size:12pt"} 

Alice's Restaurant:{style="font-size:14pt"}
* @opt-starter-file{alices-restaurant}{style="font-size:12pt"}
* @opt-printable-exercise{pages/restaurant-intro.adoc}{style="font-size:12pt"}
* @opt-printable-exercise{pages/restaurant-explore.adoc}{style="font-size:12pt"}
* @opt-printable-exercise{pages/restaurant-dr.adoc}{style="font-size:12pt"}

Onto Functions:{style="font-size:14pt"}
* Not all piecewise functions are one-to-one! If you're ready to think about _Onto Functions_, try @opt-printable-exercise{decide-defend-onto.adoc}.{style="font-size:12pt"}

<!--
If you have more time for working with Piecewise Functions, you may want to have students create a _visual representation_ of how the computer moves through a conditional function.
-->
