use context shared-gdrive("pr teachpak v1.8.arr", "1J0ibRJYslMDGIitFyAyI9DQoCXDuRP22")

#1) Define the parts. These will be used with both function composition and layering.

background = rectangle(300, 200, "outline", "black")
rrectangle = rectangle(300, 200/5, "solid", "red")
btriangle = rotate(30, triangle(200, "solid", "blue"))
wstar = star(45, "solid", "white")

#2) Define puerto-rico-2 using layers.
 
step1 = put-image(rrectangle, 
  150, 20, 
  background)

step2 = put-image(rrectangle, 
  150, 100, 
  step1)

step3 = put-image(rrectangle, 
  150, 180, 
  step2)

step4 = put-image(btriangle, 
  85, 100, 
  step3)

step5 = put-image(wstar, 
  65, 100, 
  step4)

puerto-rico-2 = step5
