@slidebreak
{layout="DS Title Slide"}

# Introduction to Data Science
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="LaunchR"}
# Questions that Matter

@image{images/questions.png, 250}

- Look at the provided list of @handout{pages/OpeningQuestions.adoc}, and take one minute to select a question that grabs your attention. 

- Arrange yourselves into groups based on the question you like, making sure that each group has between 2-5 people.

<!--
1. You know your students best! Use questions that are relevant to _them_.

2. We recommend posting these questions around the room, and having students physically move to the question they care about. 
-->
@slidebreak
{layout="LaunchR"}
# Questions that Matter

@image{images/questions.png, 250}

- Have each person in the group quickly share their _gut reaction_: What do you think the answer is?
- _*After*_ everyone has shared, have each person share their reasoning.
- Do students in each group agree about the answers to their question?


<!--
Students are VERY likely to try and explain their reasoning when they give their gut answers. This can taint the answers of other students in the group - emphasize that this is about exposing our "gut reaction" or bias.
-->
@slidebreak
{layout="InvestigateR"}
# Questions that Matter

@image{images/questions.png, 250}

What information would you collect to answer the question you selected? 

_Take 5 minutes to think about what information you would need to collect, to find the answer._


<!--
Common Misconception: Students may lean towards questions about _individuals_, instead of questions about what's true for a _group of individuals_ who vary from one to another. For example, instead of wondering what movie gets the highest rating, they should ask what's the typical rating for movies in a list, or how much those ratings tend to vary.

-->
@slidebreak
{layout="SynthesizeR"}
# Questions that Matter

@image{images/questions.png, 250}

Share back! 

- What were your gut reactions?
- Did the question wind up being too vague? What did you need to do to make it specific?
- What data would you gather?
- What, if anything, were you surprised about?

<!--

-->

@slidebreak
{layout="Synthesize"}
# Questions that Matter

* If we wanted to find out if small schools are better than big schools, for example, we might want to gather data on SAT scores, college acceptance, etc. Each of these is a *variable* in our dataset: any two schools we look at could _vary_ by each of them.

* We can't survey every school in the world (or get data on every movie ever made, or every police action!) but we can analyze a _sample_ of them, and try to infer something about all of them as a whole.

* These questions quickly turn into a discussion about data -- how you assess it, how you interpret the results, and what you can _infer_ from those results.

<!--

-->

@slidebreak
{layout="Synthesize"}
# Questions that Matter

The process of learning from data is called @vocab{Data Science}. Data science techniques are used by scientists, business people, politicians, sports analysts, and hundreds of other different fields to ask and answer questions about data.

@ifproglang{pyret}{
We’ll use a @vocab{programming language} to investigate these questions. Just like any human language, programming languages have their own vocabulary and grammar that you will need to learn. The language you’ll be learning for data science is called Pyret.

}
<!--

-->
@slidebreak
{layout="LaunchR"}
# Meet the Animals!

@image{images/notice-and-wonder.png, 200}

* Open the @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, Animals Spreadsheet} in a browser tab, or turn to @dist-link{courses/data-science/back-matter/pages/animals-dataset.adoc, Animals Table}.
* What do you __Notice__ about this dataset? 
* Turn to @printable-exercise{pages/questions-and-column-descriptions.adoc}. 
* Write down your observations in the first column.

<!--

-->
@slidebreak
{layout="InvestigateR"}
# Meet the Animals!

@image{images/notice-and-wonder.png, 200}

Sometimes, looking at data sparks questions. 

* What do you __Wonder__ about this dataset, and why? 
* Write down your questions in the second column.

<!--
Have students share back their noticings (statements) and wonderings (questions), and write them on the board.
-->
@slidebreak
{layout="Investigate"}
# Meet the Animals!

- If you look at the bottom of the @link{https://docs.google.com/spreadsheets/d/1VeR2_bhpLvnRUZslmCAcSRKfZWs_5RNVujtZgEl6umA/edit?usp=sharing, spreadsheet file}, you’ll see that this document contains multiple sheets. One is called `"pets"` and the other is called `"README"`. Which sheet are we looking at?

- Each sheet contains a table. For our purposes, we only care about the animals table on the `"pets"` sheet.

<!--

-->
@slidebreak
{layout="Investigate"}
# Meet the Animals!

Any two animals in our dataset may have different ages, weights, etc. Each of these is called a *variable* in the dataset. 

Data Scientists work with two broad kinds of data: **Categorical Data** and **Quantitative Data.**

Sometimes it can be tricky to figure out if data is categorical or quantitative, because it depends on _how that data is being used!_

<!--

-->
@slidebreak
{layout="Investigate"}
# Meet the Animals!

@vocab{Quantitative Data}
- Tell us “how much?”
- Arithmetic makes sense! (“most money”, “average height”, etc.)

@vocab{Categorical Data}
- Tell us “which kind?”
- Arithmetic doesn’t apply (“average ZIP code?”, “biggest eye color?”, etc.)

Complete @printable-exercise{pages/categorical-or-quantitative.adoc}. Be sure to discuss your answers with your partner or group!

<!--
* “Species” is a categorical variable, because we can ask questions like “which species does Mittens belong to?"
* We couldn’t ask if “cat is more than lizard” and it doesn’t make sense to "find the average ZIP code” in a list of addresses.
-->
@slidebreak
{layout="Synthesize"}
# Meet the Animals!

Data Science is all about using a *smaller sample of data to make educated guesses about a larger population*. 

It’s important to remember that tables are only a _sample_ of a larger population: this table describes some animals, but obviously it isn’t every animal in the world! 

Still, if we took the average age of the animals from this particular shelter, it might tell us something about the average age of animals from other shelters.

<!--

-->

@slidebreak
@ifproglang{pyret}{

{layout="LaunchR"}
# Meet Pyret!

@image{images/pyret.png, 200}

- Open the @starter-file{animals} in a new tab. Click “Connect to Google Drive” to sign into your Google account. This will allow you to save Pyret files into your Google Drive.
- Next, click the "File" menu and select "Save a Copy". **This will save a copy of the file into your own account, so that you can make changes and retrieve them later.**

<!--
Students will need to use a valid Google credential to log in. They can use school accounts, personal accounts, YouTube accounts, etc. Some teachers create a single account for the whole class to share.
-->
@slidebreak
{layout="InvestigateR"}
# Meet Pyret!

@image{images/pyret.png, 200}

- Click "Run" to tell Pyret to read the code on the left-hand side.
- On the right-hand side, type `animals-table` and hit the "Enter" or "Return" key.
- What happens?
- Look on the left-hand side of the screen. Where is Pyret getting `animals-table` from?
<!--

-->
@slidebreak
{layout="Investigate"}
# Meet Pyret!

The first line on the left-hand side of the screen tells Pyret to use a file we've provided, which contain tools we’ll want to use for this course.

`use context shared-gdrive("Bootstrap-DataScience-...")`{style="font-size:16pt"}

<!--

-->
---	
{layout="Investigate"}
# Meet Pyret!

After that, we see a line of code that _defines_ `shelter-sheet` to be a spreadsheet:

`shelter-sheet = load-spreadsheet("https://docs.google.com....")`{style="font-size:14pt"}

If you look carefully, you'll notice that the address listed here is the same address as the spreadsheet we just looked at! 

---	
{layout="Investigate"}
# Meet Pyret!

After that, we see the following code:{style="font-size:16pt"}

```{style="font-size:16pt"}
# load the 'pets' sheet as a table called animals-table
animals-table = load-table: name, species, sex, age, fixed, legs, pounds, weeks
  source: shelter-sheet.sheet-by-name("pets", true)
end
```
* The first line (starting with `#`) is called a _Comment_.{style="font-size:16pt"}
* The next line defines a new table called animals-table, (loaded from the shelter-sheet!) and defines column names.{style="font-size:16pt"}
* Even if your spreadsheet already has column headers, **Pyret requires that you name them in the program itself**.{style="font-size:16pt"}

<!--
The first line (starting with `#`) is called a _Comment_. Comments are notes for humans, which the computer ignores. The next line defines a new table called `animals-table`, which is loaded from the `shelter-sheet` defined above. We also create names for the columns: `name`, `species`, `sex`, `age`, `fixed`, `legs`, `pounds` and `weeks`. We could use any names we want for these columns, but it’s always a good idea to pick names that make sense!
-->

@slidebreak
{layout="Investigate"}
# Meet Pyret!

Every table is made of cells, which are arranged in a grid of rows and columns. _The first row and first column_ are special! 

The first row is called the @vocab{header row}, which gives a unique name to each variable (or “column”) in the table. 

The first column in the table is the @vocab{identifier column}, which contains a unique ID for each row. Often, this will be the name of each individual in the table, or sometimes just an ID number.

@slidebreak
{layout="InvestigateC"}
# Meet Pyret!

Here is an example of a table with one header row and two data rows:

@table{8, header}
| name 		| species | sex 	 | age 	| fixed | legs 	| pounds| weeks
| "Sasha" 	| "cat"	  | "female" | 1 	| false | 4 	| 6.5 	| 3
| "Mittens" | "cat"   | "female" | 2 	| true 	| 4 	| 7.4 	| 1

After the header, Pyret tables can have any number of @vocab{data rows}.
Each data row has values for every column variable (nothing can be left empty!). A table can have any number of data rows, including _zero_.{style="font-size: 18pt"}



<!--
- How many variables are listed in the header row for the Animals Dataset? What are they called? What is being used for the identifier column in this dataset?
- Try changing the name of one of the columns, and click "Run". What happens when you try to  out the table?
- What happens if you remove a column from the list? Or add an extra one?
-->
@slidebreak
{layout="Synthesize"}
# Synthesize

Once you know how to program, you can do a _lot_ with datasets:

- Data Scientists *display* tables as all kinds of charts and graphs. For example, we might want to make a pie chart showing how many animals of each species we have.{style="font-size:14pt"}
- Sometimes they want to *filter* a table, showing only a few of the rows. For example we might only want to look at animals where `species` is equal to `"dog"`.{style="font-size:14pt"}
- Or perhaps we want to *build* a column! For example, there could be a vaccination for all cats under the age of 3, and we want to add a `needs-vaccine` column that says `true` for cats under the age of 3, and `false` for everyone else.{style="font-size:14pt"}

**In this course, you'll learn to do all three.**

<!--

-->
}
