use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")

# Load your spreadsheet and define your table

dot-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1hrW07aaJ6JsBWSZeVWwiIeAgsntaR--d-NBOFNRezlo/")

# load the 'animals' sheet as a table
dot-table = 
  load-table: id, outlier, high, even
    source: dot-sheet.sheet-by-name("Sheet1", true)
end

dot-plot(dot-table,"id", "outlier")

dot-plot(dot-table,"id", "high")

dot-plot(dot-table,"id", "even")