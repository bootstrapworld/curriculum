use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet and define your table
judge-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1TUbw1Jg-zrzIyoY-uCiliqJ3EwpurgWe0aQn0GSPAKQ")

judge-table = load-table: 
  id,            # identifier column
  year,          # year of game (2016 or 2017)
  game-date,     # full date of game
  other-team,    # abbreviated name of other team (e.g. NYY, TOR, etc)
  pitch-type,    # type of pitch (e.g. - fastball, cutter, etc)
  pitch-speed,   # speed of the pitch
  bat-angle,     # angle of Aaron's bat
  hit-distance,  # how many feet the hit traveled
  hit-speed,     # speed of the ball, off the bat
  bb-type        # ball type (e.g. - line drive, ground ball, etc)
  source: judge-sheet.sheet-by-name("data", true)
end

######################################################### 
# Define a table of just the curve balls
fun is-curve(r) : r["pitch-type"] == "curveball" end
curve-table = filter(judge-table, is-curve)

# Define a table of just the 4 seam fast balls
fun is-four-seam(r) : r["pitch-type"] == "four-seam-fastball" end
fast4seam-table = filter(judge-table, is-four-seam)

# Define a table of just the 2 seam fast balls
fun is-two-seam(r) : r["pitch-type"] == "two-seam-fastball" end
fast2seam-table = filter(judge-table, is-two-seam)

# Define a table of just the sliders
fun is-slider(r) : r["pitch-type"] == "slider" end
sliders-table = filter(judge-table, is-slider)


######################################################### 
# DEFINE SOME MODELS by filling in "..."
# Predicting HIT-DISTANCE from BAT-ANGLE: 

# Best model you can fit visually for the curve ball data
fun curve(x):     (... * sqr(x - ...))  + ... end

# Best model you can fit visually for the two seam fastball data
fun fast2seam(x): (... * sqr(x - ...))  + ... end

# Best model you can fit visually for the sliders data
fun sliders(x):   (... * sqr(x - ...))  + ... end

# Best model you can fit visually for the four seam fastball data
fun fast4seam(x): (... * sqr(x - ...))  + ... end

# Best model you can fit visually for the complete Aaron Judge dataset
fun judge(x):     (... * sqr(x - ...))  + ... end

# Model from Samples using standard form
fun f(x) : ((... * sqr(x)) + (... * x)) + ... end
######################################################### 
