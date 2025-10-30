use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

#|
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

fun is-mostly-recent(r): (r["date"] > 2022.6) and (r["date"] < 2023.7917) end
recent-table = filter(co2-table, is-mostly-recent)

fun recent-color(r):
  color = if (r["date"] > 2022.75): "blue" else: "lightblue" end
  circle(6, "solid", color)
end
|#

############## "AI" Charts #########################
fn_sin-1-8th-pi-img  = make-noisy-scatter(lam(x): ( 1 * sin(1/8 * PI * x)) end, -2 * 3.14, 6 * 3.14, 2)
fn_sin-10-half-pi-img= make-noisy-scatter(lam(x): (10 * sin(1/2 * PI * x)) end, -4 * 3.14, 0 * 3.14, 2)
fn_sin-1-8th-pi-plus-5-img= make-noisy-scatter(lam(x): ( 1 * sin(1/8 * PI * x)) + 5 end, -2 * 3.14, 6 * 3.14, 2)
fn_sin-1-half-pi-img = make-noisy-scatter(lam(x): ( 1 * sin(1/2 * PI * x)) end, -2 * 3.14, 6 * 3.14, 2)


###################### Save the images ##########################
I.save-image(fn_sin-1-8th-pi-img,        '../images/fn_sin-1-8th-pi-AUTOGEN.png')
I.save-image(fn_sin-10-half-pi-img,      '../images/fn_sin-10-half-pi-AUTOGEN.png')
I.save-image(fn_sin-1-8th-pi-plus-5-img, '../images/fn_sin-1-8th-pi-plus-5-AUTOGEN.png')
I.save-image(fn_sin-1-half-pi-img,       '../images/fn_sin-1-half-pi-AUTOGEN.png')
