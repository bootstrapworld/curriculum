#lang racket

(provide *starter-files*) 

(define *starter-files*

'(
  ; core ; no spaces in starter file shortname!

  ("alices-restaurant" "Alice's Restaurant Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1M1EtsxsH1a9R4r27PCpKDj5RGv4TSVp2")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=AcThgFgX9z")
   )
  ("gt" "gt Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1wvO-su91pFXQJcsIAa5IUOVcUea06YuY")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=2eMcXop5hZ")
   )
  ("mood-generator" "Mood Generator Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nTf5h4SJ3KCz2KxqH-0wsYU9cCbu5RkZ")
   ("wescheme" "https://www.wescheme.org/view?publicId=BheDrtcEvA")
   )
  ("mood-generator-ask" "Alternate Version of the Mood Generator Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1YkCJ8k1zYqdhwk8R1BGUk0hWS0HXxc_e")
   )
  ("red-shape" "Red Shape Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1QW7KtZHbAPdP1vjyI9-jXx7pSXrwzWJN")
   ("wescheme" "https://www.wescheme.org/view?publicId=n4DkTyYbQh")
   )

  ; data-science

  ("animals" "Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1pc0CiS0YsL_62yLARUAYNkGBIZvhm2gi")
   ("codap" "https://codap.concord.org/app/static/dg/en/cert/index.html#shared=https%3A%2F%2Fcfm-shared.concord.org%2FeZEwgF1qSm396MC6CNM9%2Ffile.json")
   )
  ("custom-animals" "Custom Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1zjYggoFxpreTalJdDvlFPnQtcQNMyJiH")
   )
  ("expanded-animals" "Expanded Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Iu5I9lJt1oCho-l4xk7FucgtLq6cAUVr")
   ("codap" "https://codap.concord.org/app/static/dg/en/cert/index.html#shared=https%3A%2F%2Fcfm-shared.concord.org%2FcB4wG0wo1lWCI77dtj9C%2Ffile.json")
   )
  ("custom-scatter-plot-w-range" "Dots for Value Ranges Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1OUuVCsm320LzZtwsrS4TLTt_Gp7tQD2A")
   )
  ("custom-scatter-plot" "Custom Scatter Plot Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Yskwvzbe5CSMX3F1fveEOgrL3ms2cxHV")
   )
  ("piecewise-custom-scatter-plot" "Custom Scatter Plot with Piecewise Functions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1SOLAau653CYFY05x45NustZ0-ejKGQF0")
   )
  ("putting-it-all-together" "Putting it all Together Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Qru5u76sBGvm4bB0KS8YSDKk4ED4qt5U")
   )
  ("row-functions" "Row Functions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-YuAea2oTVZcEyUNvEb-cg5qIB6n5V7n")
   )
  ("table-methods" "Table Methods Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1IkX5mu-XHHkxFlZVo7ZgLraoB18biUqA")
   ("codap" "https://codap.concord.org/app/static/dg/en/cert/index.html#shared=https%3A%2F%2Fcfm-shared.concord.org%2FeZEwgF1qSm396MC6CNM9%2Ffile.json")
   )
  ("text-stats"  "Text Stats Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1yF_v4g708v5FLnidZ8n7nQo_MJGrFoIP")
   )
  ("trust-but-verify"  "Trust but Verify Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1yF_v4g708v5FLnidZ8n7nQo_MJGrFoIP")
   )
  ("word-length"  "Word Length Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1rdPYXc64IkvSROcCWliYua7o81YBb0rb")
   )

  ; math
  
  ("game"  "Blank Game Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1rNabrhxIqcfHEjdzJqKQAnA9uVWdprQu")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=ysj93ZPFsu&")
   )
  ("boolean" "Boolean Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1CRRVBQ-D16b00MgOH6RA7I_OWousDUql")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=EA6R0E97nV")
   )
  ("bug-hunting"  "Bug Hunting Starter File"
   ("pyret" "https://code.pyret.org/editor#share=10eAHLb3ZAwlBCXPc9ordWvoElEIjUB8q")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=JCTcwYc57r")
   )
  ("permutations-and-combinations"  "Permutations and Combinations Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nrGFh4nQGzcmi1caHlWoPSM1mH8kJqNi")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=hHNjcj8rB6")
   )
  ("defining-values"  "Defining Values Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nHYxDhgOsbQ-jI7OMZLcgcTJ8HFxPWCL")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=Dus6Kaigy6")
   )
  ("exploring-linearity-in-definitions"  "Exploring Linearity in Definitions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1HqgHT0HYeAIViIZ37YC9MFlj2euoOwYb")
   )
  ("exploring-linearity-in-graphs"  "Exploring Linearity in Graphs Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1e_B5iwBeA58yGQ2FyfG_jNf05MuryFYS")
   )
  ("exploring-linearity-in-tables"  "Exploring Linearity in Tables Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1eelb-3bcUy6loIJ0oHAk9NJjKgtiRVmn")
   )
  ("flags-mx" "Flag of Mexico Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1xUVPGNns_0g6g9-70W6CbxqXv1QJZvK6")
   ("wescheme" "https://www.wescheme.org/view?publicId=SnLx13yt5W")
   )
  ("flags" "Flags Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1mjNzzf4iiQkjosPExCKtYyCaDihSs-Qr")
   ("wescheme" "https://www.wescheme.org/view?publicId=jH25JejavW")
   )
  ("flags-ak" "Alaskan Flag Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1f3sX5IaNDKd3l6QFFblRHvyLFKVQXYvX")
   ("wescheme" "https://www.wescheme.org/view?publicId=ve2gTEY06p")
   )
  ("flags-china" "Chinese Flag Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1pi0API2gERKokehisGvg7717xaHHPEui")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=Vl5yocVoU4")
   )
  ("flags-2" "Flags of Netherland, France & Mauritius Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1O_3WGOcqaTzR7cuZY3ZSh5TEFg3ZNPV6")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=81WrTGQglP")
   )
  ("flags-pr" "Flag of Puerto Rico Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1QX4pU7j2hK4rR0zfLXGAgEarCSsLVwqD")
   ("wescheme" "https://www.wescheme.org/view?publicId=6TJ0N2CJqU")
   )
  ("flags-trinidad" "Flag of Trinidad and Tobago Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-TtjC_NYZTtT5U0T3HSdvcfBHb90bh2n")
   ("wescheme" "https://www.wescheme.org/view?publicId=SQRHKcqQvW")
   )
  ("flags-lebanon" "Flag of Lebanon Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1H1yf0uFJgiT6NBHqW8kh_JjLKHNQRXpH")
   ("wescheme" "https://www.wescheme.org/view?publicId=x0nJrP1UYp")
   )
  ("flags-panama" "Flag of Panama Starter File"
   ("wescheme" "https://www.wescheme.org/view?publicId=V4AfQydAHu")
   )
  ("ninja-cat" "Ninja Cat Game"
   ("pyret" "https://code.pyret.org/editor#share=1VB-XBcSzgYKnObyIH8BdCmiworNRLlvM")
   ("wescheme" "https://www.wescheme.org/run?publicId=sggzRzgU5T")
   )
  ("rocket-height" "Rocket Height Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Wvu39Uf0vmlA6s2HO5nOmGm-PtnTvfCf")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=LGTVNvzrax")
   )
  ("prism" "Surface Area of a Prism Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1jv3H5pke8VykznZ7kGkKFXXiYomYW0AY")
   ("wescheme" "https://www.wescheme.org/view?publicId=3QDJBmzYp0")
   )
  ("sample-game-no-distance-lines" "Sample Game Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1g_3AqB4v6Jtq6TzcIHYNTkvlW9B6dLHS")
   ("wescheme" "https://www.wescheme.org/view?publicId=PJMfrSvGRl")
   )
  ("sample-game-w-distance" "Sample Game with Distance Lines Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1y1eWn1YyDDqilj0MFqEpMy4egVh-G81W")
   ("wescheme" "https://www.wescheme.org/view?publicId=0bCivugY3P")
   )
  ("inequalities-simple" "Simple Inequalities Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Nfd30NVNwPzDu0C02dsCbmKecbMVfcQV")
   ("wescheme" "https://www.wescheme.org/view?publicId=EA6R0E97nV")
   )
  ("inequalities-compound" "Compound Inequalities Starter File"
   ("pyret" "https://code.pyret.org/editor#share=11M7tp22-lOwYK9jJD67mM_RP836ikARd")
   ("wescheme" "https://www.wescheme.org/view?publicId=yFnDbsSnR7")
   )
  ("inequalities-sam" "Sam the Butterfly Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1muE7xY-NKW5IJLeOnAu9Q31JUT6ns_n7")
   ("wescheme" "https://www.wescheme.org/view?publicId=0elP8WrmfM")
   )

  ))
