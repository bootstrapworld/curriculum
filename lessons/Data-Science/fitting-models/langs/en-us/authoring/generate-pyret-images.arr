use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end


lizard-url = "https://docs.google.com/spreadsheets/d/1CsTAFDzOMXbhVznQcuekbyrPsH9CibReU0DYD71rv4M/export?format=csv"

###################### Load the data ##########################
# Define your table
lizard-sample =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-url(lizard-url, {
    header-row: true,
    infer-content: true
  })
end

fun cy(x): (-3 * x) + 23 end
fun jo(x): (-0.8 * x) + 10.4 end


############## "AI" Charts #########################
cy-img  = fit-model(lizard-sample, "name", "pounds", "weeks", cy)
jo-img  = fit-model(lizard-sample, "name", "pounds", "weeks", jo)

###################### Save the images ##########################
I.save-image(cy-img,       '../images/fit-jo-crop-AUTOGEN.png')
I.save-image(cy-img,       '../images/fit-cy-crop-AUTOGEN.png')
