use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

IMG = image-url("http://www.wescheme.org/images/teachpacks2012/butterfly.png")

# is-safe-left :: Number -> Boolean
# Is the character visible on the left side of the screen?

# Write an EXAMPLE that makes this true, and one that makes this false:

fun is-safe-left(x):
  true
end

# is-safe-right :: Number -> Boolean
# Is the character visible on the right side of the screen?

# Write an EXAMPLE that makes this true, and one that makes this false:

fun is-safe-right(x):
  true
end

# is-onscreen :: Number -> Boolean
# Determines if the coordinate is on the screen

# EXAMPLEs:

fun is-onscreen(x):
  is-safe-left(x)
end


# start the program, using is-onscreen to detect boundaries
sam(is-onscreen, IMG)

# To see a table of all the coordinates Sam visited while
# the program was running, copy & paste the code below into
# the Interactions Area. (Be sure NOT to copy the '#'!)
# trace(is-onscreen, IMG)