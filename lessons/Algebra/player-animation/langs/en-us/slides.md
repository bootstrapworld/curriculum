@slidebreak
{layout="Math Title Slide"}
# Player Animation

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch-DN"}
# Defining Piecewise Functions 

- Sign in to @starter-file{program-list} and open your saved game starter files
- You've already defined functions to move your `DANGER` and `TARGET`. Take a moment to refresh your memory on how they work.


@slidebreak
{layout="Launch"}
# Defining Piecewise Functions

- What controlled the speed of your characters?
- What controlled the _direction_ of your characters?

@slidebreak
{layout="Launch"}
# Defining Piecewise Functions

If we wanted our `PLAYER` to go up all the time, we would already know how to do that. If we wanted our `PLAYER` to go _down_ all the time, we would already know how to do that. But we want the player to go up _only_ when the "up" arrow is pressed, and down when the "down" arrow is pressed. 

**Do we know how to make a function behave differently, based on its input?**

@slidebreak
{layout="Investigate-DN"}
# Defining Piecewise Functions

* Look for `update-player` in your game file.
* What is the Contract for `update-player`?
* What does each part of the domain and range represent?
* How does the y-coordinate of `PLAYER` change when the user presses the "up" key?

<!--
@ifproglang{wescheme}{
_The Name is `update-player`, the Domain consists of a Number and String, and Range is a Number._
_Domain: the Number is the y-coordinate of `PLAYER`, the String is the key that the user pressed; Range: the Number is the new y-coordinate of ``PLAYER``_}
@ifproglang{pyret}{
_The Name is `update-player`, the Domain consists of two Numbers and a String, and the Range is a Number._
_Domain: the Numbers are the x-coordinate and the y-coordinate of `PLAYER` when the key is pressed, the String is the key that the user pressed; Range: the Number is the new y-coordinate of ``PLAYER``_}
_When the user presses the "up" key, the y-coordinate should increase, the program should add something to it_
-->

@slidebreak
{layout="InvestigateC"}
# Defining Piecewise Functions

Complete @printable-exercise{pages/update-player.adoc} with a partner, then type your code into your *Game Project file* and test it out.

@image{images/player-move.png}{width="250"}


<!--
Students often think of this function as returning a _relative distance_ (e.g. "it adds 20"), instead of an absolute coordinate (e.g. "the new y-coordinate is the old y plus 20")
-->

@slidebreak
{layout="Synthesize"}
# Defining Piecewise Functions

- How is this function similar to the piecewise functions you've seen before? How is it different?
- How could we change this function so that the "W" key makes the player go up, instead of the arrow key?
- How could we change this function so that the "W" key makes the player go up, _in addition to_ the arrow key?
- Suppose your little brother or sister walks by and hits a random key. What should happen if you hit a random key that doesn’t have a meaning in your function? What happens now?

@slidebreak
{layout="Launch"}
# Cheat Codes and Customizations 

@ifproglang{wescheme}{
Reminder: Use `;` to add comments to code! 
}
@ifproglang{pyret}{
Reminder: Use `#` to add comments to code! 
}
Adding useful comments to code is an important part of programming. It lets us leave messages for other programmers, leave notes for ourselves, or "turn off" pieces of code that we don't want or need to @vocab{debug} later.

@slidebreak
{layout="Investigate-DN"}
# Cheat Codes and Customizations 

Now is your time to customize your game! Try implementing some of the following features, or make your own!{style="font-size:15pt"}

* Warping - program one key to "warp" the player to a set location, such as the center of the screen{style="font-size:15pt"}
* Boundaries - change `update-player` such that `PLAYER` cannot move off the top or bottom of the screen{style="font-size:15pt"}
* Wrapping - add code to `update-player` such that when `PLAYER` moves to the top of the screen, it reappears at the bottom, and vice versa{style="font-size:15pt"}
* Hiding - add a key that will make `PLAYER` seem to disappear, and reappear when the same key is pressed again{style="font-size:15pt"}

Complete at least one of the @printable-exercise{pages/challenges.adoc} before turning to your computer.{style="font-size:15pt"}

<!--
It's likely that once they hear other students' ideas, they will want more time to try them out. If time allows, give students additional _slices_ of "hacking time", bringing them back to share each other's ideas and solutions before sending them off to program some more. This dramatically ramps up the creativity and engagement in the classroom, giving better results than having one long stretch of programming time.
-->

@slidebreak
{layout="Synthesize"}
# Cheat Codes and Customizations 

* What would it take to make the player move left and right? 
* Why can't we do this without changing the Contract?

@slidebreak
{layout="Supplemental"}
# Optional Extensions...

If your game is working and you have time... you might want to dig into 2-d movement in the game, using the Posn data type.

Start with:

* @opt-printable-exercise{2d-character-movement.adoc} 
* @opt-printable-exercise{2d-character-movement-cont.adoc}

Once you've gotten your danger moving diagonally, you're ready to build upon your understanding of Posn and piecewise functions to tackle:

* @opt-printable-exercise{update-player-2.adoc}.
