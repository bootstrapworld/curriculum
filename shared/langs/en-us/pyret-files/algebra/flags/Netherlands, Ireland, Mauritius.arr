use context url("https://raw.githubusercontent.com/bootstrapworld/curriculum/refs/heads/git-libraries/shared/langs/en-us/pyret-files/libraries/algebra.arr")

ireland-flag = image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1rW_fyYPZC1XpkfXAowWKCb_hmG1NIlEU")

mauritius-flag = image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1wR6zWkbat409PjCQzb9xpfrZ8Dm_Jjfd")

# DO NOW: Click Run and type "netherlands" into the interactions window to see an image of the flag and look at the code below to answer questions with your class.

##################################################

# Code for the Flag of the Netherlands (also known as the Dutch flag)

# 1) Define the shapes we will use to make the flag, starting with a 300 x 200 background, and type them into the Interactions Area to see what they produce.
background-nl = rectangle(300, 200, "outline", "black")
red-stripe = rectangle(300, 200 / 3, "solid", "red")
blue-stripe = rectangle(300, 200 / 3, "solid", "dark blue")

# 2) Describe the image you want to compose:
# The flag is composed of 3 horizontal stripes of equal sizes: blue on the bottom, white in the middle and red on the top.

# 3) Define a variable "netherlands" to build the image, identifying what coordinates will correctly place the center of each piece.  

netherlands = 
  translate(blue-stripe, 150, 200 / 6, 
    translate(red-stripe, 150, 5 * (200 / 6),
      background-nl))
  
##################################################

# Getting ready to write Code for the Flag of Ireland...

# Type "ireland-flag" into the interactions window to see an image of the Irish flag.
# In what ways is the Irish flag similar to the flag of the Netherlands?
# In what ways is the Irish flag different from the flag of the Netherlands?

##################################################

#Code for the flag of Ireland

# 1) Define the shapes needed to make the Irish flag, starting with a 300 x 200 background, and type them into the Interactions Area to see what they produce.

# 2) Describe the image you intend to compose. Be as specific as possible.
#

# 3) Define a variable "ireland" to build the image of the Irish flag, identifying what coordinates will correctly locate the center of each piece.

##################################################

# Getting ready to write Code for the flag of Mauritius

# Type "mauritius-flag" into the interactions window to see an image of the flag of Mauritius.
# Is this flag more like the flag of Ireland or flag of the Netherlands?
# In what ways is this flag the same as that flag?
# In what ways is this flag different from that flag?

##################################################

#Code for the flag of Mauritius

# 1) Define the shapes needed to make the flag of Mauritius, starting with a 300 x 200 background, and type them into the Interactions Area to see what they produce.. 

# 2) Describe the image you intend to compose. Be as specific as possible.
#

# 3) Define a variable called "mauritius" to build the image of the flag of Mauritius, identifying what coordinates will correctly locate the center of each piece.

##################################################

# NOTE about Defining Variables: Once a variable is defined in the code, you cannot define it to mean something else.  This file already makes use of lots of colors of stripes. You will need to use slightly different variable names. For example, we suggest using: redstripe or red-rectangle instead of red-stripe.

# NOTE about Color - there are lots of kinds of greens and oranges. We found "forest green" to be the best match for Mauritius & Ireland and "dark orange" to be the best match for Ireland.

#################################################

# CHALLENGES : 
# You probably wrote code for "ireland" as if the background of this flag is white. Define a variable "ireland-green" that writes the code to produce an image of this flag starting with a green background.
# All of these flags are 300 x 200. Write new code to make one of the flags be 450 X 300.