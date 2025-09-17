use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# The Code in this Starterfile is complete and ready for you to learn from!

##########################################

# Alaska Flag:

# DEFINE SOME SHAPES USED IN THE FLAG

background = rectangle(300, 200, "solid", "darkblue")
small = star(9, "solid", "yellow")
big = star(14, "solid", "yellow")

# DESCRIBE THE FLAG WE WANT TO BUILD 

# On a blue background, place seven small yellow stars in the bottom left corner in the shape of the big dipper pointing toward the north star in the top right corner. 

# DEFINE alaska TO BUILD THE FLAG, LOCATING EACH COMPONENT USING COORDINATES.

alaska = 
  translate(big, 245, (5 * (200 / 6)),
    translate(small, 165, 55,
      translate(small, 150, 30,
        translate(small, 108, 40,
          translate(small, 110, 70,
            translate(small, 90, 95,
              translate(small, 75, 110,
                translate(small, 45, 120, 
                  background))))))))

