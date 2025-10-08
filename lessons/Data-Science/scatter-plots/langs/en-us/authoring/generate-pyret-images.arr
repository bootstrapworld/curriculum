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
scatter-plot-age-weeks = scatter-plot(animals-table , "name", "age", "weeks")
scatter-plot-pounds-weeks = scatter-plot(animals-table , "name", "pounds", "weeks")

###################### Save the images ##########################
I.save-image(scatter-plot-age-weeks, '../images/age-v-weeks-AUTOGEN.png')
I.save-image(scatter-plot-pounds-weeks, '../images/pounds-v-weeks-AUTOGEN.png')
