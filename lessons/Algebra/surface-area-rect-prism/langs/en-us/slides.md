---
{layout="Math Title Slide"}
# Surface Area of a Rectangular Prism{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Surface Area


Turn to @printable-exercise{prism-explore.adoc}. 
- What do you picture in your mind when you hear @vocab{rectangular prism}?
- What do you picture in your mind when you hear @vocab{surface area}?

---
{layout="LaunchR"}
# Surface Area

Now, open the @starter-file{prism} in a new tab, save a copy, and click "Run".

Type `prism` into the Interactions Area to see an image of a rectangular prism. What do you notice about the prism? 
@image{images/prism.png}

---
{layout="Launch"}
# Surface Area

- *Faces* are the flat surfaces on the outside of a solid figure. 
- *Edges* are the line segments where the faces meet in each of the three dimensions. 
- The *surface area* of a prism is calculated by adding the areas of its faces. 

---
{layout="Launch"}
# Surface Area

- Go to PART 1 and look at the definition for `front` and `back`. Type `front` into the Interactions Area. 
- What do you get?

`Front` has been defined to draw a rectangle whose dimensions are width and height.{style="font-size:14pt"}

- Write definitions for each of the other faces of the prism!
- Click "Run" and test each of them in the Interactions Area to make sure that they match the prism you started with.

---
{layout="Launch"}
# Surface Area

- Go to PART 2 in the code. @ifproglang{pyret}{Type `print-imgs(faces)` into the Interactions Area.}@ifproglang{wescheme}{Type `(print-imgs faces)` into the Interactions Area.}  
- How many rectangles do you see?

The code in PART 2 says @ifproglang{pyret}{`faces = [list: front, back, ]`}@ifproglang{wescheme}{`(define faces (list front back))`} , which defines `faces` to be a list of values. 

_This list will include all of the faces of the prism, but right now it only includes `front` and `back`._{style="font-size:12pt"} 

- Add the names of each of the remaining faces to the list.{style="font-size:18pt"}  

@ifproglang{pyret}{(Order doesn't matter - but be sure to put commas in between list items, and do not use the word “and”.)}{style="font-size:12pt"}


---
{layout="Launch"}
# Surface Area

- When you're ready, click "Run" and type
@ifproglang{pyret}{`print-imgs(faces)`.}
@ifproglang{wescheme}{`(print-imgs faces)`.} 
- What do you Notice? What do you Wonder?
- Do you have enough shapes to cover all of the faces of the prism?
- Now, read the comments in PART 3 of the file to learn how to print the faces to build your prism.


---
{layout="Investigate"}
# Surface Area

1. Cut out and tape together the images you defined to form a 3D model of a rectangular prism. 

1. Use your model to calculate the surface of the figure.

1. Turn to PART 4 in the @starter-file{prism} and define `surface-area` using length, width, and height.

<!--
Labeling the shapes with face names and/or area before taping them together may be helpful for some students. Printing two copies of the file (one to cut and one to write on) might also be useful!
-->

---
{layout="Synthesize"}
# Surface Area

- What code did you write to define `surface-area`? 
- How many different versions of the definition can we generate as a class?
- How did building the prism help you to understand surface area?
- How did writing the code for surface area help you to understand surface area?

<!--
@ifproglang{pyret}{
Three possible correct ways to define surface area are:

- `surface-area = A-front + A-back + A-left + A-right + A-top + A-bottom`
- `surface-area = (2 * A-front) + (2 * A-left) + (2 * A-top)`
- `surface-area = 2 (A-front + A-left + A-top)`
}
-->	
