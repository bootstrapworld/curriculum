use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import color as C
import csv as csv
include charts
import statistics as Stats

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

co2-url = "https://docs.google.com/spreadsheets/d/1fK4IaeSfTqpobZZwifhNC1Q0OTX4mmJGunBqsmmg8-Q/export?format=csv"

###################### Load the data ##########################
# Define your table
co2-table = load-table: # List all of the columns in the table
  year,  # e.g. 1981, 1994, etc.
  month, # e.g. 1=January, 2=February, etc.
  date,  # July 2nd, 1990 would be represented as "1990.5"
  co2    # carbon dioxide in the air, measured in parts-per-million (ppm) at the Mauna Loa Observatory in Hawaii
  source: csv.csv-table-url(co2-url, {
    header-row: true,
    infer-content: true
  })
end

padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

fun is-recent(r): (r["date"] > 2022.708) and (r["date"] < 2023.7917) end
recent-table = filter(co2-table, is-recent)

fun is-modern(r): r["date"] > 2010 end
modern-table = filter(co2-table, is-modern)

fun periodic-sin(x): (4.13 * sin(6.28 * (x - 2023.1))) + 419.87 end

###################### Make some charts ##########################
historical-bad-fit = fit-model(co2-table, "year", "date", "co2", periodic-sin)

modern-co2-scatter-chart = render-chart(
  from-list.scatter-plot(
    modern-table.column("date"),
    modern-table.column("co2")).point-size(8))
    .x-axis("date")
    .y-axis("co2")
    .width(500)
    .height(400)

modern-lr-chart = lr-plot(modern-table, "year", "date", "co2")
###################### Save the images ##########################
I.save-image(historical-bad-fit, '../images/historical-bad-fit-AUTOGEN.png')
I.save-image(modern-lr-chart, '../images/modern-lr-AUTOGEN.png')
I.save-image(modern-co2-scatter-chart.get-image(), '../images/modern-co2-scatter-AUTOGEN.png')

