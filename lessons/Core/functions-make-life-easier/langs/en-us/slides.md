@slidebreak
{layout="Core Title Slide"}
# Functions Make Life Easier

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# There's Got to Be a Better Way!  

I LOVE Green Triangles!{style="font-size:22pt"}

Open your @starter-file{editor, editor} and...
write the code to make a solid green triangle of size 50!{style="font-size:18pt"}

@image{images/green-triangles-more.png}

@slidebreak
{layout="Launch"}
# There's Got to Be a Better Way!  

Make as many unique, solid, green triangles as you can in the next 2 minutes.{style="font-size:22pt"}

@image{images/green-triangles-still-more.png}

<!--
Screenshot responses and/or share the class total at this point...
We’ll be making a comparison to this achievement later in the lesson.
-->

@slidebreak
{layout="Launch"}
# There's Got to Be a Better Way!  

Look at the examples below and consider the following: What is constant? What stays the same? What is variable? What changes?

@show{(code '(triangle  30  "solid" "green"))}

@show{(code '(triangle  12  "solid" "green"))}

@show{(code '(triangle 500  "solid" "green"))}


@slidebreak
{layout="Investigate"}
# There's Got to Be a Better Way!  

Our programming language allows us to define *values*. This lets us create "shortcuts" to reuse the same code over and over.

For example:

@show{(code '(define gt (triangle 65 "solid" "green")))} 

This shortcut makes the same green triangle _every_ time!

@slidebreak
{layout="Investigate"}
# There's Got to Be a Better Way!  

To make a shortcut that _changes_, such as creating solid, green triangles of different sizes, we need to define a _function_.

Suppose we want to define a function called `gt`. When we give it a number, it makes a solid green triangle of whatever size we give it.

I'm going to need a volunteer to help act out the process.

<!--
Ask for a volunteer to act out gt.
-->

@slidebreak
{layout="Investigate"}
# There's Got to Be a Better Way!  

Our actor is playing the starring role of `gt`.

They expect a number and will produce an image.

Just as with any acting career, this one will begin with a rehearsal.

When I say, "*gt 5!*", you say, "*triangle 5 solid green!*"

Let's try it.

<!--
Continue the rehearsal with the next slide!  

-->

@slidebreak
{layout="Launch"}
# There's Got to Be a Better Way!  

@table{2, header}
|  When I say...    | gt says...
| gt 5 				| triangle 5 solid green
| gt 20			 	|
| gt 200			|
| gt 99				|


Let's Rehearse! 

<!--
Let's Rehearse!
When I say, "*gt 5!*", you say
... wait for the student to say "*triangle 5 solid green!*"

When I say, "*gt 20!*",
... wait for the student to say "*triangle 20 solid green!*"

When I say, "*gt 200!*",
... wait for the student to say "*triangle 200 solid green!*"

When I say, "*gt 99!*",
... wait for the student to say "*triangle 99 solid green!*"

Once they're rehearsed, have the class add their own and record them on the board. 
-->

@slidebreak
{layout="Synthesize"}
# Identifying and Describing the Pattern

How was `gt` so speedy at building green triangles?

How can we program the computer to be as smart as our volunteer? 

In order to define a function, we need to identify what's changing and what stays the same. Once we've done that, we can define any function we'd like in the _Definitions Area_!

@slidebreak
{layout="Launch"}
# Identifying and Describing the Pattern

On the next slide, we'll take a look at some examples for `gt`.

As you look at the examples, consider the following: 
- What's changing?
- How do we define our function? 
- What would be a logical variable?

@slidebreak
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

@slidebreak
{layout="Launch"}
# Identifying and Describing the Pattern

If we keep everything that stayed the same and substitute `size` for the numbers that changed, it looks like this:

@show{(code '(gt size))} &rarr; @show{(code '(triangle size "solid" "green"))}

The way we write this in the editor is

@show{(code '(define (gt size)(triangle size "solid" "green")))}

@slidebreak
{layout="Launch"}
# Identifying and Describing the Pattern

Turn to @printable-exercise{gt-domain-debate.adoc}.

Who is correct - Kermit or Oscar?

Why might someone think the domain for `gt` contains a Number and two Strings? 

@slidebreak
{layout="Launch-DN"}
# Identifying and Describing the Pattern

- Open the @starter-file{gt}, and save a copy of your own
- Click Run
- Evaluate @show{(code '(gt 10))} in the Interactions Area. What do you get back?
- In one minute, how many different green triangles can you make?!
- How did making green triangles with `gt` compare to making them with your previous strategy?

@slidebreak
{layout="Investigate-DN"}
# Identifying and Describing the Pattern

Other people have other favorite shapes. We need to be able to meet their needs, too! What if we wanted to define a function `rs` to make solid red squares of whatever size we provide?

- Complete @printable-exercise{rs.adoc} 
- Add your new function definitions to your @starter-file{gt} and test them out.
- Then do @printable-exercise{sun.adoc} 
- And @printable-exercise{define-your-own.adoc}

<!--
As students work, walk around the room and make sure that they are circling what changes in the examples and labeling it with a variable name that reflects what it represents.
-->

@slidebreak
{layout="Synthesize"}
# Identifying and Describing the Pattern

- Why is defining functions useful to us as programmers?
- In math class we mostly see functions that consume numbers and produce numbers. What other data types did you see being consumed by these functions?
