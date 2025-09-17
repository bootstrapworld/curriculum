use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science.arr")

#########################################################
# Load your spreadsheet 
co2-sheet = load-spreadsheet("https://docs.google.com/spreadsheets/d/1fK4IaeSfTqpobZZwifhNC1Q0OTX4mmJGunBqsmmg8-Q/")

# Define your table
co2-table = load-table: # List all of the columns in the table
  year,  # e.g. 1981, 1994, etc. 
  month, # e.g. 1=January, 2=February, etc.
  date,  # July 2nd, 1990 would be represented as "1990.5"
  co2    # carbon dioxide in the air, measured in parts-per-million (ppm) at the Mauna Loa Observatory in Hawaii
  source: co2-sheet.sheet-by-name("data", true)
end


######################################################### 
# Define some helper functions

# is-recent :: Row -> Boolen
# is-recent checks to see if a row in the dataset is 
# between November 2022 and November 2023
fun is-recent(r): (r["date"] > 2022.708) and (r["date"] < 2023.7917) end

# filter our dataset to make a table of ONLY recent data
recent-table = filter(co2-table, is-recent)

# is-modern :: Row -> Boolen
# is-modern checks to see if a row in the dataset is 
# after January 1, 2010
fun is-modern(r): r["date"] > 2010 end

# filter our dataset to make a table of ONLY modern data
modern-table = filter(co2-table, is-modern)

######################################################### 
# Define some models

# a periodic model using sine (instead of cosine)
fun periodic-sin(x): (... * sin(... * (x - ...))) + ... end
