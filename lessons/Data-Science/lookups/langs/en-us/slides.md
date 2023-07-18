---
{layout="DS Title Slide"}
# Row and Column Lookups

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Row Lookups

Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.

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

- What are the **names** given in each of these?
- What are the **values**?

<!--
* What are the names given in each of these?
**__name, age, and logo__
* What are the values?
** __the String "Flannery", the Number 16, and an Image of a solid red star__

-->
---
{layout="InvestigateR"}
# Row Lookups

@image{images/AskQuestions.png, 100}

* How many rows do we need to answer a Lookup question?

<!--
* How many rows do we need to answer a Lookup question?
** __Just one! Lookups can be answered just by finding the right row!__

(Make sure sure students understand we only need one row!)

-->
---
{layout="InvestigateR"}
# Row Lookups

@image{images/AskQuestions.png, 100}

**What code can we write, to let us define a single row?**

Tables have special functions associated with them, which allow us to do all sorts of things.

For example, we can get the first data row in a table by using the `row-n` function:

`row-n(animals-table, 0)`

*Don't forget: data rows start at index _zero_!*

<!--
Drive the "data rows start at index zero" point home a LOT, as it's a source common errors
-->
---
{layout="Investigate"}
# Row Lookups

Find `row-n` in your Contracts page. What is the Domain of `row-n`? What is the Range? 

- How would you get the _second_ row out of the animals table? The third?
<!--

-->
---
{layout="InvestigateR"}
# Row Lookups

@image{images/AskQuestions.png, 100}

**What code can we write, to let us define a single row?**

`row-n(animals-table, 0)`

It's often better to name our Row definitions according to the _property we care about_. In this case, the fact that this row is a cat is _much_ more interesting than the fact that her name is Sasha:

`cat-row = row-n(animals-table, 0)`
<!--
-->
---
{layout="Synthesize"}
# Row Lookups

- We named rows by a lot of different properties (e.g. - their species, sex, etc). What are some other properties of rows in this dataset that we could use?
- What are some properties of **your dataset** that you might want to define rows for?

<!--

-->
---
{layout="Launch"}
# Column Lookups

We can also access *columns* of a Row, by using a **Row Accessor**. 

Row accessors start with a Row value, followed by square brackets, and the name of the column where the value can be found. Here are three examples that use row accessors to get at different columns from the first row in the animals-table:{style="font-size:16pt"}

```{style="font-size:16pt"}
  row-n(animals-table, 0)["name"]
  row-n(animals-table, 0)["age"]
  row-n(animals-table, 0)["fixed"]
```

<!--

-->

---
{layout="Launch"}
# Column Lookups

And of course, we can use our defined name, substituting it in place of all the redundant code:
```
cat-row = row-n(animals-table, 0)
cat-row["name"]
cat-row["age"]
cat-row["fixed"]
```

<!--

-->

---
{layout="Investigate"}
# Column Lookups

- How would you get the `weeks` column out of the _second_ row? The third?
- Complete the exercises on @printable-exercise{lookup-questions.adoc}.
- Complete @printable-exercise{pages/more-practice-w-lookups.adoc}

<!--
Debrief student answers here
-->
---
{layout="Investigate"}
# Row Lookups

`cat-row = row-n(animals-table, 0)`

- In the Animals Dataset, there are subsets that we might want to analyze: dogs, cats, lizards, old animals, young ones, etc.
- Complete @printable-exercise{pages/defining-rows.adoc}.
- When you're done, open your saved Animals Starter File (or make a new @starter-file{animals} copy) and add these definitions after the definitions for `dog-row` and `cat-row`.

<!--

-->

---
{layout="Synthesize"}
# Column Lookups

- Why is it important to be able to define individual rows?
<!--

-->
