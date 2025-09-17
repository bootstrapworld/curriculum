use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet
shelter-sheet = load-spreadsheet( "https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/")

# load the 'animals' sheet as a table
animals-table = load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("pets", true)
end

cat-row = row-n(animals-table,  0)
dog-row = row-n(animals-table, 10)

#########################################################
# Some Helper Functions

# is-dog :: (r :: Row) -> Boolean
# check if species is "dog"
examples:
  is-dog(cat-row) is cat-row["species"] == "dog"
  is-dog(dog-row) is dog-row["species"] == "dog"
end
fun is-dog(r): r["species"] == "dog" end

# is-cat :: (r :: Row) -> Boolean
# check if species is "cat"
examples:
  is-cat(cat-row) is cat-row["species"] == "cat"
  is-cat(dog-row) is dog-row["species"] == "cat"
end
fun is-cat(r): r["species"] == "cat" end

# is-young :: (r :: Row) -> Boolean
# check the age and see if it's less than or equal to 1
examples:
  is-young(cat-row) is cat-row["age"] <= 1
  is-young(dog-row) is dog-row["age"] <= 1
end
fun is-young(r): r["age"] <= 1
end

# is-old :: (r :: Row) -> Boolean
# check if age is more than 10
examples:
  is-old(cat-row) is cat-row["age"] > 10
  is-old(dog-row) is dog-row["age"] > 10
end
fun is-old(r): r["age"] > 10 end

# get-name :: (r :: Row) -> String
# look up the name value
examples:
  get-name(cat-row) is cat-row["name"]
  get-name(dog-row) is dog-row["name"]
end
fun get-name(r): r["name"] end

# is-fixed :: (r :: Row) -> Boolean
# look up the fixed value
examples:
  is-fixed(cat-row) is cat-row["fixed"]
  is-fixed(dog-row) is dog-row["fixed"]
end
fun is-fixed(r): r["fixed"] end

# label :: (r :: Row) -> Image
# use the name value to draw the letters in red
examples:
  label(cat-row) is text(cat-row["name"], 20, "red")
  label(dog-row) is text(dog-row["name"], 20, "red")
end
fun label(r): text(r["name"], 20, "red") end

# kilos :: (r :: Row) -> Number
# divide pounds by 2.2 to convert to kilos
examples:
  kilos(cat-row) is cat-row["pounds"] / 2.2
  kilos(dog-row) is dog-row["pounds"] / 2.2
end
fun kilos(r): r["pounds"] / 2.2 end
