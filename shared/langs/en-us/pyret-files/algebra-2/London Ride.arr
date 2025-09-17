use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet and define your table
ride-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/124VUjuGYJ92LuxRwXOqY61NARmOvg0y1ijjlQ1USaTk/edit#gid=155278431")

# Define your table
ride-table = load-table: # List all of the columns in the table
  sample,  # identifier for the row of data
  time,    # time in minutes
  altitude # feet above the ground
  source: ride-sheet.sheet-by-name("data", true)
end

######################################################### 
# Define your models here

# f : Number -> Number
# after completing "Modeling the Ferris Wheel Data"
# define your sine-using model here
fun f(x): (... * sin(... * (x - ...))) + ... end

# g : Number -> Number
# after completing "Modeling the Ferris Wheel Data"
# define your cosine-using model here
fun g(x): (... * cos(... * (x - ...))) + ... end
