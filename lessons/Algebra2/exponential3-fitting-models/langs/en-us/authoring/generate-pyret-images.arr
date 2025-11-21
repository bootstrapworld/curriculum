use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts
import data-source as DS

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

covid-url = "https://docs.google.com/spreadsheets/d/1GFWesAyYshYXDDSTxoHYmFrPVDTQd12rEVR-ZGn11hg/export?format=csv&gid=811606505"


###################### Load the data ##########################

# Define your table
covid-table = load-table: # NOTES ON COLUMNS:
  state,             # the state reporting the data
  day,              # number of days since 1/1/2020
  positive,          # TOTAL number of positive covid cases
  deaths             # TOTAL number of deaths due to covid
  source: csv.csv-table-url(covid-url, {
    header-row: true,
    infer-content: true
  })
  sanitize positive using DS.string-sanitizer
  sanitize deaths using DS.string-sanitizer
end

fun clean-commas(s :: String) -> Number:
  string-to-number(string-replace(s, ",", "")).or-else(-1)
end

shadow covid-table = transform covid-table using positive, deaths:
  positive: clean-commas(positive),
  deaths: clean-commas(deaths),
end

###################### Helper Functions ##########################
# is-MI :: Row -> Boolean
# consumes a Row, and checks if state == "MI"
fun is-MI(r): r["state"] == "MI" end

MI-table = filter(covid-table, is-MI)

padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

###################### Make some charts ##########################
MI-covid-chart = render-chart(from-list.scatter-plot(
        MI-table.column("day"),
        MI-table.column("positive")))
      .x-axis("day")
      .y-axis("positive")
      .y-min(100000)

###################### Save the images ##########################
I.save-image(add-padding(MI-covid-chart.get-image()), '../images/MI-covid-AUTOGEN.png')
