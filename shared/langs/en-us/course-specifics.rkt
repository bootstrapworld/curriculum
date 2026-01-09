#lang racket

(provide
  *course-names*
  *course-workbook-links*
  *course-banners*)

(define *course-names*
  '(
    ("algebra-wescheme" "Bootstrap: Algebra")
    ("algebra-pyret" "Bootstrap: Algebra")
    ("data-science" "Bootstrap:Data Science")
    ("data-literacy-codap" "Bootstrap:Data Literacy (CODAP)")
    ("history-social-studies" "Bootstrap:Social Studies")
    ("hour-of-code" "Hour of Code")
    ("expressions-and-equations" "Bootstrap:Expressions and Equations")
    ("math-grade5" "Bootstrap:Grade 5 Math")
    ("math-grade6" "Bootstrap:Grade 6 Math")
    ("math-grade7" "Bootstrap:Grade 7 Math")
    ("math-grade8" "Bootstrap:Grade 8 Math")
    ("maya" "Exploring the Maya Civilization")
    ("ok" "Bootstrap:Integrated Oklahoma")
    ("physics" "Bootstrap:Physics")
    ("reactive" "Bootstrap:Reactive")
    ("shipwrecks" "Bootstrap:Shipwrecks")
    ))

(define *course-workbook-links*
  '(
    ("algebra-wescheme" "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrap-algebra-wescheme-2024/paperback/product-gjgvqy9.html")
    ("algebra-pyret"    "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrapalgebra-pyret-2024/paperback/product-45mn9qg.html")
    ("data-science"     "https://www.lulu.com/shop/nancy-pfenning-and-ben-lerner-and-joe-politz-and-dorai-sitaram/bootstrapdata-science-pyret-2024/paperback/product-dymngdr.html")
    ("data-literacy"    "https://www.lulu.com/shop/flannery-denny-and-kathi-fisler-and-shriram-krishnamurthi-and-ben-lerner/bootstrapdata-literacy-pyret-2025/paperback/product-dyddw7q.html")
    ("algebra-2"        "https://www.lulu.com/shop/shriram-krishnamurthi-and-kathi-fisler-and-ben-lerner-and-joe-politz/bootstrap-algebra-2/paperback/product-45mwgrw.html")
    ("reactive"         "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrap-reactive-pyret-2024/paperback/product-p6k2eme.html")
    ("ai"               "https://www.lulu.com/shop/flannery-denny-and-kathi-fisler-and-shriram-krishnamurthi-and-ben-lerner/bootstrapai/paperback/product-zmr88pn.html")
    ("expressions-and-equations" "https://www.lulu.com/shop/flannery-denny-and-kathi-fisler-and-shriram-krishnamurthi-and-ben-lerner/bootstrapexpressions-and-equations-pyret-2025/paperback/product-gjy5e2d.html")
    ("data-literacy-codap" "#")
    ))

(define *course-banners*
  '(
    ("algebra-wescheme" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ("algebra-pyret" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ))
