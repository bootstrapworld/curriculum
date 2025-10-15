use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

countries-url = "https://docs.google.com/spreadsheets/d/1QBLIQhhVfbOVJHqzmaebuP8Kc2VCIW-hFd0wV05a2MQ/export?format=csv"

covid-url = "https://docs.google.com/spreadsheets/d/1T73KS2IUU1kkG1SY4Ac7EU9Lj-ev1U9vzM_txSYcUhE/export?format=csv"


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

############## "AI" Charts #########################
fn_5logXplus10-img  = make-noisy-scatter(lam(x): (  5 * log(x)) + 10 end, 0.1,    10.1, 10)
fn_-50logX-20-img   = make-noisy-scatter(lam(x): (-50 * log(x)) - 20 end, 0.001,   0.101, 60)
fn_10log_x-10_-img  = make-noisy-scatter(lam(x): ( 10 * log(x - 10)) end, 10.001, 20.001, 30)
fn_-10logX-img      = make-noisy-scatter(lam(x): (-10 * log(x)) - 0  end, 0.001,  12.001, 10)

###################### Make some charts ##########################
chart = render-chart(from-list.scatter-plot(
        countries-table.column("pc-gdp"),
        countries-table.column("median-lifespan")))
      .x-axis("pc-gdp")
      .y-axis("median-lifespan")
      .y-min(50)

MA-covid-chart = render-chart(from-list.scatter-plot(
        MA-table.column("day"),
        MA-table.column("positive")))
      .x-axis("day")
      .y-axis("positive")
      .y-min(100000)

MA-covid-flipped-chart = render-chart(from-list.scatter-plot(
        MA-table.column("positive"),
        MA-table.column("day")))
      .x-axis("positive")
      .y-axis("day")
      .x-min(100000)

###################### Save the images ##########################
I.save-image(add-padding(chart.get-image()), '../images/wealth-health-AUTOGEN.png')
I.save-image(add-padding(MA-covid-chart.get-image()), '../images/MA-covid-AUTOGEN.png')
I.save-image(add-padding(MA-covid-flipped-chart.get-image()), '../images/MA-covid-flipped-AUTOGEN.png')


I.save-image(fn_5logXplus10-img, '../images/5log(x)+10.png')
I.save-image(fn_-50logX-20-img, '../images/-50log(x)-20.png')
I.save-image(fn_10log_x-10_-img, '../images/10log(x-10).png')
I.save-image(fn_-10logX-img, '../images/-10log(x).png')