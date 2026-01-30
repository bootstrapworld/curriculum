use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I

points = [list: -5, -2.1, 0, 5, 10.2, 25/2, 15, 20]
points2 = [list: -1, 0, 1.6, 3, 5.2, 7, 8.1, 9]

intersection1 = and-intersection( lam(x): x > 5 end, lam(x): x <= 15 end, points )
intersection-ns = and-intersection( lam(x): x < 5 end, lam(x): x >= 15 end, points )
lt5orlte15 = or-union( lam(x): x < 5 end, lam(x): x <= 15 end, points )
union1 = or-union( lam(x): x < 5 end, lam(x): x >= 15 end, points )
union-infinite1 = or-union( lam(x): x > 5 end, lam(x): x <= 15 end, points )


lt3andgte7 = inequality(lam(x): (x > 3) and (x <= 7) end, points2)
lt3andgt7  = inequality(lam(x): (x < 3) and (x > 7) end, points2)
gt3andlt7  = inequality(lam(x): (x > 3) and (x < 7) end, points2)
gt3orlt7   = inequality(lam(x): (x > 3) and (x < 7) end, points2)
lt3orgte7  = inequality(lam(x): (x < 3) or (x >= 7) end, points2)


###################### Save the images ##########################
# images used in the lesson plan
I.save-image(intersection1,    '../images/intersection1-AUTOGEN.png')
I.save-image(intersection-ns,  '../images/intersection-ns-AUTOGEN.png')
I.save-image(lt5orlte15,       '../images/lt5orlte15-AUTOGEN.png')
I.save-image(union-infinite1,  '../images/union-infinite1-AUTOGEN.png')
I.save-image(union1,           '../images/union1-AUTOGEN.png')

# images used in compound-inequality-functions.adoc
I.save-image(lt3andgte7,       '../images/comp-ineq0-AUTOGEN.png')
I.save-image(lt3andgt7,        '../images/comp-ineq1-AUTOGEN.png')
I.save-image(gt3andlt7,        '../images/comp-ineq2-AUTOGEN.png')
I.save-image(gt3orlt7,         '../images/comp-ineq3-AUTOGEN.png')
I.save-image(lt3orgte7,        '../images/comp-ineq4-AUTOGEN.png')
