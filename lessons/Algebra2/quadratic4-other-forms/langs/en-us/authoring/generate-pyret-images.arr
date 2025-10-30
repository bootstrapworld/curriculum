use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

judge-url = "https://docs.google.com/spreadsheets/d/1TUbw1Jg-zrzIyoY-uCiliqJ3EwpurgWe0aQn0GSPAKQ/export?format=csv"

mpg-url = "https://docs.google.com/spreadsheets/d/1SLm1hDkVgAYxgh12dTD2Z3GXCUO9PrbwIZdqu9FiCGI/export?format=csv"

###################### Load the data ##########################
judge-table = load-table:
  id,            # identifier column
  year,          # year of game (2016 or 2017)
  game-date,     # full date of game
  other-team,    # abbreviated name of other team (e.g. NYY, TOR, etc)
  pitch-type,    # type of pitch (e.g. - fastball, cutter, etc)
  pitch-speed,   # speed of the pitch
  bat-angle,     # angle of Aaron's bat
  hit-distance,  # how many feet the hit traveled
  hit-speed,     # speed of the ball, off the bat
  bb-type        # ball type (e.g. - line drive, ground ball, etc)
  source: csv.csv-table-url(judge-url, {
    header-row: true,
    infer-content: true
  })
end

# Import the fuel efficiency dataset.
# Columns represent:
#   *test*  - the identifier of the fuel efficiency test
#   *model* - the car used in the test (A-F)
#   *speed* - the speed at which the car was tested (miles-per-hour)
#   *mpg*   - the miles-per-gallon the car achieved at that speed

mpg-table = load-table: test, model, speed, mpg
  source: csv.csv-table-url(mpg-url, {
    header-row: true,
    infer-content: true
  })
end

###################### Helper Functions ##########################
#########################################################
# Define a table of just the curve balls
fun is-curve(r) : r["pitch-type"] == "curveball" end
curve-table = filter(judge-table, is-curve)

# Define a table of just the 4 seam fast balls
fun is-four-seam(r) : r["pitch-type"] == "four-seam-fastball" end
fast4seam-table = filter(judge-table, is-four-seam)

# Define a table of just the 2 seam fast balls
fun is-two-seam(r) : r["pitch-type"] == "two-seam-fastball" end
fast2seam-table = filter(judge-table, is-two-seam)

# Define a table of just the sliders
fun is-slider(r) : r["pitch-type"] == "slider" end
sliders-table = filter(judge-table, is-slider)



padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

############## "AI" Charts #########################
vertex-15-100-img = make-noisy-scatter(lam(x): (-1 * sqr(x - 15)) + 100 end, 0, 30, 200)

factored-10-20-img = make-noisy-scatter(lam(x): (x - 10) * (x - 20) end, 0, 30, 200)

vertex-0-35-img = make-noisy-scatter(lam(x): sqr(x) + 35 end, -10, 10, 100)

factored-50-70-img = make-noisy-scatter(lam(x): -1 * (x - 50) * (x - 70) end, 45, 80, 200)

###################### Make some charts ##########################

curve-angle-distance-chart = render-chart(from-list.scatter-plot(
        curve-table.column("bat-angle"),
        curve-table.column("hit-distance"))
        .point-size(10))
      .x-axis("bat-angle")
      .y-axis("hit-distance")
      .y-min(50)

fuel-efficiency-quadratic-chart = render-chart(from-list.scatter-plot(
        mpg-table.column("speed"),
        mpg-table.column("mpg"))
        .point-size(10))
      .x-axis("speed")
      .y-axis("mpg")
      .x-min(14)
      .x-max(76)
      .y-min(20)


###################### Save the images ##########################
I.save-image(add-padding(curve-angle-distance-chart.get-image()), '../images/curve-angle-distance-AUTOGEN.png')
I.save-image(add-padding(fuel-efficiency-quadratic-chart.get-image()), '../images/fuel-efficiency-quadratic-AUTOGEN.png')
I.save-image(vertex-15-100-img,  '../images/vertex-15-100-AUTOGEN.png')
I.save-image(factored-10-20-img, '../images/factored-10-20-AUTOGEN.png')
I.save-image(vertex-0-35-img,    '../images/vertex-0-35-AUTOGEN.png')
I.save-image(factored-50-70-img, '../images/factored-50-70-AUTOGEN.png')
