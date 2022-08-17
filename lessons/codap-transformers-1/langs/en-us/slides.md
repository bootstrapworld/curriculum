---
{layout="DS Title Slide"} 
# Introduction to Transformers: Sort

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Sorting by Changing a Table

Open the @starter-file{animals} in CODAP. How many animals' names start with the letter M? What would make it easier to figure out how many animals' names start with the letter M?

---
{layout="InvestigateC"}
# Sorting by Changing a Table

Let's sort the animals alphabetically by name and see if we get the same answer as we did before!

@image{images/sort-ascending-by-name.png, "how to sort the animals alphabetically by name in CODAP"}{width="650"}


---
{layout="Investigate"}
# Sorting by Changing a Table

- Can you sort the animals by age, from youngest to oldest?
- How about from heaviest to lightest?
- Now sort the animals table by how long it took for each animal to be adopted, in ascending order.

---
{layout="Investigate}
# Sorting by Changing a Table

Now, go to the hamburger menu in the upper left corner and select "Save" from the drop-down menu. 

You will be prompted to login to Google and enter your login credentials, linking CODAP with their Google Drive. 

After saving the sorted table, close CODAP.

<!--
You might even pretend that the online portion of class is over; you're about to do a bit of performing for students in order to illustrate a point.

Now: dramatically tell students that you forgot something! You REALLY need to know which animal was the third animal on the original table. Direct students to reopen the saved  file (they can access it by selecting the hamburger icon again). Tell them they must _undo_ any sorting and then consult the original list.

Students will discover that they in fact _cannot_ undo their actions, thereby uncovering one of the primary limitations of this type of table transformation.
-->


---
{layout="Investigate"}
# Sorting by Changing a Table

We _cannot_ undo actions when we have actually modified a table! This is a primary limitation of the type of table transformation we have just practiced.


---
{layout="Synthesize"}
# Sorting by Changing a Table

- Does sorting the Animals Dataset produce a _new_ table, or change the existing one? How do you know?

- Can you think of another scenario (like the one manufactured, above) when the inability to revert to the original table might cause problems?


<!-- Sorting the dataset alters the existing table. No new tables appear. Whenever we experiment with data, there is a chance we will want to make comparisons to the original dataset.
-->

---
{layout="Launch"}
# Sorting with Transformers!

When we apply Transformers, we create _copies_ of the original dataset. The original dataset is always preserved - meaning there is no need to undo their actions, or to re-open a saved dataset to consider a different configuration. 

The Transformers plugin enables easy, low-stakes "what if?" exploration that encourages open-ended investigation.

---
{layout="LaunchC"}
# Sorting with Transformers!

- Login to the @starter-file{animals} in CODAP.
- Access the Transformers plugin.

@image{images/plugins-location.png,"A screenshot of CODAP, showing where the Transformers plugin can be found"}{width="350"}


---
{layout="Launch"}
# Sorting with Transformers!

- Explore the different Transformers available, especially those categorized under “Construction.”
- What do you Notice? What do you Wonder?

<!--
_Students might notice the following: there are Transformers for constructing, measuring the center, aggregating, summarizing, restructuring, tidying, and copying; I often need to provide a dataset; sometimes I see contracts; sometimes I am asked to provide formulas._
-->
---
{layout="InvestigateR"}
# Sorting with Transformers!

Another way to sort is with the Sort _Transformer_ (pictured below), which will create a _copy_ of the Animals dataset in which the animals are organized alphabetically by name.

Complete the @printable-exercise{pages/codap-sort-transformer.adoc} worksheet, which will walk you through creating, applying, and saving a `Sort` Transformer.

@image{images/sort-transformer.png,"An image of the Sort Transformer"}{width="550"}


<!--
    Initially, students might question the value of using a Transformer to sort. At first, using the Transformer will quite likely feel more laborious than using the sort functionality embedded in CODAP. Encourage students to experiment with all of the functionality that the Transformers offer; invite them to be curious and playful as they work, to consider the possibilities afforded by Transformers. For instance, why might it be useful to name and save a Transformer?
-->

---
{layout="Investigate"}
# Sorting with Transformers!

New and modified tables created by Transformers are automatically saved.  

Each new table is titled first with the Transformer name, then the name of the dataset (in parentheses), followed by a number in curly braces at the end to indicate how many times a Transformer has been applied. You may rename saved tables, if you’d like. 

Each time you apply a saved Transformer, the _new_ datasets that are created will appear in the Transformer's "Dataset to sort" drop-down menu.

---
{layout="Synthesize"}
# Sorting with Transformers!


- Does the Transformer `Sort` produce a _new_ table, or change the existing one?
- You've now learned two different strategies for sorting a column of a table. What do the two strategies have in common? How are they different?
- When would it be better to use the `Sort` Transformer to make a new Table, instead of changing the table? When might it be worse?


<!--
- Does the Transformer `Sort` produce a _new_ table, or change the existing one?
** _The `Sort` Transformer produceds a new, modified copy of the original table._
- You've now learned two different strategies for sorting a column of a table. What do the two strategies have in common? How are they different?
** _Transformers can be named and saved for future use. Transformers create a modified copy of a table rather than altering the original dataset._
- When would it be better to use the `Sort` Transformer to make a new Table, instead of changing the table? When might it be worse?
** _If we are experimenting with a dataset and want to preserve the original table, it would make more sense to use a Transformer._
-->