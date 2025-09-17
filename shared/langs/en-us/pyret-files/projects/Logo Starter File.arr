use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

# Below are three logos created by students. Click "Run," and then test the logos out one at a time by typing each logo's name into the Interactions area and hitting enter.

sample-logo-1 = 
  overlay(star(20, "solid", "royal-blue"),
    overlay(star(40, "solid", "dodger-blue"),
      overlay(star(60, "solid", "deep-sky-blue"), 
        overlay(star(80, "solid", "cornflower-blue"),
          overlay(rotate(36,star(50, "solid", "dark-red")),
            overlay(rotate(36,star(70, "solid", "fire-brick")),
              overlay(rotate(36,star(90, "solid", "crimson")),
                circle(80, "solid", "black"))))))))
         

sample-logo-2 = 
  overlay(text("JoseCarlos", 25, "gold"), 
  overlay(radial-star(700, 100, 5, "solid", "black"), 
  overlay(rotate(360, radial-star(50, 10, 40, "solid", "sea-green")),
  overlay(rotate(230, regular-polygon(100, 5, "solid", "ivory")), 
  overlay(rotate(230, regular-polygon(100, 5, "solid", "sea-green")), 
  overlay(rotate(60, regular-polygon(100, 5, "solid", "ivory")), 
  overlay(rotate(200, regular-polygon(100, 5, "solid", "sea-green")), 
  overlay(rotate(190, regular-polygon(100, 5, "solid", "ivory")), 
  overlay(rotate(110, regular-polygon(100, 5, "solid", "sea-green")), 
  overlay(rotate(90, regular-polygon(100, 5, "solid", "ivory")), 
  regular-polygon(100, 5, "solid", "sea-green")))))))))))


sample-logo-3 = 
  beside(text("my flower", 50, "blue"), 
    overlay(circle(20, "outline", "white"),
          overlay(rotate(300, ellipse(50, 100, "solid", "blue")),
            overlay(rotate(90, ellipse(50, 100, "solid", "blue")), 
              overlay(rotate(45, ellipse(50, 100, "solid", "blue")),
                ellipse(50, 100, "solid", "blue"))))))




