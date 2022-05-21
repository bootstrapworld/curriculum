---

{layout="DS Title Slide"}

# Introduction to Data Science
<!--

-->
---
{layout="LaunchR"}
# Launch

@image{images/questions.png, 250, "Thought bubbles with question marks"}

- Look at the provided list of @opt-printable-exercise{pages/OpeningQuestions.adoc}, and take one minute to select a question that grabs your attention. 

- Arrange yourselves into groups based on the question you like, making sure that each group has between 2-5 people.

<!--
1. You know your students best! Use questions that are relevant to _them_.

2. We recommend posting these questions around the room, and having students physically move to the question they care about. 
-->
---
{layout="LaunchR"}
# Launch

@image{images/questions.png, 250, "Thought bubbles with question marks"}

- Have each person in the group quickly share their _gut reaction_: What do you think the answer is?
- _*After*_ everyone has shared, have each person share their reasoning.
- Do students in each group agree about the answers to their question?


<!--
Students are VERY likely to try and explain their reasonsing when they give their gut answers. This can taint the answers of other students in the group - emphasize that this is about exposing our "gut reaction" or bias.
-->
---
{layout="InvestigateR"}
# Investigate

What information would you collect to answer the question you selected? 

_Take 5 minutes to think about what information you would need to collect, to find the answer._


<!--
Common Misconception: Students may lean towards questions about _individuals_, instead of questions about what's true for a _group of individuals_ who vary from one to another. For example, instead of wondering what movie gets the highest rating, they should ask what's the typical rating for movies in a list, or how much those ratings tend to vary.

-->
---
{layout="Synthesize"}
# Synthesize

Share backs! 

- What were your gut reactions?
- Did the question wind up being too vague? What did you need to do to make it specific?
- What data would you gather?
- What, if anything, were you surprised about?

<!--

-->

---
{layout="Synthesize"}
# Synthesize

If we wanted to find out if small schools are better than big schools, for example, we might want to gather data on SAT scores, college acceptance, etc. Each of these is a *variable* in our dataset: any two schools we look at could _vary_ by each of them.{font-size:14pt}
* What is the most popular movie of all time? Is Climate Change real? How long do quarterbacks tend to stay in the league? Is Stop-and-Frisk racially biased?{font-size:14pt}
* We can't survey every school in the world, get data on every movie ever made, or every police action - but we can do an analysis for a _sample_ of them, and try to infer something about all of them as a whole.{font-size:14pt}

<!--

-->

---
{layout="Synthesize"}
# Synthesize

The process of learning from data is called @vocab{Data Science}. Data science techniques are used by scientists, business people, politicians, sports analysts, and hundreds of other different fields to ask and answer questions about data.

@ifproglang{pyret}{
We’ll use a @vocab{programming language} to investigate these questions. Just like any human language, programming languages have their own vocabulary and grammar that you will need to learn. The language you’ll be learning for data science is called Pyret.{font-size:14pt}

}
<!--

-->
---
{layout="LaunchR"}

# Meet the Animals!

@image{images/notice-and-wonder.png, 200, "Eyeglasses and Question Mark"}

Open the @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, Animals Spreadsheet} in a browser tab, or turn to @printable-exercise{pages/animals-dataset.adoc}.

<!--

-->
---
{layout="InvestigateR"}

# Meet the Animals!

@image{images/notice-and-wonder.png, 200, "Eyeglasses and Question Mark"}

Turn to @printable-exercise{pages/questions-and-column-descriptions.adoc} in your Student Workbook. What do you __Notice__ about this dataset? Write down your observations in the first column.

(Ignore the 3rd column for now!)
<!--

-->
---
{layout="InvestigateR"}

# Meet the Animals!

@image{images/notice-and-wonder.png, 200, "Eyeglasses and Question Mark"}

Sometimes, looking at data sparks questions. What do you __Wonder__ about this dataset, and why? Write down your questions in the second column.

<!--
Have students share back their noticings (statements) and wonderings (questions), and write them on the board.
-->
---
{layout="Investigate"}

# Meet the Animals!

- If you look at the bottom of the @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, spreadsheet file}, you’ll see that this document contains multiple sheets. One is called `"pets"` and the other is called `"README"`. Which sheet are we looking at?{font-size:16pt}

- Each sheet contains a table. For our purposes, we only care about the animals table on the `"pets"` sheet.{font-size:16pt}

<!--

-->
---
{layout="Investigate"}

# Meet the Animals!

Any two animals in our dataset may have different ages, weights, etc. Each of these is called a *variable* in the dataset. Data Scientists work with two broad kinds of data: Categorical Data and Quantitative Data. Sometimes it can be tricky to figure out if data is categorical or quantitative, because it depends on _how that data is being used!_


<!--

-->
---
{layout="Investigate"}

# Meet the Animals!

We use @vocab{Categorical Data} to answer “what kind?”, and @vocab{Quantitative Data} to answer "how much?".


<!--

-->
---
{layout="Investigate"}

# Meet the Animals!

@vocab{Categorical Data}
- Tell us “which one”
- Laws of arithmetic don’t make sense (“average ZIP code”, “biggest eye color”, etc.)

@vocab{Quantitative Data}
- Tell us “how much”
- Arithmetic makes sense! (“most money”, “average height”, etc.)

Complete @printable-exercise{pages/categorical-or-quantitative.adoc}. Be sure to discuss your answers with your partner or group!

_
<!--
* “Species” is a categorical variable, because we can ask questions like “which species does Mittens belong to?"
* We couldn’t ask if “cat is more than lizard” and it doesn’t make sense to "find the average ZIP code” in a list of addresses.
-->
---
{layout="Synthesize"}
# Synthesize

Data Science is all about using a *smaller sample of data to make educated guesses about a larger population*. It’s important to remember that tables are only a _sample_ of a larger population: this table describes some animals, but obviously it isn’t every animal in the world! Still, if we took the average age of the animals from this particular shelter, it might tell us something about the average age of animals from other shelters.

<!--

-->

---
@ifproglang{pyret}{

{layout="LaunchR"}
# Meet Pyret!

@image{images/pyret.png, 200, "Pyret Logo"}

- Open the @starter-file{animals} in a new tab. Click “Connect to Google Drive” to sign into your Google account. This will allow you to save Pyret files into your Google Drive.
- Next, click the "File" menu and select "Save a Copy". This will save a copy of the file into your own account, so that you can make changes and retrieve them later.

<!--
Students will need to use a valid Google credential to log in. They can use school accounts, personal accounts, YouTube accounts, etc. Some teachers create a single account for the whole class to share.
-->
---
{layout="InvestigateR"}
# Investigate

@image{images/pyret.png, 200, "Pyret Logo"}

- Click "Run" to tell Pyret to read the code on the left-hand side.
- On the right-hand side, type `animals-table` and hit the "Enter" or "Return" key.
- What happens?
- Look on the left-hand side of the screen. Where is Pyret getting `animals-table` from?
<!--

-->
---
{layout="Investigate"}
# Investigate

The first line on the lefthand side of the screen tells Pyret to use a file we've provided, which contain tools we’ll want to use for this course.

`use context shared-gdrive("Bootstrap-DataScience-...")`

<!--

-->
---	
{layout="Investigate"}
# Investigate

After that, we see a line of code that _defines_ `shelter-sheet` to be a spreadsheet. If you look carefully, you'll notice that the address listed here is the same address as the spreadsheet we just looked at! After that, we see the following code:

	# load the 'pets' sheet as a table called animals-table
	  animals-table = load-table: name, species, sex, age, fixed, legs, pounds, weeks
	    source: pets-sheet.sheet-by-name("pets", true)
	  end


<!--
The first line (starting with `#`) is called a _Comment_. Comments are notes for humans, which the computer ignores. The next line defines a new table called `animals-table`, which is loaded from the `shelter-sheet` defined above. We also create names for the columns: `name`, `species`, `sex`, `age`, `fixed`, `legs`, `pounds` and `weeks`. We could use any names we want for these columns, but it’s always a good idea to pick names that make sense!
-->

---
{layout="Investigate"}
# Investigate

*Even if your spreadsheet already has column headers, Pyret requires that you name them in the program itself.*

Every table is made of cells, which are arranged in a grid of rows and columns. _The first row and first column_ are special. The first row is called the @vocab{header row}, which gives a unique name to each variable (or “column”) in the table. The first column in the table is the @vocab{identifier column}, which contains a unique ID for each row. Often, this will be the name of each individual in the table, or sometimes just an ID number.{font-size:14pt}

---
{layout="Investigate"}

@table{8, header}
| name 		| species | sex 	 | age 	| fixed | legs 	| pounds| weeks
| "Sasha" 	| "cat"	  | "female" | 1 	| false | 4 	| 6.5 	| 3
| "Mittens" | "cat"   | "female" | 2 	| true 	| 4 	| 7.4 	| 1


Here is an example of a table with one header row and two data rows:

After the header, Pyret tables can have any number of @vocab{data rows}.
Each data row has values for every column variable (nothing can be left empty!). A table can have any number of data rows, including _zero_.{font-size: 14pt}

}

<!--
- How many variables are listed in the header row for the Animals Dataset? What are they called? What is being used for the identifier column in this dataset?
- Try changing the name of one of the columns, and click "Run". What happens when you try to  out the table?
- What happens if you remove a column from the list? Or add an extra one?
-->
---
{layout="Synthesize"}
# Synthesize

Once you know how to program, you can do a _lot_ with datasets:

- Sometimes they want to *filter* a table, showing only a few of the rows. For example we might only want to look at animals where `species` is equal to `"dog"`.{font-size:14pt}
- Or perhaps we want to *build* a column! For example, there could be a vaccination for all cats under the age of 3, and we want to add a `needs-vaccine` column that says `true` for cats under the age of 3, and `false` for everyone else.{font-size:14pt}

In this course, you'll be learning to do all three in Pyret: Display, Filter, and Build.


<!--

-->
---
}