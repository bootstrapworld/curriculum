# sample-chart-image.arr
# Pyret program for createing image file
# To use:
# install pyret-npm
# pyret sample-chart-image.arr

import csv as csv
import charts as VC
import image-typed as I

lib-dir = '../../../../../lib/'

animals-table =
  load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: csv.csv-table-file(lib-dir + "Animals-Dataset-1.5.1.csv", {
    header-row: true,
    infer-content: true
  })
end

series-1 = VC.from-list.scatter-plot(
extract age from animals-table end,
extract weeks from animals-table end
)

rendered = VC.render-charts([list: series-1])

I.save-image(rendered.get-image(), 'animal-chart.png')
