use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/", "libraries/ai-library.arr")
import image-typed as I
import csv as csv
include charts
import data-source as DS

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

fast-food-url = "https://docs.google.com/spreadsheets/d/1INp_O7oOwY68694lScyEUNbbHTpOCQA0RPQQXQR9URo/export?format=csv"


###################### Load the data ##########################

# Define your table
fast-food = load-table:
  id,
  restaurant,
  price,
  fries,
  burgers
  source: csv.csv-table-url(fast-food-url, {
    header-row: true,
    infer-content: true
  })
  sanitize id using DS.string-sanitizer
end

###################### Make some charts ##########################

number-line-fries = render-chart(from-list.num-dot-chart(
    fast-food.column("fries"))
    .point-size(20))
  .x-axis("fries")
  .width(360)
  .height(80)
  .get-image()

number-line-burgers = render-chart(from-list.num-dot-chart(
    fast-food.column("burgers"))
    .point-size(20))
  .x-axis("burgers")
  .width(360)
  .height(80)
  .get-image()

number-line-price = render-chart(from-list.num-dot-chart(
    fast-food.column("price"))
    .point-size(20))
  .x-axis("price")
  .width(360)
  .height(80)
  .get-image()

fries-v-price = render-chart(from-list.scatter-plot(
    fast-food.column("fries"),
    fast-food.column("price"))
    .point-size(20))
  .x-axis("fries")
  .y-axis("price")
  .width(480)
  .height(360)
  .get-image()

burgers-v-price = render-chart(from-list.scatter-plot(
    fast-food.column("burgers"),
    fast-food.column("price"))
    .point-size(20))
  .x-axis("burgers")
  .y-axis("price")
  .width(480)
  .height(360)
  .get-image()


###################### Save the images ##########################
I.save-image(fries-v-price.get-image(),   '../images/fries-v-price-AUTOGEN.png')
I.save-image(burgers-v-price.get-image(), '../images/burgers-v-price-AUTOGEN.png')
