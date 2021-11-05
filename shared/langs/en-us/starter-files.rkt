#lang racket

(provide *starter-files*)

(define *starter-files*

'(
  ; core ; no spaces in starter file shortname!

  ("alices-restaurant" "Alice's Restaurant Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1M1EtsxsH1a9R4r27PCpKDj5RGv4TSVp2&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=AcThgFgX9z")
   )
  ("gt" "gt Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1wvO-su91pFXQJcsIAa5IUOVcUea06YuY&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=2eMcXop5hZ")
   )
  ("mood-generator" "Mood Generator Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nTf5h4SJ3KCz2KxqH-0wsYU9cCbu5RkZ&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=BheDrtcEvA")
   )
  ("mood-generator-ask" "Alternate Version of the Mood Generator Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1YkCJ8k1zYqdhwk8R1BGUk0hWS0HXxc_e&v=1904b2c")
   )
  ("red-shape" "Red Shape Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1QW7KtZHbAPdP1vjyI9-jXx7pSXrwzWJN&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=n4DkTyYbQh")
   )

  ; data-science

  ("animals" "Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1pc0CiS0YsL_62yLARUAYNkGBIZvhm2gi&v=1904b2c")
   ("codap" "https://codap.concord.org/app/static/dg/en/cert/index.html#shared=https%3A%2F%2Fcfm-shared.concord.org%2FeZEwgF1qSm396MC6CNM9%2Ffile.json")
   )
  ("custom-animals" "Custom Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1zjYggoFxpreTalJdDvlFPnQtcQNMyJiH&v=1904b2c")
   )
  ("expanded-animals" "Expanded Animals Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Iu5I9lJt1oCho-l4xk7FucgtLq6cAUVr&v=1904b2c")
   )
  ("image-scatter-plot-w-range" "Dots for Value Ranges Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1OUuVCsm320LzZtwsrS4TLTt_Gp7tQD2A&v=1904b2c")
   )
  ("image-scatter-plot" "Image Scatter Plot Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Yskwvzbe5CSMX3F1fveEOgrL3ms2cxHV&v=1904b2c")
   )
  ("piecewise-image-scatter-plot" "Image Scatter Plot with Piecewise Functions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1SOLAau653CYFY05x45NustZ0-ejKGQF0&v=1904b2c")
   )
  ("putting-it-all-together" "Putting it all Together Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Qru5u76sBGvm4bB0KS8YSDKk4ED4qt5U&v=1904b2c")
   )
  ("row-functions" "Row Functions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-YuAea2oTVZcEyUNvEb-cg5qIB6n5V7n&v=1904b2c")
   )
  ("table-methods" "Table Methods Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1IkX5mu-XHHkxFlZVo7ZgLraoB18biUqA&v=1904b2c")
   )
  ("text-stats"  "Text Stats Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1yF_v4g708v5FLnidZ8n7nQo_MJGrFoIP&v=1904b2c")
   )
  ("trust-but-verify"  "Trust but Verify Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1yF_v4g708v5FLnidZ8n7nQo_MJGrFoIP&v=1904b2c")
   )
  ("word-length"  "Word Length Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1rdPYXc64IkvSROcCWliYua7o81YBb0rb&v=1904b2c")
   )

  ; math
  
  ("blank-game"  "Blank Game Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1_zdXA85BkkMqNvKXVdBcjq01foimuXkC&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=ysj93ZPFsu&")
   )
  ("boolean" "Boolean Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1CRRVBQ-D16b00MgOH6RA7I_OWousDUql&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=EA6R0E97nV")
   )
  ("bug-hunting"  "Bug Hunting Starter File"
   ("pyret" "https://code.pyret.org/editor#share=10eAHLb3ZAwlBCXPc9ordWvoElEIjUB8q&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=JCTcwYc57r")
   )
  ("permutations-and-combinations"  "Permutations and Combinations Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nrGFh4nQGzcmi1caHlWoPSM1mH8kJqNi")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=hHNjcj8rB6")
   )
  ("defining values"  "Defining Values Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1nHYxDhgOsbQ-jI7OMZLcgcTJ8HFxPWCL&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=Dus6Kaigy6")
   )
  ("exploring-linearity-in-definitions"  "Exploring Linearity in Definitions Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1AQi6tgmr8WsR9wXfi_8ylra1pnb0wUh9")
   )
  ("exploring-linearity-in-graphs"  "Exploring Linearity in Graphs Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1VpOqRgXqWaNgJf8YHAeRqnFU5W6qTLiN")
   )
  ("exploring-linearity-in-tables"  "Exploring Linearity in Tables Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1n9x5gSOiBbmfo-VLZIirB8P1NjkjS3gS&")
   )
  ("flag-mx" "Flag of Mexico Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1xUVPGNns_0g6g9-70W6CbxqXv1QJZvK6&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=SnLx13yt5W")
   )
  ("flags-start" "Flags Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1mjNzzf4iiQkjosPExCKtYyCaDihSs-Qr&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=jH25JejavW")
   )
  ("flags-alaska" "Alaskan Flag Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1f3sX5IaNDKd3l6QFFblRHvyLFKVQXYvX&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=ve2gTEY06p")
   )
  ("flags-nl-fr-mauritius" "Flags of Netherland, France & Mauritius Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1O_3WGOcqaTzR7cuZY3ZSh5TEFg3ZNPV6&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=81WrTGQglP")
   )
  ("flags-pr" "Flag of Puerto Rico Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1QX4pU7j2hK4rR0zfLXGAgEarCSsLVwqD&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=6TJ0N2CJqU")
   )
  ("flags-trinidad" "Flag of Trinidad and Tobago Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1-TtjC_NYZTtT5U0T3HSdvcfBHb90bh2n&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=SQRHKcqQvW")
   )
  ("flags-lebanon" "Flag of Lebanon Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1H1yf0uFJgiT6NBHqW8kh_JjLKHNQRXpH&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=x0nJrP1UYp")
   )
  ("flags-panama" "Flag of Panama Starter File"
   ("wescheme" "https://www.wescheme.org/view?publicId=V4AfQydAHu")
   )
  ("ninja-cat" "Ninja Cat Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1VB-XBcSzgYKnObyIH8BdCmiworNRLlvM")
   ("wescheme" "https://www.wescheme.org/run?publicId=sggzRzgU5T")
   )
  ("rocket-height" "Rocket Height Starter File"
   ("pyret" "https://code.pyret.org/editor#share=12Fa8MT2kZY7fFUYfsuRcHwOK0a5Vma-V&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/openEditor?publicId=LGTVNvzrax")
   )
  ("sa-prism" "Surface Area of a Prism Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1UjWTxWi6FeDpKvP-n1o-EWhmGPDzbWPC&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=3QDJBmzYp0")
   )
  ("sample-game-no-distance-lines" "Sample Game Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1g_3AqB4v6Jtq6TzcIHYNTkvlW9B6dLHS&v=882d33a")
   ("wescheme" "https://www.wescheme.org/view?publicId=PJMfrSvGRl")
   )
  ("sample-game-w-distance" "Sample Game with Distance Lines Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1y1eWn1YyDDqilj0MFqEpMy4egVh-G81W&v=882d33a")
   ("wescheme" "https://www.wescheme.org/view?publicId=0bCivugY3P")
   )
  ("inequalities-simple" "Simple Inequalities Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1Nfd30NVNwPzDu0C02dsCbmKecbMVfcQV&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=EA6R0E97nV")
   )
  ("inequalities-compound" "Compound Inequalities Starter File"
   ("pyret" "https://code.pyret.org/editor#share=11M7tp22-lOwYK9jJD67mM_RP836ikARd&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=yFnDbsSnR7")
   )
  ("inequalities-sam" "Sam the Butterfly Starter File"
   ("pyret" "https://code.pyret.org/editor#share=1muE7xY-NKW5IJLeOnAu9Q31JUT6ns_n7&v=1904b2c")
   ("wescheme" "https://www.wescheme.org/view?publicId=0elP8WrmfM")
   )

  ))
