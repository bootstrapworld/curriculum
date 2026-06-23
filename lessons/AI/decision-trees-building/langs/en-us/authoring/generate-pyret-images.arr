use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026", "libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

training-url = "https://docs.google.com/spreadsheets/d/1DjY_8v8VGyacnpuy72Up4oYYIJ64gqvoCKR7_LTf3lI/export?format=csv"

fun animal-img(r):
  if      (r["species"] == "dog"):       text("🐶", 20, "black")
  else if (r["species"] == "cat"):       text("😺", 20, "black")
  else if (r["species"] == "lizard"):    text("🦎", 20, "black")
  else if (r["species"] == "rabbit"):    text("🐇", 20, "black")
  else if (r["species"] == "snail"):     text("🐌", 20, "black")
  else if (r["species"] == "tarantula"): text("🕷️", 20, "black")
  end
end

###################### Load the data ##########################
training =
  load-table: ID, species, sex, pounds, tail, mammal, swims
  source: csv.csv-table-url(training-url, {
    header-row: true,
    infer-content: true
  })
end

images = training.all-rows().map(animal-img)

###################### Make some charts ##########################
mammal-series = from-list.image-dot-chart(images, training.column("mammal").map(to-repr))
pounds-series = from-list.image-dot-chart(images, training.column("pounds").map(to-repr))
sex-series = from-list.image-dot-chart(images, training.column("sex").map(to-repr))
swims-series = from-list.image-dot-chart(images, training.column("swims").map(to-repr))
tail-series = from-list.image-dot-chart(images, training.column("tail").map(to-repr))


dot-plot-mammal = render-chart(mammal-series).height(250).get-image()
dot-plot-pounds = render-chart(pounds-series).height(250).get-image()
dot-plot-sex = render-chart(sex-series).height(250).get-image()
dot-plot-swims = render-chart(swims-series).height(250).get-image()
dot-plot-tail = render-chart(tail-series).height(250).get-image()


###################### Save the images ##########################
I.save-image(dot-plot-mammal, '../images/dot-plot-mammal-AUTOGEN.png')
I.save-image(dot-plot-pounds, '../images/dot-plot-pounds-AUTOGEN.png')
I.save-image(dot-plot-sex, '../images/dot-plot-sex-AUTOGEN.png')
I.save-image(dot-plot-swims, '../images/dot-plot-swims-AUTOGEN.png')
I.save-image(dot-plot-tail, '../images/dot-plot-tail-AUTOGEN.png')

