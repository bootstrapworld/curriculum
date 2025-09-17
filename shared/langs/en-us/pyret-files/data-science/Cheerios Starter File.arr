use context shared-gdrive("Bootstrap-DataScience-v2.2.arr", "1cuqucVgUe7_HmtVWez1qkkdPH16mgy7P")
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