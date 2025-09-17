use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Word Problem 1: 
# Define a function g that takes in an image, h, and returns a scaled down version of that image that is 37.5% of the original size.

# Word Problem 2:
# Define a function g that take in an image, k, and rotates it 36 degrees to the right.

# Word Problem 3: 
# Define a function r(color) that takes in a color and returns a solid 5-sided regular polygon of size 300 in the given color. 

fun g(image) : scale(0.375, image) end
fun h(image) : rotate(36, image) end
fun r(colors) : regular-polygon(300,5, "solid", colors) end

f = star-polygon(300,5,2,"outline", "yellow")
l = h(g(f))
m = h(g(l))
n = h(g(m))
t = r("purple")
q = h(g(r("blue")))
x = g(g(r("dark green")))
s = h(g(g(g(r("green")))))

overlay(n, 
    overlay(s, 
      overlay(m, 
      overlay(x, 
          overlay(l, 
            overlay(q, 
              overlay(f, t)))))))