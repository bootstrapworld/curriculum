use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Read the example code below carefully!
# Then click "Run" to see what happens.

# 1) DEFINE AN INEQUALITY FUNCTION
# less-than-zero : Number -> Boolean
# An inequality expressed as a function that tests if x < 0

fun less-than-zero(x): x < 0 end

# 2) DEFINE listA TO BE A LIST OF 8 NUMBERS TO TEST...
# It should include the number from the inequality
# The inequality should produce TRUE for four numbers
# The inequality should produce FALSE for four numbers

listA = [list: -4, -3, -2.5, -1, 0, 1, 2, 6]

# 🌟Challenge yourself to DEFINE your list using 8 interesting numbers! (negatives, fractions, decimals, etc). For example: 
# listB = [list: -4.1, -3, -2, -1/2, 0, num-sqrt(2), 3.14, 4]

# 3) PLOT THE INEQUALITY AND THE LIST OF TEST POINTS ON A NUMBER LINE
# Numbers that are part of the solution will appear as green dots with a T
# Numbers that are *not* part of the solution will appear as red dots with an F
# All other numbers that are part of the solution will be shaded

inequality(less-than-zero, listA)

#Repeat the steps above for each inequality on the assignment.
