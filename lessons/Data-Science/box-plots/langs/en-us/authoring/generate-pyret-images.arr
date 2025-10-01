use context url-file("https://raw.githubusercontent.com/bootstrapworld/starter-files/fall2026/data-science", "../libraries/core.arr")

import csv as csv
import charts as VC
import image-typed as I

# the location of the lib directory, relative to the authoring folder of this lesson
# for most lessons, this will be 6 ancestors up. For CODAP lessons it'll be 7.
lib-dir = '../../../../../../lib/pyret-support/'

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

I.save-image(rendered.get-image(), '../images/DELETEME.png')
