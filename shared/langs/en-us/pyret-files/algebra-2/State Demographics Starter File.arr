use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet and define your table
states-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1XSkaypCN_QoWQ89Lo3xVuobLqV-e0DbYZg-ewzhgrzE")

# Define your table
states-table = load-table: # Here's a list of every column in the table!
  state, region,           # state name & region of the US
  pop-2010, pop-2020,      # population of each state in 2010 and 2020
  pop-trend,               # whether the population increased or decreased in that 10-year span
  pct-college-or-higher,   # attended college as percentage of the population
  pct-hs-or-higher,        # HS graduates as percentage of the population
  pct-home-owners,         # percent of the population that own their homes
  num-households,          # number of households (a collection of people who live together) 
  num-housing-units,       # number of apartments/houses available to house people
  land-area,               # number of square miles in the state
  pct-non-english-at-home, # percent who speak a language other than English at home
  mean-commute-time,       # minutes spent driving to work
  median-income,           # median household income
  per-capita-income,       # income per person
  veterans,                # number of veterans in the state
  pct-veterans,            # veterans as a percent of the over-18 population
  pct-female,              # percent of the population that identify as female
  pct-older-65,            # percent of the population over 65 years old
  pct-under-18,            # percent of the population under 18 years old
  pct-under-5,             # percent of the population under 5 years old
  pct-in-poverty,          # percent living in poverty
  poverty-rate             # poverty rate (low, medium or high)
  source: states-sheet.sheet-by-name("states", true)
end

# Note: Aside from pop-2010, pop-2020, and "pop-trend", all of the columns in this table use summary data summarized in 2015

######################################################### 
# Define some rows
alabama = row-n(states-table, 0)
alaska  = row-n(states-table, 1)




#########################################################
#Define a model using Alabama(AL) and Alaska(AK)
fun al-ak(x): ... x end

# To see how this model fits the data: 
# fit-model(states-table, "state", "pct-college-or-higher", "median-income", al-ak)

######################################################### 
# The Michigan and California model is shown below
fun mi-ca(x):       (2642 * x) + -20024 end

# Define some other linear models by changing the "..."s 
fun less-steep(x):  (... * x)  +  ...   end
fun negative(x):    (... * x)  +  ...   end
fun horizontal(x):  (... * x)  +  ...   end

######################################################### 
# Define a model using MA and NV
fun ma-nv(x):       (... * x)  +  ...   end
fun other(x):       (... * x)  +  ...   end
fun best(x):        (... * x)  +  ...   end

