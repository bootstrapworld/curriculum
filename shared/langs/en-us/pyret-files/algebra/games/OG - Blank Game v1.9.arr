use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# 0. Game title: Write the title of your game here
TITLE = "My Game"
TITLE-COLOR = "white"

# Graphics - danger, target, projectile and player images
BACKGROUND = image-url("http://www.bootstrapworld.org/clipart/Backgrounds/Night%20Forest.jpg")
DANGER = triangle(30, "solid", "red")
TARGET = circle(20, "solid", "green")
PLAYER = image-url("http://www.bootstrapworld.org/clipart/Monsters/Robot.png")

# here's a screenshot of the game, with the PLAYER at (320, 240),
# the TARGET at (400 500) and the DANGER at (150, 200)
SCREENSHOT = 
  translate(DANGER, 150, 200,
    translate(TARGET, 400, 500, 
      translate(PLAYER, 320, 240, BACKGROUND)))

######################################################
# 1. Making the Danger and the Target Move

update-danger :: Number -> Number
# given the danger's x-coordinate, output the NEXT x

# write EXAMPLEs for update-danger below this line


fun update-danger(x):
  x
end


update-target :: Number -> Number
# given the target's x-coordinate, output the NEXT x

# write EXAMPLEs for update-target below this line

fun update-target(x):
  x
end

######################################################
# 2. Making the Danger and the Target Come Back Again: 
#    We need to know that they're gone!  
#    Are they on the screen?

is-safe-left :: Number -> Boolean
# Is the character visible on the left side of the screen?

# Write an EXAMPLE that makes this true, and one that makes this false:

fun is-safe-left(x):
  true
end

is-safe-right :: Number -> Boolean
# Is the character visible on the right side of the screen?

# Write an EXAMPLE that makes this true, and one that makes this false:

fun is-safe-right(x):
  true
end


is-onscreen :: Number -> Boolean
# Determines if the coordinate is on the screen

# EXAMPLEs:

fun is-onscreen(x):
  true
end


######################################################
# 3. Get our Player moving!

update-player :: Number, String -> Number
# given the player's y-coordinate and a direction, output the NEXT y

# EXAMPLEs:

fun update-player(y, key):
  y
end


######################################################
# 4. Collisions: When the player is close enough to the Target
#    or the Danger, then something should happen!
#    We need to know what "close enough" means, and we need to
#    know how far apart things are.

# If _distances-color_ is set to "yellow", then the game will draw
# a yellow triangle between the player and each character. 
# That triangle will be labelled with line-length on the legs,
# and with distance on the hypotenuse. (This works for any valid color)
_distances-color_ = ""

line-length :: Number, Number -> Number
# the distance between two points on a number line
# some examples - notice that we should always return the
# same answer, no matter what the order of the inputs is!
examples:
  line-length(20, 10) is 20 - 10
  line-length(10, 20) is 20 - 10
end

fun line-length(a, b):
  if a > b: a - b
  else: b - a
  end
end

distance :: Number, Number, Number, Number -> Number
# The distance between two points on screen:
# We have the player's x and y, and a character's x and y.
# How far apart are they?
# EXAMPLEs:

fun distance(px, py, cx, cy):
  0
end

is-collision :: Number, Number, Number, Number -> Boolean 
# How close is close enough?  
# We have the player's x and y, and a character's x and y.
# We can ask how far apart they are.  Did they collide?
# EXAMPLEs:


fun is-collision(px, py, cx, cy):
  false
end


mystery = radial-star(5, 5, 3, "solid", "silver")
fun update-mystery(x, y):
  x
end


######################################################
# PROVIDED CODE

g = make-game(TITLE, TITLE-COLOR,
  BACKGROUND,
  DANGER, update-danger,
  TARGET, update-target,
  PLAYER, update-player,
  mystery, update-mystery,
  _distances-color_, line-length, distance,
  is-collision, is-onscreen)

play(g)

