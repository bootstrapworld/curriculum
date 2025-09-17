use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# WARNING - THERE'S SOME SLOPPY CODE IN THIS FILE! 
# GOOD NEWS - YOU WILL FIX IT!

# Word Problem: Rocket Height
# Directions: A rocket blasts off, and is now traveling at a constant velocity of 7 meters per second. Use the Design Recipe to write a function rocket-height, which takes in a number of seconds and calculates the height.

# CONTRACT
# rocket-height ::  -> 

# PURPOSE: 
#

# EXAMPLES:
examples:
  rocket-height(0) is 0
end

fun rocket-height(seconds):
  0
end

# TO MAKE IT FLY:
blastoff(rocket-height)

# TO SEE A GRAPH OF THE FLIGHT-PATH:
# graph(rocket-height)

# TO SEE A SIMULATION IN SPACE:
# space(rocket-height)

# TO SEE EVERYTHING (requires a wide monitor):
# everything(rocket-height)
