use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end


# the location of the lib directory, relative to the authoring folder of this lesson
# for most lessons, this will be 6 ancestors up. For CODAP lessons it'll be 7.
lib-dir = '../../../../../../lib/pyret-support/'

###################### Load the data ##########################
animals-table =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-file(lib-dir + "Animals-Dataset-1.5.1.csv", {
    header-row: true,
    infer-content: true
  })
end


###################### Make some charts ##########################
bar-chart-species = bar-chart(animals-table , "species")
pie-chart-species = pie-chart(animals-table , "species")
box-plot-age = box-plot(animals-table , "age")
#dot-plot-age = dot-plot(animals-table , "age")
histogram-pounds = histogram(animals-table , "name", "pounds", 5)
lr-plot-pounds-age = lr-plot(animals-table , "name", "pounds", "age")
scatter-plot-pounds-weeks = scatter-plot(animals-table , "name", "pounds", "weeks")

###################### Save the images ##########################
I.save-image(bar-chart-species, '../images/bar-chart-AUTOGEN.png')
I.save-image(pie-chart-species, '../images/pie-chart-AUTOGEN.png')
#I.save-image(dot-plot-age, '../images/dot-plot-AUTOGEN.png')
I.save-image(box-plot-age, '../images/box-plot-AUTOGEN.png')
I.save-image(histogram-pounds, '../images/histogram-AUTOGEN.png')
I.save-image(lr-plot-pounds-age, '../images/lr-plot-pounds-age-AUTOGEN.png')
I.save-image(scatter-plot-pounds-weeks, '../images/scatter-plot-pounds-weeks-AUTOGEN.png')
