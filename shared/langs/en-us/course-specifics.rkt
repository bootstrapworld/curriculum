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
    ("algebra-wescheme" "https://www.lulu.com/shop/rachel-tabak-and-flannery-denny-and-ben-lerner-and-joe-politz/bootstrapalgebra-wescheme/paperback/product-92zw5z.html")
    ("algebra-pyret" "https://www.lulu.com/shop/rachel-tabak-and-flannery-denny-and-ben-lerner-and-joe-politz/bootstrapalgebra-pyret/paperback/product-4zk8wp.html")
    ("data-science" "https://www.lulu.com/shop/dorai-sitaram-and-ben-lerner-and-joe-politz-and-rachel-tabak/bootstrapdata-science-workbook/paperback/product-9j9ede.html")
    ("data-science-codap" "#")
    ))

(define *course-banners*
  '(
    ("algebra-wescheme" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ("algebra-pyret" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ))
