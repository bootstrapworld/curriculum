use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet and define your table
shelter-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1CsTAFDzOMXbhVznQcuekbyrPsH9CibReU0DYD71rv4M/edit?gid=41005267#gid=41005267")

# load the 'animals' sheet as a table
more-animals = load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("more", true)
end



########################################################
# Define some rows
cat-row = row-n(more-animals,  318)
dog-row = row-n(more-animals,  371)




########################################################
# Define some helper functions


fun is-young(r): r["age"] < 1 end 

fun is-cat(r): r["species"] == "cat" end
cat-table = filter(more-animals, is-cat)

kitten-table = filter(cat-table, is-young)

fun is-dog(r): r["species"] == "dog" end
dog-table = filter(more-animals, is-dog)

puppy-table = filter(dog-table, is-young)

fun is-tarantula(r): r["species"] == "tarantula" end

spiderling-table = filter(more-animals, is-young)



fun is-rabbit(r): r["species"] == "rabbit" end
rabbit-table = filter(more-animals, is-rabbit)