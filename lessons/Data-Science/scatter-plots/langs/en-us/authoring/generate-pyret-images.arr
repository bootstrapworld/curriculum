use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

animals-url = "https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/export?format=csv"

more-animals-url = "https://docs.google.com/spreadsheets/d/1CsTAFDzOMXbhVznQcuekbyrPsH9CibReU0DYD71rv4M/export?format=csv&gid=41005267"

###################### Load the data ##########################
animals-table =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-url(animals-url, {
    header-row: true,
    infer-content: true
  })
end


###################### Make some charts ##########################
scatter-plot-age-weeks = scatter-plot(animals-table , "name", "age", "weeks")
scatter-plot-pounds-weeks = scatter-plot(animals-table , "name", "pounds", "weeks")

###################### Save the images ##########################
I.save-image(scatter-plot-age-weeks, '../images/age-v-weeks-AUTOGEN.png')
I.save-image(scatter-plot-pounds-weeks, '../images/pounds-v-weeks-AUTOGEN.png')
