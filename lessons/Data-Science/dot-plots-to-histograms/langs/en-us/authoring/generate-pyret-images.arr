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

more-animals =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-url(more-animals-url, {
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

cats = filter(more-animals, is-cat)
dogs = filter(more-animals, is-dog)
dogs-small = filter(animals-table, is-dog)

###################### Make some charts ##########################
cat-pounds-chart = render-chart(from-list.histogram(cats.column("pounds")).bin-width(2))
  .x-axis("pounds")
  .y-axis("frequency")
dog-pounds-chart = render-chart(from-list.histogram(dogs.column("pounds")).bin-width(20))
  .x-axis("pounds")
  .y-axis("frequency")
dog-pounds-small-chart = render-chart(from-list.histogram(dogs-small.column("pounds")).bin-width(20))
  .x-axis("pounds")
  .y-axis("frequency")
  .x-min(0)
dot-plot-weeks-chart = render-chart(from-list.num-dot-chart(animals-table.column("weeks")))
  .width(500).height(160)
  .x-min(0)
dot-plot-pounds-chart = render-chart(from-list.num-dot-chart(animals-table.column("pounds")))
  .width(400).height(150)
  .x-min(0)

###################### Save the images ##########################
I.save-image(cat-pounds-chart.get-image(), '../images/cat-pounds-AUTOGEN.png')
I.save-image(dog-pounds-chart.get-image(), '../images/dog-pounds-AUTOGEN.png')
I.save-image(dog-pounds-small-chart.get-image(), '../images/dog-pounds-small-AUTOGEN.png')
I.save-image(dot-plot-weeks-chart.get-image(), '../images/dot-plot-weeks-AUTOGEN.png')
I.save-image(dot-plot-pounds-chart.get-image(), '../images/dot-plot-pounds-AUTOGEN.png')
