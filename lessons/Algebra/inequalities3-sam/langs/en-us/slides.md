---
{layout="Math Title Slide"}
# Sam the Butterfly - Applying Inequalities{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch-DN"}
# Introducing Sam 

- Open the @starter-file{inequalities-sam} in a new tab
- Save a copy of your own
- Complete @printable-exercise{pages/sam-intro.adoc, Introducing Sam}, clicking "Run" and using the arrow keys to investigate the program with your partner.

<!--
* What is something you noticed about this program?
* What do you see when Sam is at (0,0)?  Why is that?
* How far can Sam go to the left and stay on the screen?
* How could we write this as an @vocab{expression}?
-->

---
{layout="Launch"}
# Introducing Sam

- What is something you noticed about this program?
- What do you wonder?
- What do you see when Sam is at (0,0)?  Why is that? 
- How far can Sam go to the left and stay on the screen? 
- How could we write this as an @vocab{expression}? 

<!--
- What is something you noticed about this program? _As Sam moves, the @vocab{coordinates} are displayed at the top of the screen; the coordinates are all in the 1st quadrant; etc._
- What do you see when Sam is at (0,0)?  Why is that? _You only see part of Sam's wing.  Sam's position is based on the center of Sam's image._
- How far can Sam go to the left and stay on the screen? _Up to, but not beyond, an x of -40._
- How could we write this as an @vocab{expression}? _Appropriate responses are @math{x \gt -50}, or (for students who notice that Sam only moves in increments of 10) @math{x \geq -40}._
-->

---
{layout="Launch"}
# Introducing Sam 

Every time Sam moves, we want to check and see if Sam is safe.

There are three functions defined in @starter-file{inequalities-sam}. What are they?

---
{layout="Launch"}
# Introducing Sam

- What _should_ our left-checking function do?

- What _should_ our right-checking function do?

- What _should_ @ifproglang{pyret}{`is-onscreen`} @ifproglang{wescheme}{`onscreen?`} do?

<!--
- What _should_ our left-checking function do? _Check to see if x is greater than -50_
- What _should_ our right-checking function do? _Check to see if x is less than 690_
- What should `onscreen?` do? _Answers may vary. Let students drive the discussion, and don't give away the answer!_
-->

---
{layout="Investigate-DN"}
# Introducing Sam 
With your partner, complete @printable-exercise{pages/left-and-right.adoc}.  

---
{layout="Investigate"}
# Introducing Sam

Make sure you have a `TRUE` example and a `FALSE` example!

@image{images/safe-left-dr.png}{width="700"}

<!--
	**False isn't wrong!**	
Many students - especially traditionally high-achieving ones - will be very concerned about writing examples that are "wrong." The misconception here is that an expression that produces `false` is somehow _incorrect_. You can preempt this in advance, by explaining that our Boolean-producing functions _should sometimes return false_, such as when Sam is offscreen.
- Push students to think carefully about corner-cases, such as when Sam is _exactly_ at -50 or 690.
-->

---
{layout="Investigate"}
# Introducing Sam

When you're finished, fix the corresponding functions in your @starter-file{inequalities-sam} and test it out.

What do you notice?
What do you wonder?

<!--
@ifproglang{wescheme}{
Students will notice that fixing `safe-left?` keeps Sam from disappearing off the left, but fixing `safe-right?` doesn't seem to keep Sam from disappearing off the right side!  When students encounter this, encourage them to look through the code to try and figure out why. The answer will be revealed in the next lesson section.
}

@ifproglang{pyret}{
Students will notice that fixing `is-safe-left` keeps Sam from disappearing off the left, but fixing `is-safe-right` doesn't seem to keep Sam from disappearing off the right side!  When students encounter this, encourage them to look through the code to try and figure out why. The answer will be revealed in the next lesson section.
}
-->

---
{layout="Synthesize"}
# Introducing Sam

Don’t trust the behavior of a complex system! Examples are where you look first. If they all pass, that’s a strong hint that the bug is elsewhere...

@ifproglang{pyret}{
- Does `is-safe-left` work correctly? How do you know?
- Does `is-safe-right` work correctly? How do you know?
}

@ifproglang{wescheme}{
- Does `safe-left?` work correctly? How do you know?
- Does `safe-right?` work correctly? How do you know?
}

---
{layout="Launch"}
# Protecting Sam on Both Sides

@image{images/sam-slide.png}{width="700"}

<!--
Recruit three student volunteers to roleplay the functions @ifproglang{wescheme}{`safe-left?`, `safe-right?` and `onscreen?`} @ifproglang{pyret}{`is-safe-left`, `is-safe-right`, and `is-onscreen`}. Give them 1 minute to read the Contract and code, as written in the program.

@ifproglang{wescheme}{
*Note:* In this programming language, question marks are pronounced "huh?". So `safe-left?` would be pronounced "safe left huh?" This can be a source of some amusement for students!
}

Ask the volunteers what their name, Domain and Range are. Explain that you, the facilitator, will be providing a coordinate input. The functions @ifproglang{wescheme}{`safe-left?` and `safe-right?`} @ifproglang{pyret}{`is-safe-left` and `is-safe-right`} will respond with either "true" or "false".

The function @ifproglang{wescheme}{`onscreen`?} @ifproglang{pyret}{`is-onscreen`}, however, will call the `safe-left` function! So the student roleplaying @ifproglang{wescheme}{`onscreen`?}@ifproglang{pyret}{`is-onscreen`} should turn to `safe-left` and give the input to them.

For example:
@ifproglang{wescheme}{

- Facilitator: "onscreen-huh 70"
- onscreen? (turns to safe-left?): "safe-left-huh 70"
- safe-left?: "true"
- onscreen? (turns back to facilitator): "true" +
{empty} +

- Facilitator: "onscreen-huh -100"
- onscreen? (turns to safe-left?): "safe-left-huh -100"
- safe-left?: "false"
- onscreen? (turns back to facilitator): "false" +
{empty} +

- Facilitator: "onscreen-huh 900"
- onscreen? (turns to safe-left?): "safe-left-huh 900"
- safe-left?: "true"
- onscreen? (turns back to facilitator): "true"

Hopefully your students will notice that `safe-right?` did not participate in this roleplay scenario at all!
}

@ifproglang{pyret}{
- Facilitator: "is-onscreen 70"
- is-onscreen (turns to is-safe-left): "is-safe-left 70"
- is-safe-left: "true"
- is-onscreen (turns back to facilitator): "true" +
{empty} +

- Facilitator: "is-onscreen -100"
- is-onscreen (turns to is-safe-left): "is-safe-left -100"
- is-safe-left: "false"
- is-onscreen (turns back to facilitator): "false" +
{empty} +

- Facilitator: "is-onscreen 900"
- is-onscreen (turns to is-safe-left): "is-safe-left 900"
- is-safe-left: "true"
- is-onscreen (turns back to facilitator): "true"

Hopefully your students will notice that `is-safe-right` did not participate in this roleplay scenario at all!
}
-->

---
{layout="Investigate"}
# Protecting Sam on Both Sides

@ifproglang{wescheme}{
What is the problem with `onscreen?`? How can we fix it?
}

@ifproglang{pyret}{
What is the problem with `is-onscreen`? How can we fix it?
}


<!--
@ifproglang{wescheme}{
- What is the problem with `onscreen?`? _It's only talking to `safe-left?`, it's not checking with ``safe-right?``_
- How can `onscreen?` check with both? _It needs to talk to `safe-left?` AND ``safe-right?``_
}

@ifproglang{pyret}{
- What is the problem with `is-onscreen`? _It's only talking to `is-safe-left`, it's not checking with ``is-safe-right``_
- How can `is-onscreen` check with both? _It needs to talk to `is-safe-left` AND ``is-safe-right``_.
}
-->

@image{images/onscreen.png}{width="500"}



---
{layout="Investigate-DN"}
# Protecting Sam on Both Sides

Complete @printable-exercise{pages/onscreen.adoc}. 

When you're done, select a driver to share to their screen, and modify the @starter-file{inequalities-sam} to protect Sam on both sides!

<!--
Extension Option
What if we wanted to keep Sam safe on the top and bottom edges of the screen as well?  What additional functions would we need?  What functions would need to change? We recommend that students tackling this challenge define a new function @ifproglang{pyret}{`is-onscreen-2`} @ifproglang{wescheme}{onscreen2?} because they will need their original @show{(code 'onscreen?)} code in the next section of this lesson.` 
-->

---
{layout="Launch-DN"}
# Boundary Detection in the Game 

Open your in-progress game file and press _Run_.

- How are the `TARGET` and `DANGER` behaving right now? 

- What do we want to change? 

- What happens to an image's x-coordinates when it moves off the screen? 

- How can we make the computer understand when an image has moved off the screen? 

---
{layout="Investigate-DN"}
# Boundary Detection in the Game 

@ifproglang{wescheme}{
Apply what you learned from Sam the Butterly to fix the `safe-left?`, `safe-right?`, and `onscreen?` functions in your code.
}
@ifproglang{pyret}{
Apply what you learned from Sam the Butterly to fix the `is-safe-left`, `is-safe-right`, and `is-onscreen` functions in your code.
}

<!--
Students should NOT add @show{(code 'safe-top?)} and @show{(code 'safe-bottom?)} to their game code!

Common Misconceptions:
- Students will need to test their code with their images to see if the boundaries are correct for them. In some cases, students may have to go back and rescale their images if they are too large or too small for the game.
- Students may be surprised that the same code that "traps Sam" also "resets the `DANGER` and `TARGET` ". It's critical to explain that these functions do _neither_ of those things! All they do is test if a coordinate is within a certain range on the x-axis. There is other code (hidden in the teachpack) that determines _what to do if the coordinate is offscreen_. The ability to re-use function is one of the most powerful features of mathematics - and programming!
-->

---
{layout="Synthesize"}
# Boundary Detection in the Game

The same code that "trapped" Sam also "resets" the `DANGER` and the `TARGET`. What is actually going on?

<!--
- Students may be surprised that the same code that "traps Sam" also "resets the `DANGER` and `TARGET` ". It's critical to explain that these functions do _neither_ of those things! All they do is test if a coordinate is within a certain range on the x-axis. There is other code (hidden in the teachpack) that determines _what to do if the coordinate is offscreen_. The ability to re-use function is one of the most powerful features of mathematics - and programming!
-->


---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{pages/onscreen-discussion.adoc}
- @opt-printable-exercise{pages/keeping-ninjacat-in-the-game.adoc}
