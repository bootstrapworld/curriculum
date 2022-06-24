---
{layout="Math Title Slide"}
# Functions for Character Animation{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
->
---
{layout="Launch"}
# Animation 

- How does a flip-book animation work?
- Why do we see movement from still images? 
- How might this apply to our game? 

<!--
How does a flip-book animation work? Each page of the book is slightly different, and the pages go so fast that the motion looks smooth.

Why do we see movement from still images?
Our eyes fill in the gaps between rapidly changing images.

How might this apply to our game?
If we change image coordinates a little bit at a time, they will appear to move.
-->

---
{layout="Launch"}
# Animation

At any given moment, we know the x-coordinate of our TARGET and our DANGER. 
We need to compute where they go next.

@image{images/ninjacat-numline.png,a}{width="900"}

<!--
Select 2 student volunteers - one to be TARGET, one to be DANGER. Start with just TARGET.
- Have the class select a starting x- and y-coordinate for the TARGET, and have the volunteer move to that position on the number line or coordinate plane.
- The TARGET character moves by 50 (pixels) on each frame of the game.
- When they hear "update target" followed by their current location, the TARGET takes a step in the negative direction, moving down the x-axis by 50 (pixels).
- We make TARGET move by calling out update-target(300, 200), update-target(250, 100), etc.
- How quickly could I get TARGET to move across the classroom?
- After practicing with TARGET, add DANGER in.
- DANGER takes a step in the positive direction when they hear "update danger" followed by their current x-coordinate.
- We make DANGER move by calling out update-danger(40, 92), update-danger(39, 18), etc.
- On a standard number line, if the DANGER is moving to the right, is its x-coordinate increasing or decreasing?
- Practice this a few times with your volunteer, asking the class what their new x-coordinate is each time. Then have the other students call the update-danger function.
-->

---
{layout="Launch"}
# Animation

- Open your saved copy of the Game Starter File, or @starter-file{game, make a new copy}.
- What did you notice about the movement of TARGET and DANGER? What was changing about them?
- What jobs could we hand over to the computer to make it possible for us to play the game? 

<!--
What did you notice about the movement of TARGET and DANGER? What was changing about them?

Answers will vary: they were moving horizontally, their x-coordinates were changing, they were not moving smoothly, etc.

What jobs could we hand over to the computer to make it possible for us to play the game? The computer could handle automatically moving TARGET and DANGER, then we could control the movement of PLAYER.
-->

---
{layout="Investigate-DN"}
# Animation

- In your saved copy of the @starter-file{game}, examine the `update-danger` function
- Identify the contract, and interpret what the function is currently doing
- Complete the first word problem on @printable-exercise{pages/character-animation-dr.adoc}

---
{layout="Investigate-DN"}
# Animation

Copy the code for `update-danger` into your starter file and click Run.{style="font-size:15pt"}

Then complete the second word problem on @printable-exercise{pages/character-animation-dr.adoc}, with your partner and transfer the code to your Game Starter File.  {style="font-size:15pt"}

Click Run to see `DANGER` and `TARGET` move across the screen independently!{style="font-size:15pt"}

Once you have successfully gotten `update-target` and `update-danger` working, you can change the functions to make the characters move in whichever direction and whatever speed you want!  {style="font-size:15pt"}

Be sure to modify your purpose statements and examples if you change your functions.{style="font-size:15pt"}

---
{layout="Synthesize"}

# Synthesize
Connecting the code to the underlying math is important - especially if you want to customize your game!

- What part of the function controls the character's _speed?_
- What part of the function controls the character's _direction?_
- If you wanted the characters to move in 2 dimensions (diagonally, for example), would anything have to change about the Domain? What about the Range?
