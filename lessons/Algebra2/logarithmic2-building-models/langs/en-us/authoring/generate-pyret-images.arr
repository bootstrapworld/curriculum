use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts
import data-source as DS

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

countries-url = "https://docs.google.com/spreadsheets/d/1QBLIQhhVfbOVJHqzmaebuP8Kc2VCIW-hFd0wV05a2MQ/export?format=csv"

covid-url = "https://docs.google.com/spreadsheets/d/1GFWesAyYshYXDDSTxoHYmFrPVDTQd12rEVR-ZGn11hg/export?format=csv&gid=811606505"


###################### Load the data ##########################

# Define your table
countries-table = load-table: # List all of the columns in your table
  country,             # e.g. Mexico
  continent,           # e.g. North America
  has-univ-healthcare, # True if the country provides health care for its citizens
  median-lifespan,     # How long people in the country are expected to live
  gdp,                 # Gross Domestic Product - The amount of money the country makes                                        #### Note: GDP is measured in THOUSANDS of US dollars!
  population,          # Number of people living in the country
  pc-gdp               # GDP per capita (per person) in US dollars
  source: csv.csv-table-url(countries-url, {
    header-row: true,
    infer-content: true
  })
end

# Define your table
covid-table = load-table: # NOTES ON COLUMNS:
  state,             # the state reporting the data
  day,               # number of days since 1/1/2020
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
    square(padding, "solid", "white"))
end

############## "AI" Charts #########################
fn_5logXplus10  = make-noisy-scatter-chart(lam(x): (  5 * log(x)) + 10 end, 0.1,    10.1, 10)
fn_-50logX-20   = make-noisy-scatter-chart(lam(x): (-50 * log(x)) - 20 end, 0.001,   5, 60)
fn_10log_x-10_  = make-noisy-scatter-chart(lam(x): ( 10 * log(x - 10)) end, 0.001, 20.001, 30)
fn_-10logX      = make-noisy-scatter-chart(lam(x): (-10 * log(x)) - 0  end, 0.001,  12.001, 10)

###################### Make some charts ##########################
chart = render-chart(from-list.scatter-plot(
        countries-table.column("pc-gdp"),
        countries-table.column("median-lifespan")))
      .x-axis("pc-gdp")
      .y-axis("median-lifespan")
      .y-min(50)

MI-covid-chart = render-chart(from-list.scatter-plot(
        MI-table.column("day"),
        MI-table.column("positive")))
      .x-axis("day")
      .y-axis("positive")
      .y-min(0)

MI-covid-flipped-chart = render-chart(from-list.scatter-plot(
        MI-table.column("positive"),
        MI-table.column("day")))
      .x-axis("positive")
      .y-axis("day")
      .x-min(-40000)
      .y-min(0)

###################### Save the images ##########################
I.save-image(add-padding(chart.get-image()), '../images/wealth-health-AUTOGEN.png')
I.save-image(add-padding(MI-covid-chart.get-image()), '../images/MI-covid-AUTOGEN.png')
I.save-image(add-padding(MI-covid-flipped-chart.get-image()), '../images/MI-covid-flipped-AUTOGEN.png')

#|
I.save-image(fn_5logXplus10.get-image(), '../images/5log(x)+10-AUTOGEN.png')
I.save-image(fn_-50logX-20.get-image(),  '../images/-50log(x)-20-AUTOGEN.png')
I.save-image(fn_10log_x-10_.get-image(), '../images/10log(x-10)-AUTOGEN.png')
I.save-image(fn_-10logX.get-image(),     '../images/-10log(x)-AUTOGEN.png')
|#