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
bar-chart-species = bar-chart(animals-table , "species")
pie-chart-species = pie-chart(animals-table , "species")
box-plot-age = box-plot(animals-table , "age")
dot-plot-age = dot-plot(animals-table , "name", "age")
histogram-pounds = histogram(animals-table , "name", "pounds", 5)
lr-plot-pounds-age = lr-plot(animals-table , "name", "pounds", "age")
scatter-plot-pounds-weeks = scatter-plot(animals-table , "name", "pounds", "weeks")

###################### Save the images ##########################
I.save-image(bar-chart-species, '../images/bar-chart-AUTOGEN.png')
I.save-image(pie-chart-species, '../images/pie-chart-AUTOGEN.png')
I.save-image(dot-plot-age, '../images/dot-plot-AUTOGEN.png')
I.save-image(box-plot-age, '../images/box-plot-AUTOGEN.png')
I.save-image(histogram-pounds, '../images/histogram-AUTOGEN.png')
I.save-image(lr-plot-pounds-age, '../images/lr-plot-pounds-age-AUTOGEN.png')
I.save-image(scatter-plot-pounds-weeks, '../images/scatter-plot-pounds-weeks-AUTOGEN.png')
