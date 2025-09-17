use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

a = text("Waiting for you to add your function definitions!", 20, "green")

# This starter file accompanies the Design Recipe Telephone game from the Collaboration Lesson available at https://bootstrapworld.org/materials/. 

# Once you have defined functions g, h and r on the corresponding Design Recipe Pages, update the three function definitions in this starter file and an image will be revealed.


fun g(image) : a end
fun h(image) : a end
fun r(colors) : a end


# Do not changing any code below this line!
#############################################

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