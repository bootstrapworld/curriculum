use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# A. Game title: Write the title of your game here
TITLE = "My Game"
TITLE-COLOR = "white"

# B. Graphics - Define your danger, target, projectile and player images
# You can replace any of the definitions below with other images
# And scale them to whatever size makes the most sense! 

BACKGROUND = image-url(
 "http://www.bootstrapworld.org/clipart/Backgrounds/Night%20Forest.jpg")
DANGER = triangle(30, "solid", "red")
TARGET = circle(20, "solid", "yellow")
PLAYER = image-url(
  "http://www.bootstrapworld.org/clipart/Monsters/Robot.png")

# C. Here's a screenshot of the game.
# The BACKGROUND is 640 x 480 with the characters placed on that field.
# The character's initial locations are:
# PLAYER (320, 240)
# TARGET (400 500)
# DANGER (150, 200)
# You can change the characters' coordinates in the code below to compose your image how you like it.

SCREENSHOT = 
  translate(DANGER, 150, 200,
    translate(TARGET, 400, 500, 
      translate(PLAYER, 320, 240, BACKGROUND)))

