use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")
#########################################################
# Load your spreadsheet and define your table
MY-SHEET = load-spreadsheet("ADDRESS-OF-YOUR-GOOGLE-SHEET")

MY-TABLE = load-table: ALL, YOUR, COLUMNS
  source: MY-SHEET.sheet-by-name("data", true)
end


######################################################### 
# Define some rows
MY-SAMPLE-ROW = row-n(MY-TABLE, 0)




######################################################### 
# Define some helper functions




######################################################### 
# Define random and logical subsets


