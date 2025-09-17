use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# We are going to be exploring compound inequalities today. 
# Read the example code below carefully!
# And click run to see what happens.

# WE'VE DEFINED 2 BOOLEAN-PRODUCING FUNCTIONS (You will define more later)
fun B(x): x > 5 end
fun C(x): x <= 15 end

# NEXT WE'LL GRAPH EACH OF THEM ON A NUMBER LINE AS SEPARATE INEQUALITIES AND TEST 8 VALUES IN EACH
inequality(B, [list: -5, -2.1, 0, 5, 10.2, 12, 15, 20])
inequality(C, [list: -5, -2.1, 0, 15, 17, 18, 19, 20])

# Numbers that are part of the solution will appear as green dots
# Numbers are *not* part of the solution will appear as red dots
# All other numbers will be shaded if they are part of the solution

# AND THEN WE'LL CONSIDER THE INEQUALITIES TOGETHER

# TEST THEIR INTERSECTION (Which inputs make both of the expressions true?)
# and-intersection:: Function, Function, List -> Image
and-intersection( B, C, [list: -5, -2.1, 0, 5, 10, 39/5, 15, 20] )

# TEST THEIR UNION (Which inputs make at least one of the expressions true?)
# or-union:: Function, Function, List -> Image
or-union( B, C, [list: -5, -2.1, 0, 5, 10, 12, 15, 20] )

