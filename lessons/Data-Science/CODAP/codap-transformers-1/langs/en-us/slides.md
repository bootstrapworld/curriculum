---
{layout="DS Title Slide"} 
# Introduction to Transformers: Filter

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Filtering Tables

What if the shelter needs to look at some information about only the dogs, or only the animals that have been fixed? There are many situations where, given a table, we want to _filter out_ some of the rows and only look at a specific group from that table.

---
{layout="Launch"}
# Filtering Tables

- Open @starter-file{animals}.
- Using what you've learned about deleting rows, create a table that includes _only dogs_.
- Raise your hand when you are finished. How many dogs are in our dataset?


<!--
** _In case students need a reminder, they can select the green index number for a row (left-most column) and then select "Delete Case" from the drop-down menu that appears._
-->


---
{layout="Launch"}
# Filtering Tables

Can you summarize the work that you just completed?

<!--
Invite a few students to share. When possible, urge students to break down their process into a series of concrete steps (_see below_). This will prime them to better understand exactly what is going on in CODAP when the filtering happens nearly instantaneously (as will be the case in the subsequent portion of this lesson!).
-->


---
{layout="Launch"}
# Filtering Tables

To create a table with only dogs, here's what we did:

- We looked at the first row.
- If `Species = "dog"` was TRUE we kept the row. If it was FALSE we got rid of it.
- We moved on to the second row.
- Again, we determined if `Species = "dog"` was TRUE or FALSE.
- We repeated this process over and over, until we had inspected the entire table.

---
{layout="Investigate"}
# Filtering Tables

- Did this feel efficient or like a good use of our time?
- Did anyone wish for a simpler way? 
- Did anyone see room for mistakes to get made? 

<!-- 
Some students may have deleted a dog row by accident! Or initially missed a cat row.
-->


---
{layout="Investigate}
# Filtering Tables

- Now I want everyone to create _two_ filtered tables: one table with just dogs, and one table with all pets that weigh less than 5 pounds.
- I'd like these tables to exist side-by-side within the same CODAP file, so we can discuss them together.

<!--
    ** _Allow students to give this task a try, but cut them off after a few minutes._

Students will likely run into major difficulties. Some may attempt to "undo" previous actions; some may hit "refresh" to reload the original file (effective, if they haven't saved yet!); some may attempt to create a new blank table within the same file that they repopulate manually.

The goal here is to manufacture a situation that will propel students to see the need for an as-yet unfamiliar tool. This tool will require a bit of practice to master, but will enable much more efficient data manipulation!
-->

---
{layout="Synthesize"}
# Filtering Tables

- What problems did you encounter when trying to manually filter the Animals dataset?
- What strategies did you try in order to create two side-by-side filtered tables, one with just dogs and one with all pets that weigh more than 50 pounds?

---
{layout="Launch"}
# Filtering Tables with Transformers

Enter: _Transformers_!

When we apply a Transformer, that Transformer creates a _copy_ of the original dataset with whatever modifications the we have specified. We just need to provide the Transformer with some key information, and select `Apply.`

The original dataset is always preserved!


---
{layout="LaunchC-DN"}
# Filtering Tables with Transformers

- Open @starter-file{animals}.
- Access "Plugins," then select "Transformers."
- Find _three_ Transformers where you think you can guess what they do. What are they?

@image{images/plugins-location.png}

<!--
    Invite students to share their observations. Build enthusiasm for the new possibilities that are now available!
-->


---
{layout="Investigate-DN"}
# Filtering Tables with Transformers

- Open the @starter-file{animals}.s
- Complete the worksheet @printable-exercise{pages/codap-filter-transformer.adoc} to explore the functionality of the `Filter` Transformer. We will pause to work on questions 4 and 5 together.

@image{images/filter-ui-annotated.png}

<!--
    Questions 4 and 5 are all about the @vocab{contract} and @vocab{purpose statement} for this expression. You will want to devote a few minutes to discussing these important concepts.
-->



---
{layout="Investigate"}
# Filtering Tables with Transformers

Questions 4 and 5 are all about the @vocab{contract} for the expression.

A @vocab{contract} is a statement of the @vocab{domain} (input) and @vocab{range} (output) of an expression. Contracts don’t tell us specific inputs. They tell us the data type of input the expression needs.

Why does this contract make sense?

<!--
 For example, a Contract wouldn’t say that addition requires "3 and 4". Addition works on more than just those two inputs! Instead, it would tells us that addition requires "two Numbers". When we use a Contract, we plug specific numbers or strings into the expression.
-->

---
{layout="Investigate"}
# Filtering Tables with Transformers

Question 6 is all about the @vocab{Purpose Statement} for the expression.

A @vocab{Purpose Statement} is a way of describing what an expression does. Purpose Statements in CODAP begin with either _"Checks..."_  or _"Computes..."_. For example, "Checks the row to see whether the species is dog", or "Computes the sum of `Age` and 2."

Look at Q6. What would be a good purpose statement for the expression `filter-is-dog`?


---
{layout="Investigate"}
# Filtering Tables with Transformers

As you complete page, consider: 

- What happens if you forget to select a dataset from the drop-down menu?
- When does the text color change?
- Does CODAP mind if spelling is off?
- What happens when students save a Transformer?
- Can you predict any value in saving a Transformer?
- Why might a clear, specific purpose statement be useful?


<!--
- What happens if they forget to select a dataset from the drop-down menu?
** _An error message appears: "Please choose a dataset to transform."_
- When does the text color change?
** _Strings are brown. When we enter an attribute, that text turns pink._
- Does CODAP mind if spelling is off?
** _CODAP will not recognize a misspelled attribute; an error message will appear saying the attribute is unrecognized._
- What happens when students save a Transformer?
** A new box appears with the Transformer's name at the top.
- Can you predict any value in saving a Transformer?
** _If I save a Transformer, I can use it whenever I'd like!_
- Why might a clear, specific purpose statement be useful?
** _If I save my Transformer, I will want to easily recognize what it does to the dataset._

Students should observe that new and modified tables created by Transformers are automatically saved. Each new table is titled first with the Transformer name, then the name of the dataset (in parentheses). Students may rename saved tables, if they’d like. Highlight for students that, each time they apply a saved Transformer, the _new_ datasets that are created will appear in the Transformer's "Dataset to sort" drop-down menu.
-->


---
{layout="Synthesize"}
# Filtering Tables with Transformers



- What is the role of the `Filter` Transformer? How is its role unique from that of the Transformer's _expression_?
- Suppose we wanted to determine whether cats or dogs get adopted faster. How might using the `Filter` Transformer help?
- If the shelter is purchasing food for older cats, what `Filter` Transformer would we create to determine how many cats to buy for?
- How is saving a Transformer different from saving a dataset?



<!--
- What is the role of the `Filter` Transformer? How is its role unique from that of the Transformer's _expression_?
** _The `Filter` Transformer walks through the table's rows, applying the expression to each row - then producing a new table containing only rows for which the expression returns `true`._
- Suppose we wanted to determine whether cats or dogs get adopted faster. How might using the `Filter` Transformer help?
** _We could use the `Filter` Transformer to produce two new tables - one with only cats, and one with only dogs. We could then analyze and compare the weeks to adoption for each species._
- If the shelter is purchasing food for older cats, what `Filter` Transformer would we create to determine how many cats to buy for?
** _We would filter out cats where `Age (years) > 5`._
- When applying Transformers, what did you notice about how transformed datasets were named?
- How is saving a Transformer different from saving a dataset?
-->