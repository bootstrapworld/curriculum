use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet and define your table
shelter-sheet = load-spreadsheet(
"https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/")

# load the 'animals' sheet as a table
animals-table = load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("pets", true)
end


########################################################
# Define some rows
cat-row       =   row-n(animals-table,  0)
dog-row       =   row-n(animals-table, 10)
lizard-row    =   row-n(animals-table, 22)
rabbit-row    =   row-n(animals-table, 24)
young-row     =   row-n(animals-table,  8)
old-row       =   row-n(animals-table,  4)
fixed-row     =   row-n(animals-table,  3)
unfixed-row   =   row-n(animals-table,  0)
female-row    =   row-n(animals-table,  2)
male-row      =   row-n(animals-table,  9)
hermaphrodite-row=row-n(animals-table,  6)



########################################################
# Define some helper functions

# CONTRACT:
# age-gt :: Row -> Image

# consumes an animal, and draws a solid green triangle whose 
# size is 5x the number age of the animal as the size

# EXAMPLES:
examples:
  age-gt(cat-row) is triangle(5 *          1,     "solid", "green")
  age-gt(dog-row) is triangle(5 *          3,     "solid", "green")
  
  age-gt(cat-row) is triangle(5 * cat-row["age"], "solid", "green")
  age-gt(dog-row) is triangle(5 * dog-row["age"], "solid", "green")
end

# DEFINITION: 
fun age-gt(r):       triangle(5 *       r["age"], "solid", "green") end
