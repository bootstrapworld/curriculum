---
{layout="Math Title Slide"}
# Collision Detection - Distance and Inequality{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Problem Decomposition Returns! 

You may remember that there are two strategies for decomposing problems:

- __Top-Down__: Describe the problem at a high level, then fill in the details later.

- __Bottom-Up__: Focus on the smaller parts that you're sure of, then build them together to get the big picture.

---
{layout="Investigate-R"}
# Problem Decomposition Returns! 

**Decide which strategy you want to use for this word problem.**

A retractable flag pole starts out 24 inches tall, and can grow at a rate of 0.6in/sec. An elastic is tied to the top of the pole and anchored 200 inches from the base, forming a right triangle. Define functions that compute the height of the pole and the area of the triangle after a given number of seconds.

* This is easier to think about as two functions:
** one that computes the height of the pole, based on the seconds
** another that computes the area of the triangle, based on the height
* Does one function depend on (or "sit on top of") the other? If so, which one?
* Which strategy will YOU use: bottom-up (independent first) or top-down (dependent first)?

**Then complete @printable-exercise{pages/top-down-bottom-up.adoc}, using your chosen strategy.**

@image{images/retracting-flag.jpg}

<!--
* Does one function depend on (or "sit on top of") the other? If so, which one?
** _Yes - `area` depends on `height`._
* Which strategy will YOU use: bottom-up (independent first) or top-down (dependent first)?
** _Students answers will vary! They can define either function first._
-->

---
{layout="Synthesize"}
# Problem Decomposition Returns! 

- Which strategy did you use?
- Did anyone start out with one, and then switch to another?
- Which was easier for you?

---
{layout="Launch-DN"}
# Collision Detection 

Knowing how far apart our characters are is a good first step... but we still need the computer to be asking: "True or False: is there a collision?"

Turn to @printable-exercise{pages/collision.adoc} and write a function that takes in two coordinate pairs (four numbers) of the `PLAYER` and a character (`(px, py)` and `(cx, cy)`), and uses the returns `true` if they are within 50 @vocab{pixels} of each other. Remember: you've already written a function called `distance`!

Fix the @show{(code 'collide?)} function in your game file, and click Run!

---
{layout="Synthesize"}
# Collision Detection 

We wrote the `distance` function first, and then @show{(code 'collide?)}. Is this *Top-Down* or *Bottom-Up* decomposition?

<!--
- Explicitly point out that this function is easy to write because we can _re-use_ the distance function.
- Connect this back to `profit`, `revenue`, `cost` and `onscreen` from @lesson-link{problem-decomposition}. Problem Decomposition is powerful!
-->

---
{layout="Supplemental"}
# Additional Exercises

If you've already worked with flags, @opt-starter-file{flags-trinidad}
makes use of Pythagorean Theorem and could make for an interesting connection to this lesson.
