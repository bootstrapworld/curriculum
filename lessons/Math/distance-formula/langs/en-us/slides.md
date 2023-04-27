---
{layout="Math Title Slide"}
# The Distance Formula

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Distance in 1 Dimension

Sign in to @starter-file{program-list} and open your saved Game Starter File.

At this point:

- The Target and Danger should be moving on their own.
- Your Player should respond to keypresses.
- The Target and Danger should reappear after they leave the screen.

It's almost fully-playable!

@image{images/screenshot.jpg}

---
{layout="Launch"}
# Distance in 1 Dimension

* What seems to be missing from this game?
* What does it mean for characters to 'hit' one another? To collide?
* How will the computer know when the characters have collided?

<!--
_Here's a link to a @opt-starter-file{sample-game-no-distance-lines} you can use if you're demoing on the board._


* What seems to be missing from this game? _The characters aren't doing anything when they collide._

* What does it mean for characters to 'hit' one another? To collide? _They have to be close enough to touch._

* How will the computer know when the characters have collided? _When the coordinates of the characters are really close to each other._
-->

---
{layout="Launch"}
# Distance in 1 Dimension
Role-Play: Two Characters Collide!

<!--
- Identify a "number line" on the floor or across a wall of your classroom as the backdrop for your movement.
- Make sure that you and your volunteer stand with feet as close together as possible, representing the infinitely small point that identifies your center.
- Raise your arms to form a "T shape", representing the outer edges of the characters.
- Emphasize that this represents _one dimension_ (perhaps the x-axis).
- With the volunteer, stand about 10 steps away from one another and side-step towards each other one step at a time, while asking the class, "True or False? We are colliding!" __Be sure to only accept "true" and "false" as responses - not "yes" and "no"!__
- Ask the class how far apart you and your volunteer are. How they would calculate this if you were standing on a number line and they could see the actual coordinates under your feet?
- After a few iterations, try switching places and repeating. _Point out that students always subtract the smaller number from the larger one, regardless of the character order!_ *The results are always positive.*
- Do this until students can clearly see that collision happens when the two characters are _touching_ or
_overlapping_ in some way - NOT when they are _at the same point._
-->

@image{images/role-play1.png}{width="750"}


---
{layout="Launch"}
# Distance in 1 Dimension

Role-Play: Two Characters Collide!

<!--
After a few iterations, try switching places and repeating. Point out that students always subtract the smaller number from the larger one, regardless of the character order!

Do this until students can clearly see it’s when the two characters are 'touching' or 'overlapping' in some way - NOT when they are 'at the same point.'
-->

@image{images/role-play2.png}{width="750"}

---
{layout="Investigate-DN"}
# Distance in 1 Dimension


Our game computes 1-dimensional distance (vertical or horizontal) using a function called `line-length`. Let's explore how it works!

- Find the `line-length` function in your game files and take a minute to look at the code.
- What do you notice?
- What do you wonder?
- Click Run, and practice using `line-length` in the @vocab{Interactions Area} with different values for `a` and `b`.

<!--
- What do you notice? _Both of the examples do the same thing, even though the numbers are given in a different order. It's a piecewise function! It uses inequalities._
-->

---
{layout="Synthesize"}
# Distance in 1 Dimension

- In your  own words, what does the `line-length` function do?
- How does it work?
- Why does it use conditionals?

<!-- 
- What does the `line-length` function _do?_ It always subtracts the smaller number from the larger number and evaluates to a positive distance!
- Why does it use conditionals? To determine whether or not to subtract the numbers in the given order or to swap the order to get a positive result.

Make absolutely certain that students understand that this line-length _always returns the positive distance_ between two points on a number line.
-->

---
{layout="Synthesize"}
# Distance in 1 Dimension

`line-length` computes the positive distance between two points on a single number line.

**If two coordinates differ by their x-values**, this function will tell us how far apart they are. 

**If two coordinates differ by their y-values**, this function will tell us how far apart they are. 

But what if the coordinates differ by **both x and y**...?

---
{layout="Launch-DN"}
# Distance in 2 Dimensions

Scroll down to `4. Collisions` in your game file and look for the `distances-color` definition. 

Right now this value is defined to be the __empty string__ `""`. Change this to a color that will show up on your background, and click _Run_.


This setting will draw lines from your Player to each of the other characters, and then uses those lines as the hypotenuse of right triangles!

The legs of these triangles show the distance in 1 dimension each (on the x- and y-axis).

<!--
Here's a link to a @opt-starter-file{sample-game-w-distance} to use if you're demoing on the board.
-->

---
{layout="Launch"}
# Distance in 2 Dimensions

In order to compute the _diagonal_ distance between two characters in a video game, we'll need a special formula that considers _both the vertical and the horizontal_ distances between them! {style="font-size:16pt"}


When we turned on `distances-color` in our game, we saw the diagonal distance between two characters represented as the hypotenuse of a right triangle.{style="font-size:16pt"}

- How do we find the hypotenuse of a right triangle if we know the measures of both of its legs?{style="font-size:16pt"}

- If we had one player at (0,0) and another player at (4,3), we'd see a right triangle and the lengths of the legs would be 3 and 4. How would we use the Pythagorean Theorem to find the hypotenuse of the triangle?{style="font-size:16pt"}

---
{layout="Launch"}
# Distance in 2 Dimensions

Connecting Pythagorean Theorem to video games:

On the next slide you'll watch a  video created by Tovah Brown of a geometric proof of the Pythagorean theorem, and its application to finding distance between game characters.

- Try your best to explain the proof from the video to a partner.
- What questions do you have?

---
{layout="LaunchC"}
# Distance in 2 Dimensions

@[youtube](Ln7myXQx8TM)
<!--
Note: If it's been a long time since your students have used the Pythagorean Theorem, now would be a good time to do some  @opt-printable-exercise{pages/pythag-practice.pdf, Pythagorean Theorem Practice}
	
Optional: On @printable-exercise{distance-write-code-from-lengths.adoc} we've provided screenshots from two games where the horizontal and vertical distances between the characters are shown. Students are asked to write the code to calculate the distance between these characters using the Pythagorean Theoream. You could also have them do the computations (using a calculator) and compare their results to what their code evaluates to.
-->

---
{layout="Investigate-DN"}
# Distance in 2 Dimensions

- Turn to @printable-exercise{distance-on-coordinate-plane.adoc} and look at how line-length is used in the code. See if you can figure out how to write the code for the second problem.
- Then turn to @printable-exercise{distance-coe.adoc}. Convert this expression to a Circle of Evaluation, and then to code.
- Then we'll make sure we really understand it all with @printable-exercise{pages/Distance-bw-Two-Points-Multiple-Representations.pdf, Multiple Representations: Distance between two points} by combining circles of evaluation, code, computation and a sketch on a graph.

---
{layout="Investigate-DN"}
# Distance in 2 Dimensions

For more practice writing code to generate the distance between two fixed points, complete @printable-exercise{pages/distance-from-game-coordinates.adoc}

Optional: for more practice, complete @opt-printable-exercise{pages/distance-from-game-coordinates-2.adoc}

<!--
Debrief these workbook pages - or have students pair-and-share - before moving on to writing the full distance function.
-->

---
{layout="Investigate"}
# Distance in 2 Dimensions

All of the practice we've done so far today focused on a screenshot of a moment in time. With the game stopped in that moment, we knew either the exact location of our characters or the exact distances between them.

But, as we play our games, the characters are constantly changing locations!

In order to calculate the distance between two objects whose locations are constantly changing, we need to use variables!

---
{layout="Investigate-DN"}
# Distance in 2 Dimensions

Turn to @printable-exercise{pages/distance.adoc} and use the Design Recipe to help you write a function that takes in two @vocab{coordinate} pairs (four numbers) of two characters (@math{px, py}) and (@math{cx, cy}) and returns the distance between those two points.

__HINT:__ The code you wrote in @printable-exercise{pages/distance-coe.adoc} can be used to give you your first example!

When you're done, fix the broken `distance` function in your game file, click _Run_ and check that the right triangles in your file now appear with reasonable distances for the hypotenuse.

---
{layout="Investigate-DN"}
# Distance in 2 Dimensions

Optional:

If we knew the lengths of the hypotenuse and one leg of the triangle, could we use the formula @math{A^2 + B^2 = C^2} to compute the length of the other leg?

Take a look at the two examples on @printable-exercise{pages/distance-comparing-code.adoc}. 

- There's a subtle difference between the two examples! What is it? 
- Can you explain why they need to be written differently?

<!-- 
It is _extremely common_ for students to put variables in the *wrong order*. In other words, their program looks like
@ifproglang{wescheme}{ `...(sqrt (+ (sqr (line-length x1 y1)) (sqr (line-length x2 y2))))...`
instead of `...(sqrt (+ (sqr (line-length x2 x1)) (sqr (line-length y2 y1))))...` }
@ifproglang{pyret}{ `...num-sqrt(num-sqr(line-length(x1,y1)) + num-sqr(line-length(x2, y2)))...`
instead of `...num-sqrt(num-sqr(line-length(x2 x1)) + num-sqr(line-length(y2 y1)))...` }

In this situation, remind students to look back at what they circled and labeled in the example steps. _This is why we label!
-->

---
{layout="Supplemental"}
# Additional Exercises

- Use the Design Recipe to solve @opt-printable-exercise{line-length.adoc} on their own.
- Modify `line-length` to make use of the absolute value function: @show{(code 'abs)}.
