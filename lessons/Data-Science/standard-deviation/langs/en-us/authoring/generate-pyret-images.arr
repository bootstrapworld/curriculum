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

###################### Build and filter ##########################
fun is-cat(r): r["species"] == "cat" end

cats      = filter(animals-table, is-cat)

###################### Make some charts ##########################
chart = render-chart(from-list.labeled-histogram(
        cats.column("name"),
        cats.column("age")).bin-width(1))
      .x-axis("age")
      .y-axis("frequency")
      .height(378)
      .width(1000)

###################### Save the images ##########################
I.save-image(chart.get-image(), '../images/stdev-cat-age-AUTOGEN.png')
