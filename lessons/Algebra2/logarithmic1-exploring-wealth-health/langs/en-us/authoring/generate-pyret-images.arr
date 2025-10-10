use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

countries-url = "https://docs.google.com/spreadsheets/d/1QBLIQhhVfbOVJHqzmaebuP8Kc2VCIW-hFd0wV05a2MQ/export?format=csv"


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

###################### Helper Functions ##########################
padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

###################### Make some charts ##########################
chart = render-chart(from-list.scatter-plot(
        countries-table.column("pc-gdp"),
        countries-table.column("median-lifespan")))
      .x-axis("pc-gdp")
      .y-axis("median-lifespan")
      .y-min(50)

###################### Save the images ##########################
I.save-image(add-padding(chart.get-image()), '../images/scatter-plot-pcgdp-lifespan-AUTOGEN.png')
