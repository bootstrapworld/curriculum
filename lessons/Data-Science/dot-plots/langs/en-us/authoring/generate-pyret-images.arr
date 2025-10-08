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

cats      = filter(more-animals, is-cat)
rabbits   = filter(more-animals, is-rabbit)
dogs      = filter(more-animals, is-dog)
lizards   = filter(more-animals, is-lizard)
tarantulas= filter(more-animals, is-tarantula)

###################### Make some charts ##########################
cat-pounds    = dot-plot(cats, "name", "pounds")
dog-pounds  = dot-plot(dogs, "name", "pounds")
weeks       = dot-plot(animals-table, "name", "weeks")
rabbit-pounds = dot-plot(rabbits, "name", "pounds")
tarantula-pounds = dot-plot(tarantulas, "name", "pounds")

###################### Save the images ##########################
I.save-image(cat-pounds, '../images/cat-dot-plot-AUTOGEN.png')
I.save-image(dog-pounds, '../images/dog-dot-plot-AUTOGEN.png')
I.save-image(weeks, '../images/dot-plot-weeks-AUTOGEN.png')
I.save-image(rabbit-pounds, '../images/rabbit-dot-plot-AUTOGEN.png')
I.save-image(tarantula-pounds, '../images/tarantula-dot-plot-AUTOGEN.png')