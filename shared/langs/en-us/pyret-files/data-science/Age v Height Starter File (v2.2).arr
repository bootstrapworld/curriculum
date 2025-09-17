use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

# Load your spreadsheet and define your table
h-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1XmmpisScAf2JjaVEDFztwbx3-X_mQGVcQnpZakcSQvU/")

h-table = load-table: id, age, gender-id, prediction, height, height-cm
  source: h-sheet.sheet-by-name("Authoring", true)
end

#########################################################
# Some useful helper functions
fun dot(r): 
  if      (r["gender-id"] == "f"): star(12, "solid", "red")
  else if (r["gender-id"] == "m"): circle(6, "solid", "blue")
  else if (r["gender-id"] == "nb"): square(12, "solid", "purple")
  end
end

fun is-f(r): (r["gender-id"] == "f") end

fun is-m(r): (r["gender-id"] == "m") end

######################################################### 
# Here are some functions for you to try!

#1) How do growth rates compare by gender identity? 

# image-scatter-plot(h-table, "age", "height", dot)


#2) Dig deeper with regressions.

# lr-plot(filter(h-table, is-f), "gender-id", "age", "height")

# lr-plot(filter(h-table, is-m), "gender-id", "age", "height")