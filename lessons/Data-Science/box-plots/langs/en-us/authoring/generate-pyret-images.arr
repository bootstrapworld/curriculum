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

more-animals =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-file(lib-dir + "Extended-Animals-Dataset-1.5.1.csv", {
    header-row: true,
    infer-content: true
  })
end

###################### Build and filter ##########################
fun is-young(r): r["age"] < 1 end
fun is-cat(r): r["species"] == "cat" end
fun is-dog(r): r["species"] == "dog" end
fun is-lizard(r): r["species"] == "lizard" end
fun is-tarantula(r): r["species"] == "tarantula" end
fun is-rabbit(r): r["species"] == "rabbit" end



###################### Make some charts ##########################
box-plot-pounds = box-plot(animals-table, "pounds")



###################### Save the images ##########################
I.save-image(box-plot-pounds, '../images/box-plot-pounds-AUTOGEN.png')