use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# DO NOW: Click Run and type "puerto-rico-flag" into the interactions window to see an image of the flag of Puerto Rico. 

##################################################
# Describe what the Puerto Rican flag should look like, using as much detail as possible.
#
#

# Type "puerto-rico" into the Interactions Area to see the image of what the code below produces. 

# It's not quite right... but you'll have it cleaned up in no time!  

# Go through the code below line by line and adjust it to make the images match. As you work, click run and type "puerto-rico" into the Interactions Area to see your progress!

##################################################
#Code for the flag of Puerto Rico

# 1) Start by defining the shapes we will need to make the flag. Type them into the Interactions Area to see what they produce.

background = rectangle(300, 200, "outline", "black")
rrectangle = rectangle(100, 50, "solid", "red")
btriangle = rotate(100, triangle(100, "solid", "blue"))
wstar = star(20, "solid", "red")

# 2) Describe what the Puerto Rican flag should look like, using as much detail as possible. (Copy and paste what you wrote above!)

# 3) Define a variable "puerto-rico" to make the image of the Puerto Rican flag as you described it above. 
puerto-rico =
  translate(wstar, 225, 50,
    translate(btriangle, 75, 150,
      translate(rrectangle, 75, 50,
        translate(rrectangle, 225, 150,
          translate(rrectangle, 110, 125,                                             background)))))


