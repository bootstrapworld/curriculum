---
{layout="Math Title Slide"}
# Making Game Images

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# The Game Starter File

By now you’ve learned about defining values, composing functions, and reading contracts. 

Taken together, that’s a lot of code you’re now able to understand! 

It’s time to flex your reading skills, and look at the file you’ll be working with to build your video game.


---
{layout="Investigate"}
# The Game Starter File

Read through the @starter-file{game}.

This file contains a lot of code! Some of it you haven’t seen before.

Going line-by-line, talk with your group about what you think each line does.


---
{layout="Synthesize"}
# The Game Starter File

- What familiar things did you see in the Game Starter File file?
- What were some unfamiliar things?  Any idea what they might do?
- What data type is `GAME-TITLE`?  What data type is `BACKGROUND`?
- What does `SCREENSHOT` return in the @vocab{Interactions Area}?
- Did anyone try pressing Run?  What happens when you press Run?*
- What do you think `image-url` does?


<!--
- *What familiar things did you see in the Game Starter File file?*
- *What were some unfamiliar things?  Any idea what they might do?*
_Answers vary: new functions, comments, images_

- *What data type is `GAME-TITLE`?  What data type is `BACKGROUND`?*
_``GAME-TITLE`` is a String, `BACKGROUND` is an Image_

- *What does `SCREENSHOT` return in the @vocab{Interactions Area}?*
_An image of the `BACKGROUND`, `PLAYER`, `TARGET`, and `DANGER` all together_

- *Did anyone try pressing "Run"?  What happens when you press "Run"?*
_Allow students to discuss what they see and what connections they see with the code_

- *What do you think `image-url` does?*
_Answers vary: It consumes a @vocab{String}, which is a URL (an image location on the Internet) and produces the @vocab{Image} inside our program_

-->

---
{layout="Launch"}
# Finding Your Game Images

`image-url :: String  ->  Image`

- This function takes in a web address for an image, and produces the image! 
- You can use `rotate`, `scale`, etc. with this image!
- Save a copy to your account


---
{layout="Launch"}
# Finding Your Game Images

@image{images/fair-use-diagram.png,300}


---
{layout="Investigate"}
# Finding Your Game Images

Find an image you like, making sure it’s transparent. Then save it using a good name.


@[youtube](VO7fTACB87w)

---
{layout="Investigate"}
# Finding Your Game Images

Upload to GDrive, and make sure sharing settings allow anyone with the link to view.

@[youtube](fXQcnrvxBd0)

---
{layout="Investigate"}
# Finding Your Game Images

@ifproglang{pyret}{Open your game file, click “Insert” > “Images”, and select an image}{style="font-size:16pt"}
@ifproglang{wescheme}{Open your game file, click “Images”, and select an image}{style="font-size:16pt"}

It will insert the code to display the image using `image-url`.{style="font-size:16pt"}

@ifproglang{pyret}{@[youtube](bWxNXTrGQOE)}
@ifproglang{wescheme}{@[youtube](lTl6bjbfCRo)}

---
{layout="Synthesize"}
# Finding Your Game Images


- What functions were most useful in helping you customize your images to make your game look and feel how you want it?
- How did you make use of function composition in customizing your images?
