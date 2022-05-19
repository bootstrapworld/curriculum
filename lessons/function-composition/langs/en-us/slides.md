---

# Function Composition

---
{layout="Launch"}
# Composing Functions 

For this activity we will be working in groups of 3-4 students.

- Each group has a set of @link{pages/function-cards.html, "Function Cards"}, each of which takes an input and produces an output. 

---
{layout="Launch"}
# Composing Functions

- If we start with `4` and give it to the function `add6`, what will the output be? 

- If we start with 4 compose `add6` and `double`, the `10` gets passed into the second function, and doubled to produce `20`. 

- What would happen if I composed `add6` with `double` _and_ with `half`? 
 
---
{layout="Launch"}
# Composing Functions

I will be providing "starting" and "ending" numbers using this @link{https://www.google.com/search?q=random+number, random integer generator}.

For each of the starting numbers on the board, your job is to figure out which functions to compose in order to get to the end.

You will need to use some functions more than once, and that's ok!

If you're ready for a challenge, try to find the _shortest path_ from start to end, using the smallest number of compositions.

---
{layout="Launch"}
# Diagramming Function Composition

Three of the function cards we just used were for the functions `f`, `g` and `h`:

* `f` multiplied its input by 3

* `g` added six to its input

* `h` subtracted one from its input

We can compose those function in any order. If we composed them as `f(g(h(x)))` and evaluated them for `x = 4` what would happen?

---
{layout="LaunchC"}
# Diagramming Function Composition

We can diagram the function composition using Circles of Evaluation (see first column, below). In the second column, we've replaced the function names in each Circle of Evaluation with _what each function does_:

@image{images/fghx.png, a}

---
{layout="LaunchC"}

# Diagramming Function Composition
The circles show us that in order to evaluate @math{f(g(h(4))))}

- First we would have to evaluate @math{h(4)}, subtracting `1` from `4` to get `3`
- Then we would evaluate @math{g(3)}, adding `6` to `3` to get `9`
- Then we would evaluate @math{f(27)}, tripling `9` to get `27`

@image{images/fghx.png, a}

---
{layout="Investigate"}
# Diagramming Function Composition

Turn to @printable-exercise{pages/diagramming-function-composition.adoc} to practice writing, translating and evaluating Circles of Evaluation of composed functions.

---
{layout="Synthesize"}
# Diagramming Function Composition

Do @math{f(g(h(x)))} and @math{g(h(f(x)))} evaluate to the same thing? 

<!--
Why not? _order matters!_
-->

---
{layout="Launch"}
# Composing Functions in Code 

Log into @link{https://code.pyret.org, code.pyret.org (CPO)}.
Open a new program and save it as Function Composition.

---
{layout="Investigate"}
# Composing Functions in Code 

Open to @printable-exercise{pages/function-composition-green-star.adoc}.

- Make sure you are using the @vocab{Definitions area} (left side) for code you want to keep and are using the @vocab{Interactions area} (right side) to test code or try out new ideas.
- When you are finished, check your work, and then change the color of all of the stars to “gold” or another color of your choosing.

Then open to @printable-exercise{pages/function-composition-your-name.adoc}

<!--
While students are exploring, be available for support but encourage student discussion to solve problems. Many student questions can be addressed with these responses:

Did you try drawing the Circle of Evaluation first? 
Did you check the contract? 
Have you pressed the Run button to save your Definitions changes?

Encourage students to practice writing comments in the code to describe what is being produced, using @ifproglang{wescheme}{`;`} @ifproglang{pyret}{`#`} at the beginning of the line.
-->

---
{layout="Investigate"}
# Composing Functions in Code

If you have time, work with @printable-exercise{pages/function-composition-scale-xy.adoc} and/or
@ifproglang{pyret}{@opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc946c8d135d036ef1edd01, Function Composition Matching Activity}
}
@ifproglang{wescheme}{@opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fece8bb695f3d0d363c331b?collections=5fbecc2b40d7aa0d844956f0, Function Composition Matching Activity}
}

---
{layout="Synthesize"}
# Composing Functions in Code

- What do all of these functions have in common?
- Does using one of these functions change the original image?
- What does the number in @show{(code 'scale)} represent?
- What does the number in @show{(code 'rotate)} represent?
- The Domain and Range for @show{(code 'flip-horizontal)} is Image -> Image.  Why can I use the output of the @show{(code 'text)} function as an _input_ for @show{(code 'flip-horizontal)}?

<!-- 
Fun with Images!
Now that students have learned how to use all of these image-composing functions, you may want to give them a chance to create a design of their own, tasking them with using at least 4 functions to create an image of their choosing.

Our @link{../flags/index.shtml, Flags lesson} also dives deeper into image composition.
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
{layout="Investigate"}
# Composing Multiple Ways 

Complete @printable-exercise{pages/more-than-one-way.adoc}.

---
{layout="Synthesize"}
# Composing Multiple Ways 

There is a special function in Pyret that lets us test whether or not two images are equal.

`images-equal :: Image, Image -> Boolean`

Use it to test whether all of the expressions you wrote successfully build the same images.

---
{layout="Synthesize"}
# Composing Multiple Ways 

- Could we have written more expressions to create the same images?
- Are all of the ways to write the code equally efficient?
