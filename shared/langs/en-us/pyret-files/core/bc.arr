use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# CONTRACT
# gt :: Number -> Image

examples:
  gt(10) is triangle(10, "solid", "green")
  gt(20) is triangle(20, "solid", "green")
  gt(30) is triangle(30, "solid", "green")
  gt(40) is triangle(40, "solid", "green")
  gt(50) is triangle(50, "solid", "green")
end

fun gt(size): triangle(size, "solid", "green") end