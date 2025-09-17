use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

##################################################
# PART 0: DEFINING THE DIMENSIONS OF OUR PRISM

LENGTH = 340
WIDTH  = 180
HEIGHT =  50

# Click "Run" and type "prism" into the interactions area. Take a close look at what appears. How many faces are there? How many differently sized faces?

##################################################
# PART 1: DEFINING THE FACES OF OUR PRISM

# Add definitions below for each of the faces of the prism. On line 17-18, we've provided "front" and "back". Starting on line 19, you'll need to add: left, right, top, and bottom. 

front = rectangle(WIDTH, HEIGHT, "outline", "black")
back  = rectangle(WIDTH, HEIGHT, "outline", "black")

# ???  Why "outline", "black"?
# Because it will print well in black & white! 
# If you're printing in color, feel free to make your own color choices or even replicate the colors you see in the prism in your interactions area!

#################################################
# PART 2: LISTING THE FACES OF OUR PRISM

# Type "print-imgs(faces)" into the interactions area. How many rectangles do you see?
# Complete the list of faces below to include all of the faces of the prism that you defined above. Order doesn't matter - but do separate faces with commas! Do not use the word "and" between listed items. 

faces = [list: front, back, ]

#################################################
# PART 3: CONSTRUCTING YOUR PRISM

# Once you have defined the faces, type "print-imgs(faces)" again. Confirm that you see all of the faces you would need to build the prism.
# Right-click (or control click) on the collection of images. 
# Select "Save Image As".  
# Print the file.
# Cut out the rectangles and tape them together to build the prism.
# Calculate the total surface area of the prism.

###################################################
# PART 4: WRITING CODE TO CALCULATE THE SURFACE AREA OF THE PRISM

# First, write definitions to calculate the areas (A) of individual faces of the prism. 

A-front = WIDTH * HEIGHT

# Define "surface-area" to find the sum of the areas of the faces, using your area definitions.  
