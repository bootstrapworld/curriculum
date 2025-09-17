use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Do Now: Click run and type "trinidad-flag" into the interactions window to see a version of the flag of Trinidad created using a white background. 

#################################################

# Look at the code and think about the following questions...

# A) No part of this flag looks like a square. Why did the programmer define one?
# B) How did the programmer know to use a rotation of 135 degrees?
# C) The square has a sidelength of 200 * num-sqrt(2). Why?

#################################################

#Code for the flag of Trinidad with a white background:

# 1) Define the shapes used to make the flag and type them into the Interactions Area to see what they produce.

background  = rectangle(300, 200, "outline", "black") 
redsquare   = rotate(135, square(200 * num-sqrt(2), "solid", "red")) 
blackstripe = rotate(135, rectangle(500, 62, "solid", "black")) 
  
# 2) Describe the image of the flag of Trinidad using as much detail as possible.
#The flag of trinidad is red with a white outlined black stripe running diagonally from the left top edge of the flag to the right bottom edge, such that the red extends top to bottom on both the left and right edges of the flag, the bottom of the stripe touches the top-left corner, and the top of the stripe touches the bottom-right corner.

# 3) Define a variable called "trinidad-flag" to build the image of the flag of Trinidad, identifying the coordinates that will correctly locate the center of each piece.  
trinidad-flag =   
  translate(blackstripe, 150, 100,
    translate(redsquare, 0, 0,
      translate(redsquare, 300, 200,
          background)))

##################################################

# YOUR TURN TO CODE: Flag of Trinidad with a red background
# Write new code to make the same image. Start with a red background this time and layer white & black shapes on it.  Define this image of the flag as "trinidad". Will  anything from the code you've just read be useful to you in writing this new code?