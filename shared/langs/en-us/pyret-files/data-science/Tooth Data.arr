use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet and define your table
tooth-sheet = load-spreadsheet(
"https://docs.google.com/spreadsheets/d/1cg7AzSHBaF39eOCsUGnuBGqiJHhUjSvda18HD6FEKxk/edit?gid=0#gid=0")

# load the 'animals' sheet as a table
tooth-table = 
  load-table: name, num-teeth
    source: tooth-sheet.sheet-by-name("Sheet1", true)
end

