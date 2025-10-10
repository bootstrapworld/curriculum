use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

covid-url = "https://docs.google.com/spreadsheets/d/1T73KS2IUU1kkG1SY4Ac7EU9Lj-ev1U9vzM_txSYcUhE/export?format=csv&gid=1838099611"


###################### Load the data ##########################

# Define your table
covid-table = load-table: # NOTES ON COLUMNS:
  state,   # the state reporting the data
  day,     # the number of days after June 9th, 2020
  positive # the number of cumulative, positive COVID cases reported by a given day for that state
  source: csv.csv-table-url(covid-url, {
    header-row: true,
    infer-content: true
  })
end

###################### Helper Functions ##########################
fun is-MA(r): r["state"] == "MA" end

MA-table = filter(covid-table, is-MA)

padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

###################### Make some charts ##########################
MA-covid-chart = render-chart(from-list.scatter-plot(
        MA-table.column("day"),
        MA-table.column("positive")))
      .x-axis("day")
      .y-axis("positive")
      .y-min(100000)

multiple-models-chart = render-chart(from-list.scatter-plot(
        covid-table.column("day"),
        covid-table.column("positive")))
      .x-axis("day")
      .y-axis("positive")

###################### Save the images ##########################
I.save-image(add-padding(MA-covid-chart.get-image()), '../images/MA-covid-AUTOGEN.png')

I.save-image(add-padding(multiple-models-chart.get-image()), '../images/multiple-models-AUTOGEN.png')
