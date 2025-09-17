use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet 
countries-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1QBLIQhhVfbOVJHqzmaebuP8Kc2VCIW-hFd0wV05a2MQ/")

# Define your table
countries-table = load-table: # List all of the columns in your table
  country,             # e.g. Mexico
  continent,           # e.g. North America
  has-univ-healthcare, # True if the country provides health care for its citizens
  median-lifespan,     # How long people in the country are expected to live
  gdp,                 # Gross Domestic Product - The amount of money the country makes                                        #### Note: GDP is measured in THOUSANDS of US dollars!
  population,          # Number of people living in the country
  pc-gdp               # GDP per capita (per person) in US dollars
  source: countries-sheet.sheet-by-name("2019", true)
end

######################################################### 
# Define some rows

afghanistan = row-n(countries-table, 0)
albania     = row-n(countries-table, 1)

######################################################### 
# Define some models

# linear : Number -> Number
# change the function below to be your best linear model
fun linear(x):  (0.00021 * x) + 68.0126 end

#EXPERIMENT WITH THE SLIDERS IN YOUR DESMOS FILE TO FIND THE BEST MODELS

# quadratic : Number -> Number
# change the function below to be your best quadratic model
fun quadratic(x):  (... * sqr(x - ...)) + ... end

# exponential : Number -> Number
# change the function below to be your best exponential model
fun exponential(x):  (... * expt(... , (~1 * x))) + ... end

#########################################################
# Define some more Models by filling in "..."

# logarithmic : Number -> Number
# change the function below to be your logarithmic model
fun logarithmic(x):  (... * log(x)) + ... end

# logarithmic : Number -> Number
# change the function below to be your best logarithmic model after "Scaling the Axis"
fun logarithmic2(x): (... * log(x)) + ... end

# logarithmic : Number -> Number
# change the function below after "Transforming the Data"
fun logarithmic3(x): (... * log(x)) + ... end

#########################################################
# Define a transformation function g(r), 
# which takes the log of a row's pc-gdp column

# g :: Row -> Number
# Consumes a Row for a country, and produces the log of the pc-gdp
fun g(r): log(r["pc-gdp"]) end

# build a new table, adding a column by transforming pc-gdp-in-thousands
countries-transformed = build-column(countries-table, "log(pc-gdp)", g)

