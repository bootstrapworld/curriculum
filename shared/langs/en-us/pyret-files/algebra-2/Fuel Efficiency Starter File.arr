use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet and define your table
mpg-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1SLm1hDkVgAYxgh12dTD2Z3GXCUO9PrbwIZdqu9FiCGI/")

# Import the fuel efficiency dataset. 
# Columns represent:
#   *test*  - the identifier of the fuel efficiency test
#   *model* - the car used in the test (A-F)
#   *speed* - the speed at which the car was tested (miles-per-hour)
#   *mpg*   - the miles-per-gallon the car achieved at that speed

mpg-table = load-table: test, model, speed, mpg
  source: mpg-sheet.sheet-by-name("data", true)
end

######################################################### 
# Define some rows

A15 = row-n(mpg-table, 0)
A45 = row-n(mpg-table, 60)
A75 = row-n(mpg-table, 120)

######################################################### 
# Define some helper functions

# quad1 :: Number -> Number 
fun quad1(speed): (... * sqr(speed - ...)) + ... end