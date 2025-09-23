use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet and define your table
states-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1D8FI9DeR-hGCZzCkjN3Ry7_moOfFSZTDN4QsOKpcTOI")

cheerios-table = load-table: id, day, cheerios-on-the-floor
  source: states-sheet.sheet-by-name("Sheet1", true)
end

#########################################################
# Define some models

fun f(x): 2 * x end
fun g(x): (0.5 * x) + 4 end

fit-model(cheerios-table, "id", "day", "cheerios-on-the-floor", f)
fit-model(cheerios-table, "id", "day", "cheerios-on-the-floor", g)