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

fun is-recent(r): (r["date"] > 2022.708) and (r["date"] < 2023.7917) end
recent-table = filter(co2-table, is-recent)

fun is-modern(r): r["date"] > 2010 end
modern-table = filter(co2-table, is-modern)

######################################################### 
# EXAMPLE of how to write (and re-write!) the COSINE model 
# for RECENT-TABLE, using function composition

fun periodic-cos(x):  (4.13 * cos(6.28 * (x - 2023.35))) + 419.87 end
fun wave-cos(x):      (4.13 * cos(6.28 * (x - 2023.35)))          end
fun mid-line-cos(x):                                       419.87 end 
fun periodic-cos2(x):         wave-cos(x)    +    mid-line-cos(x) end

######################################################### 
# Using the written (and re-written!) cosine model above,
# write (and re-write!) your SINE model for RECENT-TABLE

fun periodic-sin(x):    ... end
fun wave-sin(x):        ... end
fun mid-line-sin(x):    ... end 
fun periodic-sin2(x):   ... end

# LINEAR MODEL for the modern table - find it using lr-plot
fun linear-modern(x):   ... end

# HYBRID MODEL for the modern-table 
fun hybrid-modern(x):   ... end

# HYBRID MODEL for the full co2-table - think through what functions you'll need to define so that you can compose a hybrid model that fits all of the data well.

fun hybrid-all(x): (4.13 * cos(6.28 * (x - 2023.35))) + ((1.8345 * x) - 3296.8) end 
