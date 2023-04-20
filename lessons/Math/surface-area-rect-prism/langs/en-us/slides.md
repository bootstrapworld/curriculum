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

Now, open the @starter-file{prism} in a new tab, save a copy, and click "Run".


---
{layout="LaunchR"}
# Surface Area

Type `prism` into the Interactions Area to see an image of a rectangular prism. What do you notice about the prism? 
@image{images/prism.png}

---
{layout="Launch"}
# Surface Area

*Faces* are the flat surfaces on the outside of a solid figure. *Edges* are the line segments where the faces meet in each of the three dimensions. The *surface area* of a prism is calculated by adding the areas of its faces. 

---
{layout="Launch"}
# Surface Area

- Go to PART 1 and look at the definition for `front` and `back`. Type `front` into the Interactions Area. What do you get?
- Just as `front` has been defined to draw a rectangle whose dimensions are width and height, you will need to write definitions for each of the other faces of the prism.
- Click "Run" and test each of them in the Interactions Area to make sure that they match the prism you started with.

---
{layout="Launch"}
# Surface Area

- Go to PART 2 in the code. @ifproglang{pyret}{Type `print-imgs(faces)` into the Interactions Area.}@ifproglang{wescheme}{Type `(print-imgs faces)` into the Interactions Area.}  How many rectangles do you see? _Two_
- The code in PART 2 says @ifproglang{pyret}{`faces = [list: front, ]`}@ifproglang{wescheme}{`(define faces (list front back))`} , which defines `faces` to be a list of values. This list will include all of the faces of the prism, but right now it only includes `front` and `back`. Add the names of each of the remaining faces to the list. 

@ifproglang{pyret}{(Order doesn't matter - but be sure to put commas in between list items, and do not use the word “and”.)}


---
{layout="Launch"}
# Surface Area

- When you're ready, click "Run" and type
@ifproglang{pyret}{`print-imgs(faces)`.}
@ifproglang{wescheme}{`(print-imgs faces)`.} What do you Notice? What do you Wonder?
- Do you have enough shapes to cover all of the faces of the prism?
- Now, read the comments in PART 3 of the file to learn how to print the faces to build your prism.


---
{layout="Investigate"}
# Surface Area

Cut out and tape together the images you defined to form a 3D model of a rectangular prism. Now, use your model to calculate surface area.

Once you've built your prism, use it to help you calculate the surface area of the figure. Then, turn to PART 4 in the @starter-file{prism} and define `surface-area` using length, width, and height.

<!--
Labeling the shapes with face names and/or area before taping them together may be helpful for some students. Printing two copies of the file (one to cut and one to write on) might also be useful!
-->

---
{layout="Synthesize"}
# Surface Area

- How many definitions did you write in order to calculate the surface area of the prism?
- How did building the prism help you to understand surface area?
- How did writing the code for surface area help you to understand surface area?
