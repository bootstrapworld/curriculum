---

# Functions for Character Animation

---
# Animation 

- How does a flip-book animation work?
- Why do we see movement from still images? 
- How might this apply to our game? 

---
# Animation

At any given moment, we know the x-coordinate of our TARGET and our DANGER. 
We need to compute where they go next.

{.column}

@image{images/ninjacat-numline.png,a}

---
# Animation

Open your game starter file and examine the `update-danger` function.
Identify the contract, and interpret what the function is currently doing.

Let's complete the first word problem on @printable-exercise{pages/character-animation-dr.adoc} together.

---
# Animation

Copy the code for `update-danger` into your starter file and click Run.

Then complete the second word problem on @printable-exercise{pages/character-animation-dr.adoc}, with your partner and transfer the code to your Game Starter File.  

Click Run to see `DANGER` and `TARGET` move across the screen independently!

Once you have successfully gotten `update-target` and `update-danger` working, you can change the functions to make the characters move in whichever direction and whatever speed you want!  

*Be sure to modify your purpose statements and examples if you change your functions.*