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
    ("ok" "Bootstrap:Integrated Oklahoma")
    ("physics" "Bootstrap:Physics")
    ("reactive" "Bootstrap:Reactive")
    ))

(define *course-workbook-links*
  '(
    ("algebra-wescheme" "https://www.lulu.com/en/us/shop/dorai-sitaram-and-ed-campos-and-jennifer-poole-and-flannery-denny/bootstrapalgebra-student-workbook-wescheme/paperback/product-4j9rmj.html")
    ("algebra-pyret" "https://www.lulu.com/en/us/shop/dorai-sitaram-and-ed-campos-and-jennifer-poole-and-flannery-denny/bootstrapalgebra-student-workbook-pyret/paperback/product-6j9zek.html")
    ("data-science" "https://www.lulu.com/en/us/shop/dorai-sitaram-and-ben-lerner-and-joe-politz-and-flannery-denny/bootstrapdata-science-workbook/paperback/product-9j9ede.html")
    ("data-science-codap" "https://www.lulu.com/en/us/shop/dorai-sitaram-and-ben-lerner-and-joe-politz-and-flannery-denny/bootstrapdata-science-workbook/paperback/product-9j9ede.html")
    ))

(define *course-banners*
  '(
    ("algebra-wescheme" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ("algebra-pyret" "The earlier version of our materials is also available https://bootstrapworld.org/materials/spring2020/courses/algebra/es-mx/index.shtml[en español]. Let us know if you can mailto:contact@BootstrapWorld.org[lend a hand] translating the new version!")
    ))
