---

{layout="Math Title Slide"}

# Functions Make Life Easier

---
{layout="Launch"}
# There's Got to Be a Better Way!  
Make as many unique, solid, green triangles as you can in 2 minutes.

@image{images/i-love-green-triangles.jpg, a}

@image{images/green-triangle.jpg, a}

---
{layout="Launch"}
# There's Got to Be a Better Way!  

@show{(code '(triangle  30  "solid" "green"))}

@show{(code '(triangle  12  "solid" "green"))}

@show{(code '(triangle 500  "solid" "green"))}

What is constant? What stays the same?

What is variable? What changes?

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

When I say, "*gt 99!*".
`gt` replies, "*triangle 99 solid green!*"

<!--
Make it clear to the class that the function's Name is "gt," that they expect a Number, and will produce an Image. Act out some examples before having the class add their own and record them on the board. -->

---
{layout="Investigate"}
# There's Got to Be a Better Way!  


We gave our volunteer instructions that let them take in `gt 20` and give us back
@show{(code '(triangle 20 "solid" "green"))}.

We can define any function we'd like in the *Definitions Area*! We just need to program the computer to be as smart as our volunteer.

---
{layout="Synthesize"}
# Identifying and Describing the Pattern

How was `gt` so speedy at building green triangles?

How can we program the computer to be as smart as our volunteer? In order to define a function, we need to identify what's changing and what stays the same. 

---

# Identifying and Describing the Pattern

Let's take a look at some examples for `gt`.

@show{(code '(gt 5))} &rarr; @show{(code '(triangle 5 "solid" "green"))}
@show{(code '(gt 10))} &rarr; @show{(code '(triangle 10 "solid" "green"))}
@show{(code '(gt 25))} &rarr; @show{(code '(triangle 25 "solid" "green"))}
@show{(code '(gt 100))} &rarr; @show{(code '(triangle 100 "solid" "green"))}
@show{(code '(gt 220))} &rarr; @show{(code '(triangle 220 "solid" "green"))}

- What's Changing?
- How do we define our function? 
- What would be a logical variable?

---

# Identifying and Describing the Pattern

If we keep everything that stayed the same and substitute `size` for the numbers that changed, it looks like this:

@center{@show{(code '(gt size))} &rarr; @show{(code '(triangle size "solid" "green"))}}

The way we write this in the editor is

@center{@show{(code '(define (gt size)(triangle size "solid" "green")))}}

---

# Identifying and Describing the Pattern

Turn to @printable-exercise{gt-domain-debate.adoc} and "decide and defend" whether Kermit's assertion that __The domain of ``gt`` is ``Number, String, String``__ or Oscar's assertion that __The domain of ``gt`` is ``Number``__ is correct.

Why might someone think the domain for `gt` contains a Number and two Strings? 

---

# Identifying and Describing the Pattern

- Have students open the @starter-file{gt} and click run.
- Evaluate @show{(code '(gt 10))} in the Interactions Area.
- What did you get back?
- Take one minute and see how many different green triangles you can make using the `gt` function.
- How many were you able to make?
- How did making green triangles with `gt` compare to making them with your previous strategy?

---

# Identifying and Describing the Pattern

We've successfully defined a function to satisfy my love of green triangles, but other people have other favorite shapes and we need to be able to meet their needs, too. 

What if we wanted to define a function `rs` to make solid red squares of whatever size we give them?

Complete @printable-exercise{rs.adoc}, add your new function definitions to your @starter-file{gt} and test them out, before moving on to @printable-exercise{sun.adoc} and @printable-exercise{define-your-own.adoc}

<!--
As students work, walk around the room and make sure that they are circling what changes in the examples and labeling it with a variable name that reflects what it represents.
 -->

---

# Identifying and Describing the Pattern

- Why is defining functions useful to us as programmers?
- In math class we mostly see functions that consume numbers and produce numbers, but functions can consume values besides Numbers! What other data types did you see being consumed by these functions?
