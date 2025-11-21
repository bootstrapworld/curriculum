use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")
import image-typed as I
import csv as csv
include charts
import data-source as DS

# just return the image, instead of displaying it as a modal
display-chart := lam(c): c.get-image() end

covid-url = "https://docs.google.com/spreadsheets/d/1GFWesAyYshYXDDSTxoHYmFrPVDTQd12rEVR-ZGn11hg/export?format=csv&gid=811606505"


###################### Load the data ##########################

# Define your table
covid-table = load-table: # NOTES ON COLUMNS:
  state,             # the state reporting the data
  day,               # number of days since 1/1/2020
  positive,          # TOTAL number of positive covid cases
  deaths             # TOTAL number of deaths due to covid
  source: csv.csv-table-url(covid-url, {
    header-row: true,
    infer-content: true
  })
  sanitize positive using DS.string-sanitizer
  sanitize deaths using DS.string-sanitizer
end

fun clean-commas(s :: String) -> Number:
  string-to-number(string-replace(s, ",", "")).or-else(-1)
end

shadow covid-table = transform covid-table using positive, deaths:
  positive: clean-commas(positive),
  deaths: clean-commas(deaths),
end


###################### Helper Functions ##########################
fun is-MI(r): r["state"] == "MI" end

MI-table = filter(covid-table, is-MI)

padding = 10
fun add-padding(img):
  w = image-width(img) + padding
  h = image-height(img) + padding
  above(
    beside(square(padding, "solid", "transparent"), img),
    square(padding, "solid", "transparent"))
end

############## "AI" Charts #########################
fn_2expt_plus_5000 = make-noisy-scatter-chart(lam(x): expt(~2, x) + 5000 end, 0, 15, 20000)
fn_-1expt-5000     = make-noisy-scatter-chart(lam(x): (-1 * expt(~1.6, x)) - 5000 end, 0, 20, 2000)
  .y-max(0)
fn_25expt          = make-noisy-scatter-chart(lam(x): (25 * expt(~2, x)) end, 0, 4, 200)
fn_25expt-100      = make-noisy-scatter-chart(lam(x): (25 * expt(~2, x - 100)) end, 100, 104, 200)


###################### Save the images ##########################
I.save-image(fn_2expt_plus_5000.get-image(), '../images/fn_2expt_plus_5000-AUTOGEN.png')
I.save-image(fn_-1expt-5000.get-image(),     '../images/fn_-1expt-5000-AUTOGEN.png')
I.save-image(fn_25expt.get-image(),          '../images/fn_25expt-AUTOGEN.png')
I.save-image(fn_25expt-100.get-image(),      '../images/fn_25expt-100-AUTOGEN.png')
