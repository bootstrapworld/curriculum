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

cats      = filter(more-animals, is-cat)
rabbits   = filter(more-animals, is-rabbit)
dogs      = filter(more-animals, is-dog)
lizards   = filter(more-animals, is-lizard)
tarantulas= filter(more-animals, is-tarantula)

###################### Make some series ##########################
cat-pounds-series = from-list.num-dot-chart(cats.column("pounds")).point-size(8)
dog-pounds-series = from-list.num-dot-chart(dogs.column("pounds")).point-size(8)
rabbit-pounds-series = from-list.num-dot-chart(rabbits.column("pounds")).point-size(8)
tarantula-pounds-series = from-list.num-dot-chart(tarantulas.column("pounds")).point-size(8)
animals-weeks-series = from-list.num-dot-chart(animals-table.column("weeks")).point-size(8)

###################### Make some charts ##########################
cat-pounds = render-chart(cat-pounds-series)
  .x-axis("pounds")
  .y-axis("frequency")
  .width(500)
  .height(200)
  .get-image()

dog-pounds = render-chart(cat-pounds-series)
  .x-axis("pounds")
  .y-axis("frequency")
  .width(500)
  .height(200)
  .get-image()

rabbit-pounds = render-chart(rabbit-pounds-series)
  .x-axis("pounds")
  .y-axis("frequency")
  .width(500)
  .height(110)
  .get-image()

tarantula-pounds = render-chart(tarantula-pounds-series)
  .x-axis("pounds")
  .y-axis("frequency")
  .width(500)
  .height(110)
  .get-image()

animals-weeks = render-chart(animals-weeks-series)
  .x-axis("weeks")
  .y-axis("frequency")
  .width(290)
  .height(160)
  .get-image()

###################### Save the images ##########################
I.save-image(cat-pounds, '../images/cat-dot-plot-AUTOGEN.png')
I.save-image(dog-pounds, '../images/dog-dot-plot-AUTOGEN.png')
I.save-image(rabbit-pounds, '../images/rabbit-dot-plot-AUTOGEN.png')
I.save-image(tarantula-pounds, '../images/tarantula-dot-plot-AUTOGEN.png')
I.save-image(animals-weeks, '../images/dot-plot-weeks-AUTOGEN.png')
