---

# Sam the Butterfly - Applying Inequalities

---
{layout="Launch"}
# Introducing Sam 

Open the @starter-file{inequalities-sam} and click "Save A Copy."

Turn to @printable-exercise{pages/sam-intro.adoc, Introducing Sam}, click run and use the arrow keys to investigate the program with your partner.

<!--
* What is something you noticed about this program?
* What do you see when Sam is at (0,0)?  Why is that?
* How far can Sam go to the left and stay on the screen?
* How could we write this as an @vocab{expression}?
-->

---
{layout="Launch"}
# Introducing Sam 

There are three functions defined in @starter-file{inequalities-sam}. What are they?

---
{layout="Launch"}
# Introducing Sam 

- What should @ifproglang{pyret}{`is-safe-left`} @ifproglang{wescheme}{`safe-left?`} do?

- What should @ifproglang{pyret}{`is-safe-right`} @ifproglang{wescheme}{`safe-right?`} do?

- What should @ifproglang{pyret}{`is-onscreen`} @ifproglang{wescheme}{`onscreen?`} do?

---
{layout="Investigate"}
# Introducing Sam 
With your partners, complete @printable-exercise{pages/left-and-right.adoc}.  

When you're finished, fix the corresponding functions in your @starter-file{inequalities-sam} and test it out.

<!--
**False isn't wrong!**	
Many students - especially traditionally high-achieving ones - will be very concerned about writing examples that are "wrong." The misconception here is that an expression that produces `false` is somehow _incorrect_. You can preempt this in advance, by explaining that our Boolean-producing functions _should sometimes return false_, such as when Sam is offscreen.
- Push students to think carefully about corner-cases, such as when Sam is _exactly_ at -50 or 690.

@ifproglang{wescheme}{
Students will notice that fixing `safe-left?` keeps Sam from disappearing off the left, but fixing `safe-right?` doesn't seem to keep Sam from disappearing off the right side!  When students encounter this, encourage them to look through the code to try and figure out why. The answer will be revealed in the next lesson.
}

@ifproglang{pyret}{
Students will notice that fixing `is-safe-left` keeps Sam from disappearing off the left, but fixing `is-safe-right` doesn't seem to keep Sam from disappearing off the right side!  When students encounter this, encourage them to look through the code to try and figure out why. The answer will be revealed in the next lesson.
}
-->

---
{layout="Launch"}
# Protecting Sam on Both Sides

@image{images/sam-slide.png, "a"}{width="700"}

<!--
Recruit three student volunteers to roleplay the functions `safe-left?`, `safe-right?` and `onscreen?`. Give them 1 minute to read the contract and code, as written in the program.

- As in the previous lesson, ask the volunteers what their name, Domain and Range are, and then test them out by calling out their name, followed by a number. (For example, "(safe-left? 20)!", "(safe-right? -100)!", "(onscreen? 829)!") *Note"* the code for `onscreen` _calls the safe-left function!_. So the student roleplaying `onscreen` should turn to `safe-left` and give the input to them.

For example:
@ifproglang{wescheme}{

- *Facilitator*: "onscreen-huh 70"
- *onscreen?* (turns to safe-left?): "safe-left-huh 70"
- *safe-left?*: "true"
- *onscreen?* (turns back to facilitator): "true" +
{empty} +

- *Facilitator*: "onscreen-huh -100"
- *onscreen?* (turns to safe-left?): "safe-left-huh -100"
- *safe-left?*: "false"
- *onscreen?* (turns back to facilitator): "false" +
{empty} +

- *Facilitator*: "onscreen-huh 900"
- *onscreen?* (turns to safe-left?): "safe-left-huh 900"
- *safe-left?*: "true"
- *onscreen?* (turns back to facilitator): "true" +
{empty} +

*Ask the rest of the class*

- What is the problem with `onscreen?`? +
_It's only talking to `safe-left?`, it's not checking with ``safe-right?``_

- How can `onscreen?` check with both? +
_It needs to talk to `safe-left?` AND ``safe-right?``_

}

@ifproglang{pyret}{
- *Facilitator*: "is-onscreen 70"
- *is-onscreen* (turns to is-safe-left): "is-safe-left 70"
- *is-safe-left*: "true"
- *is-onscreen* (turns back to facilitator): "true" +
{empty} +

- *Facilitator*: "is-onscreen -100"
- *is-onscreen* (turns to is-safe-left): "safe-left-huh -100"
- *is-safe-left*: "false"
- *is-onscreen* (turns back to facilitator): "false" +
{empty} +

- *Facilitator*: "is-onscreen 900"
- *is-onscreen* (turns to is-safe-left): "safe-left-huh 900"
- *is-safe-left*: "true"
- *is-onscreen* (turns back to facilitator): "true" +
{empty} +

*Ask the rest of the class*

- What is the problem with `is-onscreen`? +
_It's only talking to `is-safe-left`, it's not checking with ``is-safe-right``_

- How can `is-onscreen` check with both? +
_It needs to talk to `is-safe-left` AND ``is-safe-right``_
}

Have students complete @printable-exercise{pages/onscreen.adoc}. When this function is entered into the editor, students should now see that Sam is protected on _both_ sides of the screen.

-->

---
{layout="Investigate"}
# Protecting Sam on Both Sides

What does is-onscreen check for?  What should it check for?



@image{images/onscreen.png,a}{width="500"}



---
{layout="Investigate"}
# Protecting Sam on Both Sides

Complete @printable-exercise{pages/onscreen.adoc}. 

When you're done, select a driver to share to their screen, and protect Sam on both sides!

<!--
Extension Option
What if we wanted to keep Sam safe on the top and bottom edges of the screen as well?  What additional functions would we need?  What functions would need to change? _We recommend that students tackling this challenge define a new function `is-onscreen-2` 
-->

---
{layout="Launch"}
# Boundary Detection in the Game 

Open your in-progress game file and press Run.

- How are the `TARGET` and `DANGER` behaving right now? 

- What do we want to change? 

- How do we know when an image has moved off the screen? 

- How can we make the computer understand when an image has moved off the screen? 

---
{layout="Investigate"}
# Boundary Detection in the Game 

@ifproglang{wescheme}{
Apply what you learned from Sam the Butterly to fix the `safe-left?`, `safe-right?`, and `onscreen?` functions in your code.
}
@ifproglang{pyret}{
Apply what you learned from Sam the Butterly to fix the `is-safe-left`, `is-safe-right`, and `is-onscreen` functions in your code.
}

*Note: If you figured out the challenge of how to keep Sam safe on top and bottom, should not use the additional code they wrote.*

<!--
Common Misconceptions:
- Students will need to test their code with their images to see if the boundaries are correct for them.  Students with large images may need to use slightly wider boundaries, or vice versa for small images.  In some cases, students may have to go back and rescale their images if they are too large or too small for the game.
- Students may be surprised that the same code that "traps Sam" also "resets the `DANGER` and `TARGET` ". It's critical to explain that these functions do _neither_ of those things! All they do is test if a coordinate is within a certain range on the x-axis. There is other code (hidden in the teachpack) that determines _what to do if the coordinate is offscreen_. The ability to re-use function is one of the most powerful features of mathematics - and programming!
-->

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{pages/onscreen-discussion.adoc}
- @opt-printable-exercise{pages/keeping-ninjacat-in-the-game.adoc}
