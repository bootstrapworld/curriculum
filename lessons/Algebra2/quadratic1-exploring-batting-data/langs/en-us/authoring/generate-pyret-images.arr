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

###################### Make some charts ##########################

curve-angle-distance-image = scatter-plot(curve-table, "other-team", "bat-angle", "hit-distance")

all-angle-distance-chart = render-chart(from-list.scatter-plot(
        judge-table.column("bat-angle"),
        judge-table.column("hit-distance")))
      .x-axis("bat-angle")
      .y-axis("hit-distance")

all-angle-speed-chart = render-chart(from-list.scatter-plot(
        judge-table.column("bat-angle"),
        judge-table.column("hit-speed")))
      .x-axis("bat-angle")
      .y-axis("hit-speed")

all-pitchspeed-distance-chart = render-chart(from-list.scatter-plot(
        judge-table.column("pitch-speed"),
        judge-table.column("hit-distance")))
      .x-axis("bat-angle")
      .y-axis("hit-distance")

all-pitchspeed-speed-chart = render-chart(from-list.scatter-plot(
        judge-table.column("pitch-speed"),
        judge-table.column("hit-speed")))
      .x-axis("bat-angle")
      .y-axis("hit-speed")

fuel-efficiency-quadratic-chart = render-chart(from-list.scatter-plot(
        mpg-table.column("speed"),
        mpg-table.column("mpg")))
      .x-axis("speed")
      .y-axis("mpg")


###################### Save the images ##########################
I.save-image(add-padding(curve-angle-distance-image), '../images/curve-angle-distance-AUTOGEN.png')
I.save-image(add-padding(all-angle-distance-chart.get-image()), '../images/judge-angle-distance-AUTOGEN.png')
I.save-image(add-padding(all-angle-speed-chart.get-image()), '../images/judge-angle-distance-AUTOGEN.png')
I.save-image(add-padding(all-pitchspeed-distance-chart.get-image()), '../images/judge-pitchspeed-distance-AUTOGEN.png')
I.save-image(add-padding(all-pitchspeed-distance-chart.get-image()), '../images/judge-pitchspeed-speed-AUTOGEN.png')
I.save-image(add-padding(fuel-efficiency-quadratic-chart.get-image()), '../images/fuel-efficiency-quadratic-AUTOGEN.png')
