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
subset-table = filter(animals-table, lam(r): is-rabbit(r) or is-dog(r) or is-cat(r) end)
subset-table2 = filter(more-animals, lam(r): is-rabbit(r) or is-lizard(r) or is-tarantula(r) end)



###################### Make some charts ##########################
bar-species = bar-chart(more-animals , "species")
multi-bar-species-sex = multi-bar-chart(more-animals, "species", "sex")
multi-bar-species-sex2 = multi-bar-chart(subset-table, "species", "sex")
stacked-bar-species-sex = stacked-bar-chart(more-animals, "species", "sex")
stacked-bar-species-sex2 = stacked-bar-chart(subset-table2, "species", "sex")



###################### Save the images ##########################
I.save-image(bar-species, '../images/bar-more-species.png')
I.save-image(multi-bar-species-sex, '../images/multi-bar-species-sex-AUTOGEN.png')
I.save-image(multi-bar-species-sex, '../images/multi-bar-species-sex-AUTOGEN.png')
I.save-image(multi-bar-species-sex2, '../images/multi-species-sex2-AUTOGEN.png')
I.save-image(stacked-bar-species-sex, '../images/stacked-species-sex-AUTOGEN.png')
I.save-image(stacked-bar-species-sex2, '../images/stacked-species-sex2-AUTOGEN.png')

