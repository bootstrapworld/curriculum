use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet and define your table
shelter-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1CsTAFDzOMXbhVznQcuekbyrPsH9CibReU0DYD71rv4M/")

# load the 'lizard-sample' sheet as a table
lizard-sample = 
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("lizard-sample", true)
end



########################################################
# Define some models
fun cy(x): (-3 * x) + 23 end
fun jo(x): (-0.8 * x) + 10.4 end

# Fit some models
# fit-model(lizard-sample, "name", "pounds", "weeks", cy)
# fit-model(lizard-sample, "name", "pounds", "weeks", jo)