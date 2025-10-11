use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

animals-url = "https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/export?format=csv"


###################### Load the data ##########################
animals-table =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-url(animals-url, {
    header-row: true,
    infer-content: true
  })
end


###################### Build and filter ##########################
fun age-dot(r): circle(10 * r["age"], "solid", "blue") end


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


fun tag(r): text(r["species"], 15, "red") end

###################### Make some charts ##########################
age-bc = image-scatter-plot(animals-table , "pounds", "weeks", age-dot)
age-v-weeks-species-dot = image-scatter-plot(animals-table, "age", "weeks", animal-img)
age-v-weeks = scatter-plot(animals-table, "name", "age", "weeks")
pounds-v-weeks = scatter-plot(animals-table, "name", "pounds", "weeks")
#species-tag = image-scatter-plot(animals-table, "pounds", "weeks", tag)

###################### Save the images ##########################
I.save-image(age-bc, '../images/age-bc-AUTOGEN.png')
I.save-image(age-v-weeks-species-dot, '../images/age-v-weeks-species-dot-AUTOGEN.png')
I.save-image(age-bc, '../images/pounds-v-weeks-AUTOGEN.png')
#I.save-image(species-tag, '../images/species-tag-AUTOGEN.png')
