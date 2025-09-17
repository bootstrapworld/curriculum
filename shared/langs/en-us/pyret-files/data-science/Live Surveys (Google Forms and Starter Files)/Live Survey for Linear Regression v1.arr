use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/data-science-live.arr")


# Students: If your teacher shared a copy of this file with you, just click "Run"

# Teachers: To preview how this file works with our dummy data, click "Run". 


############################################################
# TO LINK THIS FILE WITH YOUR CLASS' DATA: 

# 1) Make a copy of this Google form 

FORM = "https://docs.google.com/forms/d/14nUYqhtqw08UORHLYeFJwUqelcGheZIeos8HF1hrTiQ/copy"

# 2) Click on the `Responses` Tab in the Google form and then `Link to Sheets`.
# 3) Click `Share` and make sure the settings allow "anyone with link" to view. 
# 4) Copy the URL of the resultant Google Sheet. 
# 5) Replace the URL below with the link you just copied. 

URL = "https://docs.google.com/spreadsheets/d/16h6fV3aKlVRQuNWq-E_WPYFvPe43c4TSnGE858srtUU/"
SHEET-NAME = "Form Responses 1"
COLUMNS = [list: "timestamp","youngest","oldest"]

# 6) Wait for at least one submission (It could be yours.)
# Pyret will give you an error if you try to make a chart from a sheet with no Rows! 

# 7) Click "Run". You should see a window pop up with an lr-plot.
# It will update automatically as students continue to enter new data.

# 8) If you would like students to be able to view this file on their computers, now is the time to publish and share the link.



############################################################
# DO NOT CHANGE ANYTHING BELOW THIS LINE 


# Feel free to read the commments below if you're curious how the program works.


# This function defines how we want the data to be visualized
# visualize :: Table -> Image
# Consumes the table and a column and produces an lr-plot of the data

fun visualize(t): 
  lr-plot(t, "timestamp","youngest","oldest")
end

# The function expression below links your class' data 
# to the visualize function you defined above and continues to update it in real time

# live-survey :: (URL, String, List, (Table -> Image)) -> Image
# Consumes... 
# - the URL of a Google Sheet
# - the String that is name of the sheet
# - a List of columns 
# - an image-producing Function
# Produces...
# a data visualization that should automatically update as students continue to fill out the google form associated with the spreadsheet.

live-survey(URL, SHEET-NAME, COLUMNS, visualize)

