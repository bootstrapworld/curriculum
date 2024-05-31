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
    ("data-science-codap" "Bootstrap:Data Science (in CODAP)")
    ("history-social-studies" "Bootstrap:Social Studies")
    ("hour-of-code" "Hour of Code")
    ("early-math" "Bootstrap:Early Math")
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
    ("algebra-wescheme" "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrap-algebra-wescheme-2024/paperback/product-nvqzezw.html")
    ("algebra-pyret" "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrapalgebra-pyret-2024/paperback/product-65qn2k4.html")
    ("data-science" "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrapdata-science-pyret-2024/paperback/product-gjvqqj9.html")
    ("data-science-codap" "#")
    ("reactive" "https://www.lulu.com/shop/ben-lerner-and-joe-politz-and-dorai-sitaram-and-rachel-tabak/bootstrap-reactive-pyret-2024/paperback/product-p6k2eme.html")
    ))

(define *course-banners*
  '(
    ("algebra-wescheme" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ("algebra-pyret" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ))
