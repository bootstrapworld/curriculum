---
{layout="Math Title Slide"}
# Collision Detection - Distance and Inequality{style="font-size:30pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Problem Decomposition Returns! 

Knowing how far apart our characters are is the first step. But in order to keep track of the score, we need to know when they are close enough to collide!

"Problem Decomposition" is a powerful tool, which lets us break apart complex problems into simpler ones that we can solve, test, and then glue together into a complex solution.

---
{layout="Launch"}
# Problem Decomposition Returns! 

You may remember that there are two strategies for decomposing problems:

- __Top-Down__: Describe the problem at a high level, then fill in the details later.

- __Bottom-Up__: Focus on the smaller parts that you're sure of, then build them together to get the big picture.

Before we focus on our game code, let's practice breaking apart a different complex word problem.


---
{layout="Investigate-R"}
# Problem Decomposition Returns! 

A retractable flag pole starts out 24 inches tall, and can grow at a rate of 0.6in/sec.{style="font-size:13pt"} 

An elastic is tied to the top of the pole and anchored 200 inches from the base, forming a right triangle.{style="font-size:13pt"} 

__*Write a function that computes the area of the triangle as a function of time.*__{style="font-size:13pt"}


This problem is easier to think about as two functions:{style="font-size:12pt"}
* one that computes the height of the pole, based on the seconds{style="font-size:12pt"}
* another that computes the area of the triangle, based on the height{style="font-size:12pt"}

Does one function depend on (or "sit on top of") the other? If so, which one?{style="font-size:12pt"}

@image{images/retracting-flag.jpg}

<!--
1. Scaffolded discussion of this word problem continues on next slide
1. Does one function depend on (or "sit on top of") the other? If so, which one?
* _Yes - `area` depends on `height`._
-->

---
{layout="Investigate-R"}
# Problem Decomposition Returns! 

A retractable flag pole starts out 24 inches tall, and can grow at a rate of 0.6in/sec.{style="font-size:14pt"} 

An elastic is tied to the top of the pole and anchored 200 inches from the base, forming a right triangle.{style="font-size:14pt"} 

__*Write a function that computes the area of the triangle as a function of time.*__{style="font-size:14pt"}

1. Decide which strategy YOU will use: bottom-up (independent first) or top-down (dependent first){style="font-size:14pt"}
2. Then complete @printable-exercise{pages/top-down-bottom-up.adoc}, using your chosen strategy.{style="font-size:14pt"}

@image{images/retracting-flag.jpg}

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

Fix the @show{(code 'collision?)} function in @starter-file{program-list, your game file}, and click Run!

---
{layout="Synthesize"}
# Collision Detection 

We wrote the `distance` function first, and then @show{(code 'collision?)}. Is this *Top-Down* or *Bottom-Up* decomposition?

<!--
- Explicitly point out that this function is easy to write because we can _re-use_ the distance function.
- Connect this back to `profit`, `revenue`, `cost` and `onscreen` from @lesson-link{problem-decomposition}. Problem Decomposition is powerful!
-->

---
{layout="Supplemental"}
# Additional Exercises

If you've already worked with flags, @opt-starter-file{flags-trinidad}
makes use of Pythagorean Theorem and could make for an interesting connection to this lesson.
