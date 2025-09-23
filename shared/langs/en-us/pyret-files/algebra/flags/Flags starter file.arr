use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")


####################################################

#DO NOW: Click run and type "japan-flag" into the interactions window to see what the flag of Japan should look like.

####################################################
# Flag of Japan 

# 1) Define the shapes used to make the flag and type them into the Interactions Area to see what they produce.
background = rectangle(300, 200, "outline", "black")
dot = circle(100, "solid", "red")

# 2) Describe the image you're going to build, using as much detail as possible!
# The flag of Japan is a white rectangle with a red circle centered on it. 

# 3) Build the image, identifying the coordinates that will correctly locate the center of each piece. Define a variable for the image.

japan = translate(dot, 50, 40, background)

# 4) Compare "japan" (the image the code builds) to "japan-flag (the image you started with) and make any necessary adjustments to the code so that the images match.

###################################################
# EXTENSION: Flag of Somalia

somalia-flag = image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1j7sxfBP_DNNUf8bVCtZJ4u4aOZNLJDL5")

# Type "somalia-flag" into the interactions window to see what the flag of Somalia should look like. Then, using "japan" as a model, write code to generate an image "somalia" to match "somalia-flag"
