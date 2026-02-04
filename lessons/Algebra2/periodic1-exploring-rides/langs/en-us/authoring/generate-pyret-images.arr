use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

ride-url = "https://docs.google.com/spreadsheets/d/124VUjuGYJ92LuxRwXOqY61NARmOvg0y1ijjlQ1USaTk/export?format=csv&gid=1074439658"

###################### Load the data ##########################
# Define your table
ride-table = load-table: # List all of the columns in the table
  time,    # time in minutes
  altitude # feet above the ground
  source: csv.csv-table-url(ride-url, {
    header-row: true,
    infer-content: true
  })
end

padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

###################### Make some charts ##########################

ride-scatter-series = from-list.scatter-plot(
        ride-table.column("time"),
        ride-table.column("altitude"))
        .point-size(8)

ride-scatter-chart = render-chart(ride-scatter-series)
      .x-axis("time")
      .y-axis("altitude")
      .width(500)
      .height(400)

ride-combined-chart = render-charts(
  [list:
    from-list.line-plot(
      ride-table.column("time"),
      ride-table.column("altitude"))
      .point-size(8),
    ride-scatter-series
  ])
  .x-axis("time")
  .y-axis("altitude")
  .width(500)
  .height(400)


###################### Save the images ##########################
I.save-image(add-padding(ride-scatter-chart.get-image()), '../images/rides-scatter-plot-AUTOGEN.png')
I.save-image(add-padding(ride-combined-chart.get-image()), '../images/rides-combined-plot-AUTOGEN.png')
