@slidebreak
{layout="Math Title Slide"}
# Making Flags

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Putting Images Together 

As you've already seen, `overlay` sticks two images together, so that the _center_ of the first image is placed exactly on top of the _center_ of the second image. But what if we want to put the dot somewhere besides the center?

@slidebreak
{layout="Launch"}
# Putting Images Together

Think of the background image as a sheet of graph paper with the origin (0,0) in the bottom left corner.

The `put-image` function works like `overlay`, but the numbers in `put-image` specify a point on that graph paper, with the center of the top image being placed there.

@slidebreak
{layout="Launch"}
# Putting Images Together

The width of the rectangle is 300 and the height is 200. What coordinates for the `dot` would create each of the following images? Fill in your answers on @printable-exercise{japan-estimating-coordinates.adoc}.{style="font-size:17pt"}

@image{images/moving-red-dot.png}{width="550"}

@slidebreak
{layout="Investigate-DN"}
# Putting Images Together

Open the @starter-file{flags} in a new tab, save a copy, and click “Run”.

The programmer who wrote this code included a series of messages - called *comments* - that will never be read by the computer. {style="font-size:16pt"}

Professional programmers use comments __all the time__. They are a way for programmers to leave notes for one another so that teammates can follow each other’s thinking in order to collaborate efficiently, and even for a single programmer to keep track of their thinking when they come back to their code another day.
{style="font-size:16pt"}

@ifproglang{wescheme}{In WeScheme, we use a semicolon (`;`) to tell the computer to ignore what we're typing. {style="font-size:16pt"}}
@ifproglang{pyret}{In Pyret, we use the number sign (`#`) to tell the computer to ignore what we're typing. {style="font-size:16pt"}}


@slidebreak
{layout="Investigate-DN"}
# Putting Images Together

1. Type `japan-flag` into the Interactions Area. What do you get back?
1. Type `japan` into the Interactions Area and compare the image to `japan-flag`.
1. Take a look at the `japan` code and fix it so that it matches the `japan-flag` image.
1. What is the @vocab{Contract} for `put-image`? 

@slidebreak
{layout="Investigate-DN"}
# Putting Images Together

1. Open the @starter-file{flags-2} and click Run.
1. Look at the code for the flag of the Netherlands. How big is the flag?
1. What was the programmer thinking when she coded the height of the red stripe as @show{(code '(/ 200 3))}?
1. The center of the blue stripe is placed at (@show{(code `150)}, @show{(code '(/ 200 6))}). How did the programmer know to use 150 as the x-coordinate? What was the programmer thinking when she coded the y-coordinate as @show{(code '(/ 200 6))}?
1. Explain the thinking behind coding the red stripe's y-coordinate as @show{(code '(* 5 (/ 200 6)))}.

<!--
200/3 evaluates to a Number that is exactly 1/3 the height of a flag that is 200 pixels tall. To locate these stripes vertically using their center points, we'll have to visualize the center lines of the rectangles... which effectively divides the flag into sixths with the centers of the rectangles located at 1/6, 3/6, and 5/6 of the height of the flag.
-->
@slidebreak
{layout="Synthesize"}
# Putting Images Together

Could we completely replace `overlay` with `put-image`? 

Why or why not?

<!--
If you have time, we have lots of additional starter files to push student thinking linked in the additional exercises at the end of this lesson and now would be the time to dive into them!
-->

@slidebreak
{layout="Launch"}
# Making Flags

1) __Decompose the Image.__ We observe that the Japanese flag is made up of two simpler images: a black, outline rectangle and a red dot.{style="font-size:17pt"}


2) __Define those parts.__ We define `dot` and `background`. Once we’ve defined those images, we test them out in the Interactions Area to make sure they look right!{style="font-size:17pt"}


3) __Find the Coordinates.__ For each image, calculate what the x- and y-coordinates of the center should be. This is a lot easier if you have a sheet of graph paper handy!{style="font-size:17pt"}


4) __Build the Image & Check that it Matches the Target Image.__ We stack the parts on top of the bottom image using the coordinates we found.{style="font-size:17pt"}

<!--
__TIP: don't cram all the code into one line! If you break it up into new lines (for example, hitting "Return" before the x-coordinate and after the y-coordinate), you'll notice that the code forms a "staircase" pattern.__ Be sure to compare the image you get with the target image!
-->

@slidebreak
{layout="Launch-DN"}
# Making Flags

Matching activities to support student thinking:

@ifproglang{pyret}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc53aeef328540d3ad2123c, Scaling Flag Ratios}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90f1289c78e0d2a5bccfc, Matching Code to Images using overlay and put-image}
}

@ifproglang{wescheme}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fece28cc64e8d0cca2a2169?collections=5fbecc2b40d7aa0d844956f0, Scaling Flag Ratios}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5ff46882e3b4660c751f707e?collections=5fbecc2b40d7aa0d844956f0, Matching Code to Images using overlay and put-image}
}

@slidebreak
{layout="Investigate-DN"}
# Making Flags


- Turn to @printable-exercise{decomposing-flags.adoc}, and choose ONE flag to focus on. On the blank lines below, describe the parts that make up that flag.
- Once you're done, return to the @starter-file{flags} and define those parts.
- Then, compose those parts using `put-image`, and make your flag!

Optional Challenge: Have students define the `WIDTH` and `HEIGHT` of their flags as values, and then __replace the numbers in each flag__ with expressions relative to width and height. For example, if the `dot` in the Japanese flag is at (150, 100), those numbers would be replaced with @show{(code '(/ WIDTH 2))} and @show{(code '(/ HEIGHT 2))}.


<!-- 
Paper Flag Models to Code: In this exercise, students will be decomposing the image of a flag. For a more tactile experience, you could have students construct images of the flags they choose using construction paper. This should happen between the step where they describe the shapes needed to compose the flags image and write the code to build the image.  The act of physically building the flag from layers of paper makes the layering of the coded images visible and helps students to remember that white space is not just "blank".
-->

@slidebreak
{layout="Synthesize"}
# Making Flags

Which flags were the easiest to make? The hardest?

Why is it useful to define each part of the flag first, before stitching the images together?

@slidebreak
{layout="Supplemental"}
# Additional Exercises

- @opt-starter-file{flags-pr} - This starter file generates a jumbled pile of shapes. Students work to fix the code by resizing, rotating, and correctly locating the components on the background in order to compose an image that looks like the original flag.{style="font-size:15pt"}

- @opt-starter-file{flags-ak} - For a quick dive into why it’s more efficient to define shapes before building the image.{style="font-size:15pt"}

- @opt-starter-file{flags-lebanon} - For practice scaling imported graphics.{style="font-size:15pt"}

- @opt-starter-file{flags-mx} - Similar to the Puerto Rico Flag Starter File, but this one involves an imported image.{style="font-size:15pt"}

- @opt-starter-file{flags-trinidad} - If you’ve already studied Pythagorean Theorem and are ready to apply it.{style="font-size:15pt"}

- @opt-starter-file{flags-turkey} - For a fun function-composition puzzle.{style="font-size:15pt"}

- Explore more flags at @opt-online-exercise{http://www.flagwizard.net/, Flag Wizard}.{style="font-size:15pt"}
