---
{layout="Core Title Slide"}
# Functions Make Life Easier

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}

I LOVE Green Triangles!{style="font-size:22pt"}

Write the code to make a solid green triangle of size 50!{style="font-size:22pt"}

@image{images/green-triangles-more.png, a}



---
{layout="Launch"}
# There's Got to Be a Better Way!  
Make as many unique, solid, green triangles as you can in 2 minutes.{style="font-size:22pt"}


@image{images/green-triangles-still-more.png, a}

<!--
Screenshot responses and/or share the class total at this point...
We’ll be making a comparison to this achievement later in the lesson.
-->

---
{layout="Launch"}
# There's Got to Be a Better Way!  

Look at the examples below and consider the following: What is constant? What stays the same? What is variable? What changes?

@show{(code '(triangle  30  "solid" "green"))}

@show{(code '(triangle  12  "solid" "green"))}

@show{(code '(triangle 500  "solid" "green"))}


---
{layout="Investigate"}
# There's Got to Be a Better Way!  

Our programming language allows us to define *values*. This lets us create "shortcuts" to reuse the same code over and over.

For example:

@show{(code '(define PRIZE-STAR (star 65 "solid" "pink")))} 

This shortcut makes the same star every time!

---
{layout="Investigate"}
# There's Got to Be a Better Way!  

To make a shortcut that _changes_, we need to define a _function_.

Suppose we want to define a shortcut called `gt`. When we give it a number, it makes a solid green triangle of whatever size we give it.

Who wants to be `gt`?!

<!--
Ask for a volunteer to act out gt.
-->

--- 
{layout="Investigate"}
# There's Got to Be a Better Way!  

What will _@show{(code '(gt 5))}_ produce?

_@show{(code '(triangle 5 "solid" "green"))}!_

In other words, `gt` expects a Number, and produces an Image.

---
{layout="Investigate"}
# There's Got to Be a Better Way!  

Let's rehearse: 

When I say, "*gt 5!*", 
`gt` replies, "*triangle 5 solid green!*"

When I say, "*gt 20!*",
`gt` replies, "*triangle 20 solid green!*"

When I say, "*gt 200!*",
`gt` replies, "*triangle 200 solid green!*"

When I say, "*gt 99!*",
`gt` replies, "*triangle 99 solid green!*"

<!--
Make it clear to the class that the function's Name is "gt," that they expect a Number, and will produce an Image. Act out some examples before having the class add their own and record them on the board. -->

---
{layout="Synthesize"}
# Identifying and Describing the Pattern

How was `gt` so speedy at building green triangles?

How can we program the computer to be as smart as our volunteer? 

In order to define a function, we need to identify what's changing and what stays the same. Once we've done that, we can define any function we'd like in the _Definitions Area_!

---
{layout="Launch"}
# Identifying and Describing the Pattern

On the next slide, we'll take a look at some examples for `gt`.

As you look at the examples, consider the following: 
- What's changing?
- How do we define our function? 
- What would be a logical variable?

---
{layout="Launch"}
# Identifying and Describing the Pattern

@show{(code '(gt 5))} &rarr; @show{(code '(triangle 5 "solid" "green"))}

@show{(code '(gt 10))} &rarr; @show{(code '(triangle 10 "solid" "green"))}

@show{(code '(gt 25))} &rarr; @show{(code '(triangle 25 "solid" "green"))}

@show{(code '(gt 100))} &rarr; @show{(code '(triangle 100 "solid" "green"))}

@show{(code '(gt 220))} &rarr; @show{(code '(triangle 220 "solid" "green"))}

<!--
Highlight or circle the numbers in the gt column and in the triangle column to help students see that they’re the only thing changing! Draw arrows to the two highlighted columns and label them with the word size.
  -->

---
{layout="Launch"}
# Identifying and Describing the Pattern

If we keep everything that stayed the same and substitute `size` for the numbers that changed, it looks like this:

@show{(code '(gt size))} &rarr; @show{(code '(triangle size "solid" "green"))}

The way we write this in the editor is

@show{(code '(define (gt size)(triangle size "solid" "green")))}

---
{layout="Launch"}
# Identifying and Describing the Pattern

Turn to @printable-exercise{gt-domain-debate.adoc}.

Who is correct - Kermit or Oscar?

Why might someone think the domain for `gt` contains a Number and two Strings? 

---
{layout="Launch-DN"}
# Identifying and Describing the Pattern

- Open the @starter-file{gt} and click run.
- Evaluate @show{(code '(gt 10))} in the Interactions Area. What do you get back?
- In one minute, how many different green triangles you can make?!
- How did making green triangles with `gt` compare to making them with your previous strategy?

---
{layout="Investigate-DN"}
# Identifying and Describing the Pattern

Other people have other favorite shapes. We need to be able to meet their needs, too! 

What if we wanted to define a function `rs` to make solid red squares of whatever size we provide?

Complete @printable-exercise{rs.adoc} Add your new function definitions to your @starter-file{gt} and test them out before moving on to @printable-exercise{sun.adoc} and @printable-exercise{define-your-own.adoc}

<!--
As students work, walk around the room and make sure that they are circling what changes in the examples and labeling it with a variable name that reflects what it represents.
 -->

---
{layout="Synthesize"}
# Identifying and Describing the Pattern

- Why is defining functions useful to us as programmers?
- In math class we mostly see functions that consume numbers and produce numbers. What other data types did you see being consumed by these functions?
