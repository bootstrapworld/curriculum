#lang racket

(provide *starter-files*) 

(define *starter-files*

'(
  ; no spaces in starter file shortname!
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; CORE

  ("alices-restaurant" "Alice's Restaurant Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1M1EtsxsH1a9R4r27PCpKDj5RGv4TSVp2")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=AcThgFgX9z")
   )
  ("gt" "gt Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1wvO-su91pFXQJcsIAa5IUOVcUea06YuY")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=2eMcXop5hZ")
   )
  ("bc" "bc Starter File"
    ("pyret" "https://code.pyret.org/editor#share=1Smei9pZ0b-y2yCzfyweBKQZAUixkim6b&v=1904b2c")
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

  ("context" "Blank Dataset Starter File for Bootstrap:Data Science"
    ("pyret" "https://code.pyret.org/editor#share=1HOkwUMWFgB3bR50JykQc2aWEw8iUo9GM")
    )

  ("animals" "Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1lGjndLCWSEoIrV3ErZMXSn_-xakqGvrK")
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
  ("height" "Age vs. Height Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1prqCzfZWJ-kuXJMclmi1qyE0cSdziLiV")
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
   ("pyret" "https://code.pyret.org/editor#share=1DBYGJDOlIARaWI3pBVzjPp6eewkQJGHW")
   )
  ("word-length"  "Word Length Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1rdPYXc64IkvSROcCWliYua7o81YBb0rb")
   )
  ("dirty-data"  "New Animals! Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-6Wc9OI6HZLl38BExnAtBdZZI5D-VgWM")
   )
  ("bad-survey"  "Height vs. Wingspan"
   ("pyret" "https://docs.google.com/forms/d/e/1FAIpQLSfxv9sN_2P1Dxs500Cu5PxBniKHHUXX_2Ef5a_7RcE9GOKmwQ/viewform")
   )

  ; math
   
  ("game"  "Blank Game Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1rNabrhxIqcfHEjdzJqKQAnA9uVWdprQu")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=bTq3FRpa2b")
   )
  ("boolean" "Boolean Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1CRRVBQ-D16b00MgOH6RA7I_OWousDUql")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=EA6R0E97nV")
   )
  ("bug-hunting"  "Bug Hunting Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1JEeZjzctaJ9fD77rWXqrorqCwlZrDx9H")
   ("wescheme" "https://www.wescheme.org/view?publicId=nwVEttw9ZY")
   )
  ("permutations-and-combinations"  "Permutations and Combinations Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1pOwcDplD2vidTIvBMrBI5fVZ2jmk369Q")
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
  ("flags-turkey" "Flag of Turkey Starter File"
   ("pyret" "https://code.pyret.org/editor#share=17HZOT0Y6rHAmwv8BZNN9YIsoqI7yWmHj")
   ("wescheme" "https://www.wescheme.org/view?publicId=0Sdq8F2b3q")
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
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=Tl7bbvF9Kw")
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

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; REACTIVE
  ("package-delivery" "Package Delivery Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1RKJNrC2eRxO8apsA0UKbLZAMGD73Xk5D")
  )

  ("cake-bakery" "Bakery Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1lSittPaSqyeDXAmYmLX8epCIDU4FCFlH")
  )

  ("sunset" "Sunset Starter File"
   ("pyret" "https://code.pyret.org/editor#share=13RRDcl13HkfNp0Ue7jQUhBNZIumSNxfP")
  )

  ("what-to-wear" "What to Wear Starter File"
   ("pyret" "https://code.pyret.org/editor#share=15fUR1QAF-O5HIDq95QnctdsdVNfF1Tde")
  )

  ("moving-character" "Moving Character Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1pmuumO3gEC44--2zxp5fjK6k20lCYt-t")
  )

  ("virtual-pet" "Virtual Pet Starter File"
   ("pyret" "https://code.pyret.org/editor#share=15WcPmjNM-qAZGs9BakA7prvOVMqbBkxU")
  )

  ("single-number" "Single-Number State Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1p4oviyUQ-EGuo12Y3wHeAdG8xJjOKtkE")
  )

  ("two-number" "Two-Number State Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Az8Xd4ZcMwqezo8vAldQOrfQkRvi2H8N")
  )

  ("ninja-cat-collisions", "Ninja Cat Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1TGw11fcBMAS0j2CCRWZm5_6GuBWVMBPq")
  )

  ("watermelon-smash" "Watermelon Smash Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-gNiFJeQenO3e_9LVbPw6ucl4lZrTA6R")
  )

  ))
