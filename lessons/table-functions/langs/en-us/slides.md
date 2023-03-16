---
{layout="DS Title Slide"}
# Table Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Functions that Work on Rows

Load the @starter-file{table-functions}, go to the File menu, and click "Save a Copy".

This activity is about *reading carefully*, getting more comfortable with functions that work on rows.

Complete @printable-exercise{pages/row-and-function-definitions.adoc}.

<!--
-->
---
{layout="Investigate"}
# Functions that Work on Rows

Take a look at the three examples for `is-dog`. Each one shows us a different way of thinking about examples, in this case using a row that should return `false`:

```
examples:
  is-dog(cat-row) is false
  ...
  ...
end
```
**The first example** just tells us the answer we think we'll get back. `cat-row` is NOT a dog, so we expect `false`!

---
{layout="Investigate"}
# Functions that Work on Rows

```
examples:
  is-dog(cat-row) is false
  is-dog(cat-row) is "cat" == "dog"
  ...
end
```

**The second example** shows us some of the work involved: we know the species of the row is `"cat"`, and comparing that to the String `"dog"` will return `false`.

---
{layout="Investigate"}
# Functions that Work on Rows

```
examples:
  is-dog(cat-row) is false
  is-dog(cat-row) is "cat" == "dog"
  is-dog(cat-row) is cat-row["species"] == "dog"
end
```
**The third example** shows all the work: given the `cat-row`, we _look up_ the value in the `"species"` column and compare it to the String `"dog"`. 
The lookup returns `"cat"`, just like in our second example. And checking `"cat" == "dog"` gives us `false`, as in our first example.

<!--

-->

---
{layout="Investigate"}
# Functions that Work on Rows

```
examples:
  is-dog(cat-row) is false
  is-dog(cat-row) is "cat" == "dog"
  is-dog(cat-row) is cat-row["species"] == "dog"
end
```

**Add three _true_ examples for `is-dog`, this time using the `dog-row` you defined above.**

---
{layout="Synthesize"}
# Functions that Work on Rows

* Who can explain what `is-old` does?
* Who can explain what `lookup-name` does?
* Who can explain what `lookup-fixed` does?
* Who can explain what `label` does?
* Who can explain what `kilos` does?
<!--
Challenge them to use terminology like "looks up the value in the X column" when describing a lookup.
-->
---
{layout="Launch"}
# Ordering, Filtering, and Building

Row Actors, _Liiiiine up!_

(6-8 students, lined up facing the class)

* **Each of you represents a Row** in a table of students
* Together, you represent a _sample_ of the class, stored in a table.
* Like you, each student has columns like "First Name", "Last Name", "Birthday", "Favorite Food", etc.

<!--
Select 6-8 students, each of whom will represent a unique Row of a dataset called “Students.”  Arrange them in a line at the front of the room. Tell the class that you are going to select a volunteer who will play the role of… *Order*!
-->
---
{layout="Launch"}
# Ordering, Filtering, and Building

**A Table is a collection of Rows, and we can *order* a collection of Rows!**

We need a volunteer to _order the rows!_

_What are some ways we can sort this table?_
<!--
Announce to your volunteer "Sort the Rows by height, from smallest to largest!", and have them do it. Then announce to your volunteer "Sort the Rows by height, from largest to smallest!", and have them do it.

Solicit other ideas, like sorting by birthday. Try sorting in ascending **and** descending order!

Give the volunteer a round of applause!
-->
---
{layout="Launch"}
# Ordering, Filtering, and Building

**A Table is a collection of Rows, and we can *filter* a collection of Rows!**

We need a volunteer to _filter the rows!_

We could filter this table so that only students with glasses remain, or only students who like programming remain.

_What are some ways we could filter this table?_

<!--
select another volunteer who will play the role of… *Filter*!

Hand the volunteer a Function card from the @handout{pages/function-cards.adoc, Function Cards} set. Instruct them to read the card carefully, making sure they understand what it will do for each "Row" (student!) in the "Table" (line of students), but to keep that information a secret from the other students.

Explain to the class that the volunteer playing Filter will walk from one student to the next, referring to the function (on the card) in order to determine if each student should stand or sit.

Here’s how that might look if Filter chose an expression called `likes-pizza`.

* *Filter to Student 1:* Do you like pizza?
* *Student 1:* Yes
* *Filter:* Remain standing. (Student 1 remains standing.)
* *Filter to Student 2:* Do you like pizza?
* *Student 2:* No.
* *Filter:* Sit down. (Student 2 sits.)

Have your Filter volunteer go through all their peers, applying their card to each one.

AFTER they are done, ask: "Based on who sat and who stayed, what was on the card?"

-->
---
{layout="Investigate-DN"}
# Ordering, Filtering, and Building

Pyret Tables have their own functions for sorting, filtering, and more!

Complete questions 1-6 on @printable-exercise{exploring-functions.adoc}

1. Who can explain how the `sort` function works?
2. Does sorting the `animals-table` produce a _new_ table, or change the existing one? 
3. How could we test this?

<!--
*ANSWERS:*
1. `sort` consumes a Table, a String (the name of the column by which to sort) and a Boolean (`true` for ascending, `false` for descending), and sorts the rows according to that column.
2. It creates a new one
3. Sort the table, then evaluate `animals-table` and see if it stayed sorted
-->
---
{layout="Investigate-DN"}
# Ordering, Filtering, and Building

* Complete questions 7-13 on @printable-exercise{exploring-functions.adoc}
* Find the contract for `filter` in your Contracts page. 

1. What is its Domain?
2. How does the `filter` function work?
3. Does sorting the `animals-table` produce a _new_ table, or change the existing one?

<!--
**ANSWERS**
1. `filter` takes a Table, and a _Boolean-producing function_
2. It produces a new table containing only rows for which the function returns `true`.
3. It creates a new one
-->
---
{layout="Investigate-DN"}
# Ordering, Filtering, and Building

`filter :: (t :: Table, test :: (Row ->Boolean)) -> Table`{style="font-size:16pt;font-weight:bold"}

`filter` consumes a Table and a _Boolean-producing function_, and walks through the table applying it to each Row. 

If the function produces `true`, the Row is copied to a new Table. 

When the last Row is visited, the function produces the new Table.

---
{layout="Investigate-DN"}
# Ordering, Filtering, and Building

* Complete questions 14-16 on @printable-exercise{exploring-functions.adoc}
* Find the contract for `build-column` in your Contracts page. 

1. What is its Domain?
2. How the `build-column` function work?
3. Does sorting the `animals-table` produce a _new_ table, or change the existing one?

<!--
**ANSWERS**
1. `build-column` takes in a Table, a String and a _function_
2. It produces a new table with an extra column, using the String for the column title, and fills in the values by applying the function to every Row.
3. It creates a new one
-->
---
{layout="Investigate-DN"}
# Ordering, Filtering, and Building

`build-column :: (t::Table, col::Str, f::(Row->Any)) -> Table`{style="font-size:16pt;font-weight:bold"}

`build-column` consumes a Table, a String and a _function_, and walks through the table applying it to each Row. 

It produces a new table with an extra column, using the String for the column title, and fills in the values by applying the function to every Row.

When the last Row is visited, the function produces the new Table.

---
{layout="Investigate"}
# Ordering, Filtering, and Building

Optional: Want some more practice? Complete @opt-printable-exercise{pages/what-table-do-we-get.adoc}.


---
{layout="Synthesize"}
# Ordering, Filtering, and Building

Being able to define functions and use them with Table Functions is a _huge_ upgrade in our ability to analyze data!

- Suppose we wanted to determine whether cats or dogs get adopted faster. How might using the `filter` function help?
- If the shelter is purchasing food for older cats, what filter would we write to determine how many cats to buy for?

<!--
**Common Misconceptions**
*Students often think that these functions _change_ the table!* In Pyret, all table functions produce a _brand new table_. If we want to save that table, we need to define it. For example: `cats = filter(animals-table, is-cat)`.
-->
---
{layout="Synthesize"}
# Ordering, Filtering, and Building

- A dataset from Europe might list everything in metric (centimeters, kilograms, etc), so we could build a column to convert that to imperial units (inches, pounds, etc).
- A dataset about schools might include columns for how many students are in the school and how many of those students identify as multi-racial. But when comparing schools of different sizes, what we really want is a column showing what _percentage_ of students identify as multi-racial. We could use `build-column` to compute that for every row in the table.
- **What are some ways you might want to filter _your_ dataset?**
- **What are some columns you might want to build for _your_ dataset?**
