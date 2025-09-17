use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet
covid-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1T73KS2IUU1kkG1SY4Ac7EU9Lj-ev1U9vzM_txSYcUhE/")

# Define your table
covid-table = load-table: # NOTES ON COLUMNS:
  state,   # the state reporting the data
  day,     # the number of days after June 9th, 2020
  positive # the number of cumulative, positive COVID cases reported by a given day for that state
  source: covid-sheet.sheet-by-name("New England", true) 
end

# NOTE: New England is a region in the northeastern United States, comprising six states: Maine(ME), New Hampshire(NH), Vermont(VT), Massachusetts(MA), Rhode Island(RI), and Connecticut(CT).

######################################################### 
# Define some rows

CT1 = row-n(covid-table, 0)
MA1 = row-n(covid-table, 1)
ME1 = row-n(covid-table, 2)


######################################################### 
# Define some helper functions

# is-MA :: Row -> Boolean
# consumes a Row, and checks if state == "MA"
fun is-MA(r): r["state"] == "MA" end

######################################################### 
# Define some grouped and/or random samples

MA-table = filter(covid-table, is-MA)

######################################################### 
# Define some models

# linear : Number -> Number
# after completing the 'Linear Models' workbook page,
# change the function below to match the function from your lr-plot
fun linear(x):  (... * x) + ... end

# quadratic1 : Number -> Number
# after completing the 'Quadratic Models' workbook page,
# change the function below to be your first model
fun quadratic1(x):  (... * sqr(x - ...)) + ... end

# quadratic2 : Number -> Number
# after completing the 'Quadratic Models' workbook page,
# change the function below to be your second model
fun quadratic2(x):  (... * sqr(x - ...)) + ... end

# quadratic3 : Number -> Number
# after completing the 'Quadratic Models' workbook page,
# change the function below to be your third model
fun quadratic3(x):  (... * sqr(x - ...)) + ... end

# exponential : Number -> Number
# after completing the 'Exponential Models' workbook page,
# change the function below to be your first model
fun exponential(x):  (... * expt(..., (~1 * x))) + ... end
