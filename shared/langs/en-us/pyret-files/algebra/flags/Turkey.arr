use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Do Now: Click run and type "turkey-flag" into the interactions window to see a version of the flag of Turkey

#################################################

# 1) This image of the flag is 300 pixels wide by 200 pixels tall. Fix the code below so that `basic-flag` looks like the Turkish flag (without the crescent)

background = rectangle(400, 250, "solid", "red")
white-star = rotate(90, star(20, "solid", "blue"))
basic-flag = translate(white-star, 100, 100, background)
  
# 2) How can we create a crescent? In the space below, try to make a crescent shape by putting one image on top of another...
bottom = circle(50, "solid", "red")
top = square(50, "solid", "blue")
crescent = translate(top, 80, 50, bottom)

# 3) Can you put the crescent you've defined onto the basic-flag, to create the full Turkish flag?