use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026", "libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

training-url = "https://docs.google.com/spreadsheets/d/1DjY_8v8VGyacnpuy72Up4oYYIJ64gqvoCKR7_LTf3lI/export?format=csv"


var SIZE = 60


fun animal-img(r):
  if      (r["species"] == "dog"):       text("🐕‍🦺", SIZE, "black")
  else if (r["species"] == "cat"):       text("🐈", SIZE, "black")
  else if (r["species"] == "lizard"):    text("🦎", SIZE, "black")
  else if (r["species"] == "rabbit"):    text("🐇", SIZE, "black")
  else if (r["species"] == "snail"):     text("🐌", SIZE, "black")
  else if (r["species"] == "tarantula"): text("🕷️", SIZE, "black")
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

#################### "Baseball Card" Images for Desmos Cardsort #################
fun to-card-img(r):
  card = overlay-align(
    "middle",
    "middle",
    above-list([list:
        beside(text(r["ID"] + " ", SIZE * 1.25, "black"), animal-img(r)),
        circle(SIZE / 4, "solid", "transparent"),
        text("sex: "     + r["sex"],               SIZE, "darkblue"),
        circle(SIZE / 4, "solid", "transparent"),
        text("pounds: "  + to-string(num-to-fixnum(r["pounds"])), SIZE, "blue"),
        circle(SIZE / 4, "solid", "transparent"),
        text("tail: "    + to-string(r["tail"]),   SIZE, "darkblue"),
        circle(SIZE / 4, "solid", "transparent"),
        text("mammal: "  + to-string(r["mammal"]), SIZE, "blue"),
        circle(SIZE / 4, "solid", "transparent"),
        text("swims: "   + to-string(r["swims"]),  SIZE, "darkblue"),
        circle(SIZE / 4, "solid", "transparent")
      ]),
    rectangle(560, 500, "outline", "black"))
  I.save-image(scale(1/2, card), '../images/' + r["ID"] + '-CARD.png')
end

training.all-rows().map(to-card-img)


#|
###################### Make some charts ##########################
SIZE := 20

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

|#