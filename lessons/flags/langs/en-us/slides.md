---

{layout="Math Title Slide"}

# Making Flags

---
{layout="Launch"}
# Putting Images Together 

As you've already seen, `overlay` sticks two images together, so that the _center_ of the first image is placed exactly on top of the _center_ of the second image. But what if we want to put the dot somewhere besides the center?

The `put-image` function works like `overlay`, but instead of placing the centers of each image on top of one another, it _translates_ the center of the top image by some distance in the x- and y-direction.

---
{layout="Launch"}
# Putting Images Together

Think of the background image as a sheet of graph paper with the origin (0,0) in the bottom left corner.

The numbers in `put-image` specify a point on that graph paper, with the center of the top image being placed there.

---
{layout="Launch"}
# Putting Images Together

- Look at @printable-exercise{japan-estimating-coordinates.adoc}.
- The code beneath each image is missing the x and y coordinates to place the dot.
- Estimate the x- and y-coordinate of the dot's location for each image and complete the code!

---
{layout="Investigate"}
# Putting Images Together

Open the @starter-file{flags} and click Run.

There are some special lines in this file called *comments*. The programmer who wrote this code included a series of messages - called comments - that will never be read by the computer.

Professional programmers use comments __all the time__.

Professional programmers work with teams who need to be able to follow each other's thinking in order to collaborate efficiently. Comments are a way for programmers to leave notes for one another, and even for a single programmer to keep track of their thinking when _they_ come back to their code another day.

---
{layout="Investigate"}
# Putting Images Together

In Pyret, we use the number sign (`#`) to tell the computer to ignore what we're typing. What color does the code turn when it has a number sign in front of it? _Red!_}
- Type `japan-flag` into the Interactions Area. What do you get back?
- Type `japan` into the Interactions Area and compare the image to `japan-flag`.
- `japan` is composed using `dot` and `background`. Type each of those variables into the Interactions Area. What do you get back?
- Take a look at the `japan` code and fix it so that it matches the `japan-flag` image.
- What is the @vocab{Contract} for `put-image`? (Write it in your Contracts page!)

---
{layout="Investigate"}
# Putting Images Together

- Open the @starter-file{flags-2} and click Run.
- Look at the code for the flag of the Netherlands.
- How big is the flag?
- What was the programmer thinking when she coded the height of the red stripe as @show{(code '(/ 200 3))}?
- The center of the blue stripe is placed at (@show{(code `150)}, @show{(code '(/ 200 6))}). How did the programmer know to use 150 as the x-coordinate?
- What was the programmer thinking when she coded the y-coordinate as @show{(code '(/ 200 6))}?
- Explain the thinking behind coding the redstripe's y-coordinate as @show{(code '(* 5 (/ 200 6)))}.

---
{layout="Synthesize"}
# Putting Images Together

Could we completely replace `overlay` with `put-image`? Why or why not?

 <!--
If you have time, we have lots of additional starter files to push student thinking linked in the additional exercises at the end of this lesson and now would be the time to dive into them!
-->

---
{layout="Launch"}
# Making Flags

Let's dig into the process for how the flags we’ve seen so far were made:

*1) Decompose the Image*

We observe that the Japanese flag is made up of two simpler images: a black, outline rectangle and a red dot.


*2) Define those parts*

We define `dot` and `background`. Once we’ve defined those images, we test them out in the Interactions Area to make sure they look right!

---
{layout="Launch"}
# Making Flags

*3) Find the Coordinates*

For each image, calculate what the x- and y-coordinates of the center should be. __TIP: this is a lot easier if you have a sheet of graph paper handy!__


*4) Build the Image & Check that it Matches the Target Image*

We stack the parts on top of the bottom image using the coordinates we found.
__TIP: don't cram all the code into one line! If you break it up into new lines (for example, hitting "Return" before the x-coordinate and after the y-coordinate), you'll notice that the code forms a "staircase" pattern.__ Be sure to compare the image you get with the target image!

---
{layout="Launch"}
# Making Flags

If you have time, these matching activities will support student thinking.

- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc53aeef328540d3ad2123c, Scaling Flag Ratios}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90f1289c78e0d2a5bccfc, Matching Code to Images using overlay and put-image}


---
{layout="Investigate"}
# Making Flags

<!-- 
Paper Flag Models to Code: In this next exercise, students will be decomposing the image of a flag. For a more tactile experience, you could have students construct images of the flags they choose using construction paper. This should happen between the step where they describe the shapes needed to compose the flags image and write the code to build the image.  The act of physically building the flag from layers of paper makes the layering of the coded images visible and helps students to remember that white space is not just "blank".
-->

{layout="Investigate"}
# Making Flags

- Turn to @printable-exercise{decomposing-flags.adoc}, and choose ONE flag to focus on. On the blank lines below, describe the parts that make up that flag.
- Once you're done, return to the @starter-file{flags} and define those parts.
- Then, compose those parts using `put-image`, and make your flag!

---
{layout="Synthesize"}
# Making Flags

Which flags were the easiest to make? The hardest?

Why is it useful to define each part of the flag first, before stitching the images together?

---
{layout="Supplemental"}
# Additional Exercises

- @opt-starter-file{flags-pr} This starter file provide students with an image of a flag and code that starts out generating a jumbled pile of shapes. Students work to fix the code by resizing, rotating, and correctly locating the components on the background in order to compose an image that looks like the original flag.

- @opt-starter-file{flags-ak} - For a quick dive into why it’s more efficient to define shapes before building the image.

- @opt-starter-file{flags-lebanon} - For practice scaling imported graphics.

- @opt-starter-file{flags-mx} - Similar to the Puerto Rico Flag Starter File, but this one involves an imported image.

- @opt-starter-file{flags-trinidad} - If you’ve already studied Pythagorean Theorem and are ready to apply it.

- @opt-starter-file{flags-turkey} - For a fun function-composition puzzle.