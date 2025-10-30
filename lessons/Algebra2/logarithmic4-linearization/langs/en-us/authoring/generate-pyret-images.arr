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
fun logarithmic3(x): ( 11.9012 * log(x)) + 24.2636 end
fun g(r): log(r["pc-gdp"]) end

# build a new table, adding a column by transforming pc-gdp-in-thousands
countries-transformed = build-column(countries-table, "log(pc-gdp)", g)

###################### Make some charts ##########################
log-model-img = fit-model(countries-table, "country", "pc-gdp", "median-lifespan", logarithmic3)
lr-plot-transformed-img = lr-plot(countries-transformed, "country", "log(pc-gdp)", "median-lifespan")

###################### Save the images ##########################
I.save-image(log-model-img, '../images/logarithmic-model-AUTOGEN.png')
I.save-image(lr-plot-transformed-img, '../images/lr-plot-transformed-AUTOGEN.png')
