---

{layout="DS Title Slide"}

# Row and Column Lookups
<!--

-->
---
{layout="Launch"}
# Row Lookups

Open your saved Animals Starter File (or make a new @starter-file{animals} copy), and click “Run”.

Sometimes we have a value that we want to use again and again, and it makes sense to define a name for it. 

<!--

-->
---
{layout="Launch"}
# Row Lookups

Every definition includes a _name_ and a _value_. In the code below, we have definitions for a String, a Number and an Image.
```
  name = "Flannery"
  age = 16
  logo = star(50, "solid", "red")
```

- What are the names given in each of these? _name, age, and logo_
- What are the values? _the String "Flannery", the Number 16, and an Image of a solid red star_

<!--

-->
---
{layout="InvestigateR"}
# Row Lookups

@image{images/AskQuestions.png, "Ask Questions icon", 100}

How many rows do we need to answer a Lookup question?

Let's explore what code can we write, to let us define a single row.


<!--
(Make sure sure students understand we only need one row!)

-->
---
{layout="InvestigateR"}
# Row Lookups

@image{images/AskQuestions.png, "Ask Questions icon", 100}

Tables have special functions associated with them, called @vocab{Methods}, which allow us to do all sorts of things with those tables. For example, we can get the first data row in a table by using the `.row-n` method:

`animals-table.row-n(0)`

*Don't forget: data rows start at index _zero_!*

<!--
Drive the "data rows start at index zero" point home a LOT, as it's a source common errors
-->
---
{layout="Investigate"}
# Row Lookups

`animals-table.row-n(0)`

Find `.row-n` in your Contracts page. What is the Domain of `.row-n`? What is the Range? 

A table @vocab{method} is a special kind of function which always operates on a specific table. `A.row-n(0)` and `B.row-n(0)` will return different rows, if A and B are different tables.

<!--

-->
---
{layout="Investigate"}
# Row Lookups

The code below will define the first row from the animals table:

`sasha = animals-table.row-n(0)`

- Open the Starter File for your dataset
- In the Animals Dataset, there are grouped samples that we might want to analyze: dogs, cats, lizards, etc. What are the grouped samples in _your_ dataset?
- In the first section of your file, use the `.row-n` method to define at least three rows from your table.
- If you have multiple subsets, make sure you have a row from each one defined!

<!--

-->
---
{layout="Synthesize"}
# Row Lookups

- Which grouped samples did you choose?
- Which rows did you define?

<!--

-->
---
{layout="Launch"}
# Column Lookups

We can also access _columns_ of a Row, by using a *Row Accessor*. Row accessors start with a Row value, followed by square brackets, and the name of the column where the value can be found. Here are three examples that use row accessors to get at different columns from the first row in the animals-table:

```
  animals-table.row-n(0)["name"]
  animals-table.row-n(0)["age"]
  animals-table.row-n(0)["fixed"]
```

<!--

-->

---
{layout="Launch"}
# Column Lookups

And of course, we can use our defined name, substituting it in place of all the redundant code:
```
  sasha["name"]
  sasha["age"]
  sasha["fixed"]
```

<!--

-->

---
{layout="Investigate"}
# Column Lookups

- How would you get the `weeks` column out of the _second_ row? The third?
- Complete the exercises on @printable-exercise{lookup-questions.adoc}.
- Complete @printable-exercise{pages/more-practice-w-lookups.adoc}

Flip back to page 2 of your workbook and look at The Animals Dataset. 

- Which row is animalA? Label it in the margin next to the dataset. Which row is animalB?  
- Label it in the margin next to the dataset.

<!--

-->

---
{layout="Investigate"}
# Column Lookups

- Now turn back to your screen. What happens when you evaluate `animalA` in the Interactions Area?
- Define _at least_ two additional values to be animals from the `animals-table`, called `animalC` and `animalD`.

---
{layout="Synthesize"}
# Column Lookups

What questions do you have?

<!--

-->
---