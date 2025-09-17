use context shared-gdrive("Bootstrap-DataScience-v2.1.arr", "10xjKNWI5k4kquuyAls91zaY2TxeX4taz")
# Load your spreadsheet and define your table
tooth-sheet = load-spreadsheet(
"https://docs.google.com/spreadsheets/d/1cg7AzSHBaF39eOCsUGnuBGqiJHhUjSvda18HD6FEKxk/edit?gid=0#gid=0")

# load the 'animals' sheet as a table
tooth-table = 
  load-table: name, num-teeth
    source: tooth-sheet.sheet-by-name("Sheet1", true)
end

