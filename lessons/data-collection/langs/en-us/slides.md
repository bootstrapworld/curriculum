---
{layout="DS Title Slide"}
# Collecting Data

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# When Data Gets Dirty!

There are lots of reasons to gather data:

* A company might want to survey its customers to see if they are happy with the product.{style="font-size:16pt"}
* We might want to gather data on plant growth to see whether a plant grows faster with a lot or a little sun.{style="font-size:16pt"}
* The CDC might gather data on symptoms to see how serious a disease is
* An airline could gather data on fuel usage to see which airplane routes are the most efficient.{style="font-size:16pt"}
* We might want to gather data on our friends to see what's stressing them out, or our classmates to see which teachers are the easiest!{style="font-size:16pt"}

<!--

-->
---
{layout="Launch"}
# When Data Gets Dirty!

**Not all data is created equal.** 

Only _clean_ data can be properly processed and analyzed.

- What does it mean for data to be clean? 
- What does it mean for data to be dirty?

<!--

-->
---
{layout="Investigate"}
# When Data Gets Dirty!

Humans make mistakes, and that can happen when we are collecting data or entering data. Either way, the result is dirty data...

**There is a _lot_ of dirty data out there that Data Scientists have to deal with!**

Open the @starter-file{fav-desserts} and answer the questions on @printable-exercise{survey-analysis.adoc}.

---
{layout="Synthesize"}
# When Data Gets Dirty!

* What were some ways that the data was "dirty"?
* What ideas do you have for how the survey designers could have solicited better data?

---
{layout="Launch"}
# Cleaning Data

Sometimes data is so "dirty" that it can't even be processed by tools like Pyret! Here are four ways that data can be dirty:

(1) **Missing Data** - A column containing some cells with data, but some cells left blank.

(2) **Inconsistent Types** - A column where some values have one data type and some cells have another. For example, a `years` column where almost every cell is a Number, but one cell contains the string `"5 years old"`.

---
{layout="Launch"}
# Cleaning Data

Sometimes data is so "dirty" that it can't even be processed by tools like Pyret! Here are four ways that data can be dirty:

(3) **Inconsistent Units** - A column where the data types are the same, but they represent different units. For example, a `weight` column where some entries are in pounds but others are in kilograms.

(4) **Inconsistent Naming** - Inconsistent spelling and capitalization for entries lead to them being counted as different. For example, a species column where some entries are "cat" and others are "Cat" will not give us a full picture of the cats.

---
{layout="Launch"}
# Cleaning Data

Open @link{https://docs.google.com/spreadsheets/d/1wLPE6i4P7TMWxpcOnOHGMWBNYopwHf7GpdZMnbgosqA/edit?usp=sharing, New Animals!} and complete @printable-exercise{dirty-data.adoc} in pairs or small groups.

Be ready to discuss your answers with the class!

---
{layout="Investigate"}
# Cleaning Data

- What would happen if you tried to make a pie chart from a categorical column, but three of the cells were blank?
- What would happen if you tried to take a histogram of a quantitative column, but half the cells were Strings instead of Numbers?
- What would happen if you made a scatter plot examining `pounds` v. `weeks`, but two of the cells in the `weeks` column were actually showing the _days_ to adoption?

<!--
"Why can't we just use spreadsheets?"

THIS is a great slide to answer that question. Pyret is pretty smart, and does a lot of checking to make sure data is clean before analyzing it. But many tools - like Google Sheets, Microsoft Excel, etc. - don't. Suppose you tried to analyze this data in a tool that doesn't do all this checking...

-->
---
{layout="Investigate"}
# Cleaning Data

Sometimes, there's an easy way to clean up the data. Chanel and Bibbles have String values for their weights, but we can easily change them to be numbers representing pounds.

But what if the data is missing, like the `weight` for our dogs? Or what if it's weird data that we know is wrong but we don't know how to fix it, like the `time to adoption` for Boss and Porche?

---
{layout="Investigate"}
# Cleaning Data

**It's never as simple as just deleting dirty rows!**

Suppose we decided to delete all the rows with blank cells, removing Mona, Rover, Susie Q, and Happy. How might that bias our analysis? _Removing all the dogs makes it look like this shelter doesn't have any!_

Suppose we decided to delete all the rows with weird data, having inconsistent types or units we don't recognize? We could delete Boss and Porche, but how might that bias our analysis? _Removing all the female lizards might affect the kind of food or habitat the shelter needs to buy!_

---
{layout="Synthesize"}
# Cleaning Data

Imagine a dataset about people in your town, which asks about height, religion, race, address, and job.

1. If unemployed people leave the `job` field blank, why would it be a problem to delete those rows?{style="font-size:16pt"}
2. Suppose the `height` field is full of junk data. Some people leave it blank, some write their height in inches, some write it in centimeters, some write a combination like "5 feet, 9 inches" and others write "I'm taller than my brother." Can we just delete all those rows?{style="font-size:16pt"}
3. Suppose the `race` question had people choose from a list. What might happen to our data if the list left out an option for one group of people?{style="font-size:16pt"}

---
{layout="Launch"}
# Data Hygiene

**The way we ask questions - and check responses - plays a big role in how clean our data is.**

A person's height is generally the same as their "wingspan" (the length from fingertip to fingertip). 

Suppose we want to test this for ourselves, by surveying students at a school...

---
{layout="Launch"}
# Data Hygiene

Suppose we want to test this for ourselves, by surveying students at a school...

@starter-file{bad-survey} was _intentionally designed to gather bad data!_ Can you see anything wrong with it?

Complete @printable-exercise{bad-survey.adoc} in pairs or small groups.

---
{layout="LaunchR"}
# Data Hygiene

@image{images/required.png} 

Most survey tools include advanced options to help Data Scientists get data that is as clean possible. Here's an overview of those tools:

- *Required Questions* - By making a question "required", we can eliminate missing data and blank cells. Which questions on the survey should be required?
---
{layout="LaunchR"}
# Data Hygiene

@image{images/format.png}

- **Question Format** - When you have a fixed number of categories, a dropdown can ensure that everyone selects one - and only one! - category. Questions B and C might be good candidates for dropdowns. Question C is especially bad, because it allows respondents to select multiple grades!

---
{layout="LaunchC"}
# Data Hygiene

@image{images/description.png}

- **Descriptive Instructions** - Sometimes it's helpful to just add instructions! This can remind respondents to use inches instead of centimeters, for example, or give them extra guidance to answer accurately.

---
{layout="LaunchR"}
# Data Hygiene

@image{images/validate.png} 

- **Adding Validation** - Most survey tools allow you to specify whether some data should be a number or a string, which helps guard against inconsistent types. You can even specify parameters for the data as well, such as "strings that are email addresses", or "numbers between 24 and 96". Questions B and E would benefit from some validation. 

@image{images/validation.png, 600}

---
{layout="Investigate"}
# Data Hygiene

- @link{https://docs.google.com/forms/d/1gm-3Ts8LTVkrWBZmDneWc36HxkU8tzcmh_yEt7mbWPg/copy, Make a copy of the bad survey}, and work in pairs or small groups to fix it!
- Be ready to share your fixes with the class.

---
{layout="Synthesize"}
# Data Hygiene

- Have you ever taken a survey, where the answer you want to give isn't listed?
- Have you ever taken a survey, where you just _know_ the questions are going to result in bad data?
- When someone conducts a survey and provides a dataset from it, is it important for them to share the survey? Why or why not?
- When someone shares a dataset that they've cleaned or modified in some way, is it important for them to share their modifications? Why or why not?

---
{layout="Supplemental"}
# Additional Practice

If you are interested in digging into the idea that there's lots of important data that's not being collected, we recommend reading @opt-online-exercise{https://www.nytimes.com/2017/05/10/opinion/the-census-wont-collect-lgbt-data-thats-a-problem.html, "The Census Won't Collect L.G.B.T. Data. That's a Problem"} with your class.

<!--

-->
