use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")
 
# FUNCTION REFRESHER 1:
# Use `maroon-square` to create a variety of differently sized maroon squares in the Interactions Area.

# CONTRACT
# maroon-square :: Number -> Image

# EXAMPLES
examples: 
  maroon-square(20) is square(20, "solid", "maroon")
  maroon-square(40) is square(40, "solid", "maroon")
  maroon-square(55) is square(55, "solid", "maroon")
end 

# DEFINITION
fun maroon-square(size) : square(size, "solid", "orange") end

#######################

#FUNCTION REFRESHER 2:

# Test out each of these defined values in the Interactions Area:
small-yt   = triangle(40, "solid", "yellow")
big-bt     = triangle(80, "solid", "cornflower-blue")
hello-text = text("hello", 100, "pink")

# Then test out what the `mystery` function does with each of these values.

# CONTRACT
# mystery :: Image -> Image

examples:
  mystery(small-yt) is 
  overlay(
    overlay(
      scale(0.5, rotate(45, small-yt)), 
      rectangle(90, 75, "solid", "purple")), 
    star(200, "solid", "teal")) 
    
  mystery(big-bt) is 
  overlay(
    overlay(
      scale(0.5, rotate(45, big-bt)), 
      rectangle(90, 75, "solid", "purple")), 
    star(200, "solid", "teal")) 
    
  mystery(hello-text) is 
  overlay(
    overlay(
      scale(0.5, rotate(45, hello-text)), 
      rectangle(90, 75, "solid", "purple")), 
    star(200, "solid", "teal")) 
end 
    
fun mystery(shape) :
  overlay(
    overlay(
      scale(0.5, rotate(45, shape)), 
      rectangle(90, 75, "solid", "purple")), 
    star(200, "solid", "teal")) 
end
  


