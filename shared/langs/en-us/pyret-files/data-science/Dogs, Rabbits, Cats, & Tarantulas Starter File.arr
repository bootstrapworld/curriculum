use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")


# Load your spreadsheet and define your table
shelter-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1CsTAFDzOMXbhVznQcuekbyrPsH9CibReU0DYD71rv4M/edit?gid=41005267#gid=41005267")


# load the 'animals' sheet as a table
more-animals = load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("more", true)
end


# helper functions (these are needed to define the filtered tables, below)
fun is-cat(r): r["species"] == "cat" end
fun is-dog(r): r["species"] == "dog" end
fun is-tarantula(r): r["species"] == "tarantula" end
fun is-rabbit(r): r["species"] == "rabbit" end


# build tables that filter out individual species
cat-table = filter(more-animals, is-cat)
dog-table = filter(more-animals, is-dog)
tarantula-table = filter(more-animals, is-tarantula)
rabbit-table = filter(more-animals, is-rabbit)

# build dot-plots using this contract:
# dot-plot(Table, String, String) -> Image
