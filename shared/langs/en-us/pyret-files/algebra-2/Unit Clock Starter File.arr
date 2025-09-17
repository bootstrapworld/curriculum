use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/unit-clock-library.arr")

# the start-clock function will draw a unit clock, and plot the 
# length of A and B over time.

# speed of the animation (smaller = faster, larger = slower)
seconds-per-frame = 1/10

# divide clock into "slices"
num-slices = 12  # a clock has 12 hours

# the number of evenly-spaced labels around the clock
num-labels = 4   # labels at 12, 3, 6, and 9 o'clock

# a sample function, which is just the horizontal line f(x) = 0.5
fun f(x): 0.5 end

# start the clock animation!
start-clock(seconds-per-frame, num-slices, num-labels)

