use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

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
#########################################################
# Some images to use, scaled to useful sizes
dog-img    = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/dog.png"))
cat-img    = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/cat.png"))
rabbit-img = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/rabbit.png"))
lizard-img = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/lizard.png"))
spider-img = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/spider.png"))
snail-img  = scale(0.3, image-url("https://www.bootstrapworld.org/clipart/Animals/snail.png"))

#########################################################
# Define some helper functions

# animal-img :: (r :: Row) -> Image
fun animal-img(r):
  if      (r["species"] == "dog"):       dog-img
  else if (r["species"] == "cat"):       cat-img
  else if (r["species"] == "rabbit"):    rabbit-img
  else if (r["species"] == "tarantula"): spider-img
  else if (r["species"] == "lizard"):    lizard-img
  else if (r["species"] == "snail"):     snail-img
  end
end



###################### Make some charts ##########################
scatter-plot-pounds-weeks = scatter-plot(animals-table , "name", "pounds", "weeks")
age-v-weeks-species-dot = image-scatter-plot(animals-table, "age", "weeks", animal-img)

###################### Save the images ##########################
I.save-image(scatter-plot-pounds-weeks, '../images/pyret/scatter-plot-AUTOGEN.png')
I.save-image(age-v-weeks-species-dot, '../images/pyret/image-scatter-plot-AUTOGEN.png')
