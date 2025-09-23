use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Do Now: Click run and type "mexico-flag into the interactions window to see an image of the flag you are trying to create.

##################################################

#1) Using the image of mexico-flag, describe the composition of the flag of Mexico.

#2) Type "mexico" into the interactions area to see the image that the code below produces. It's not quite right. Make adjustments to the code to get the image of the flag building correctly!
background = rectangle(300, 200, "outline", "black")
red-stripe = rectangle(300, 80, "solid", "red")
green-stripe = rectangle(300/3, 50, "solid", "dark green")
crest = scale(0.5, 
  image-url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/algebra/flags/mexico-crest-image.png")
)

mexico = 
  translate(crest, 50, 40,
    translate(green-stripe, 150, 100, 
      translate(red-stripe, 50, 60,
        background)))