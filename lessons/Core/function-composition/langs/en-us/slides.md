---
{layout="Math Title Slide"}
# Function Composition

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Composing Functions 

For this activity we will be working in groups of 3-4 students.

Each group has a set of @printable-exercise{pages/function-cards.adoc, "Function Cards"}, each of which takes an input and produces an output. 

_If you don't have printed versions, you can use our Desmos version of the @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/62b8a5cb4b545ec2e57ac76d, Function Cards} instead._

---
{layout="Launch"}
# Composing Functions

Each __function card__ has a Contract (Name, Domain, Range), and a description of what it does. 

Starting with 4, 
- you could play the `add 1` card to turn it into 5.
- you could play `add 6` and turn it into 10.

What other cards could you play to get from 4 to 10? 
 
---
{layout="Launch"}
# Composing Functions

Select the cards you would play with to get from the starting number to the ending number. 
- Start at 4, end at 26
- Start at -22, end at 13
- Start at 64, end at 0

Let's try some more numbers from this @link{https://www.google.com/search?q=random+number, random integer generator}.

You will need to use some functions more than once, and that's ok! If you're ready for a challenge, try to find the _shortest path_ from start to end, using the smallest number of compositions.

---
{layout="Launch"}
# Diagramming Function Composition

Three of the function cards we just used were for the functions `f`, `g` and `h`:

* `f` multiplies its input by 3

* `g` adds six to its input

* `h` subtracts one from its input

We can compose those functions in any order. 

What if we composed them as `f(g(h(x)))` and evaluated them for `x = 4` ...

<!--
Answer on next slide!
-->

---
{layout="LaunchC"}
# Diagramming Function Composition

The circles of evaluation for @math{f(g(h(x)))} are shown below:

* Can you explain the diagram? 

* What would the expression @math{f(g(h(4)))} evaluate to?

@image{images/fghx.png}

<!--
4 - 1 = 3
3 + 6 = 9
9 * 3 = 27	
-->

---
{layout="Investigate"}
# Diagramming Function Composition

Complete @printable-exercise{pages/diagramming-function-composition.adoc} with your partner.

---
{layout="Synthesize"}
# Diagramming Function Composition

Do @math{f(g(h(x)))} and @math{g(h(f(x)))} evaluate to the same thing? {style="font-size:26pt"}

<!--
Why not? _order matters!_
-->

---
{layout="Launch-DN"}
# Composing Functions in Code 

- Log into @starter-file{editor}, and open a new program.
- Save the file as "Function Composition", and click "Run".
- Complete the following @printable-exercise{pages/function-composition-green-star.adoc}. When you're done, change the color of all the stars in the file to gold. 
- Then try @printable-exercise{pages/function-composition-your-name.adoc}.
- If you have time, work with @printable-exercise{pages/function-composition-scale-xy.adoc} and/or
@ifproglang{pyret}{@opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc946c8d135d036ef1edd01, Function Composition Matching Activity}
}
@ifproglang{wescheme}{@opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fece8bb695f3d0d363c331b?collections=5fbecc2b40d7aa0d844956f0, Function Composition Matching Activity}
}

<!--
While students are exploring, be available for support but encourage student discussion to solve problems. Many student questions can be addressed with these responses:

Did you try drawing the Circle of Evaluation first? 
Did you check the @dist-link{Contracts.shtml, contract}? 
Have you pressed the Run button to save your Definitions changes?

Encourage students to practice writing comments in the code to describe what is being produced, using @ifproglang{wescheme}{`;`} @ifproglang{pyret}{`#`} at the beginning of the line.
-->


---
{layout="Synthesize"}
# Composing Functions in Code

- What do all of these functions have in common?
- Does using one of these functions change the original image?
- What does the number in @show{(code 'scale)} represent?
- What does the number in @show{(code 'rotate)} represent?
- The Domain and Range for @show{(code 'flip-horizontal)} is `Image -> Image`.  Why can we use the output of the @show{(code 'text)} function as an _input_ for @show{(code 'flip-horizontal)}?

<!-- 
Fun with Images!
Now that students have learned how to use all of these image-composing functions, you may want to give them a chance to create a design of their own, tasking them with using at least 4 functions to create an image of their choosing.

Our @lesson-link{flags/} also dives deeper into image composition.
-->

---
{layout="Launch"}
# Composing Multiple Ways 

As is often true with solving math problems, there is more than one way to get the same composed image.

Suppose I wrote the code: 

@show{(code '(scale 3 (circle 50 "solid" "red")))}

What’s another line of code I could write that would produce the exact same image?
    
<!-- 
@show{(code '(circle 150 "solid" "red"))}
-->

---
{layout="Investigate-DN"}
# Composing Multiple Ways 

Complete @printable-exercise{pages/more-than-one-way.adoc}.

There is a special function that lets us test whether or not two images are equal.

@show{(code 'image=?)}` :: Image, Image -> Boolean`

Use it to test whether all of the expressions you wrote successfully build the same images.

---
{layout="Synthesize"}
# Composing Multiple Ways 

- Could we have written more expressions to create the same images?
- Are all of the ways to write the code equally efficient?
