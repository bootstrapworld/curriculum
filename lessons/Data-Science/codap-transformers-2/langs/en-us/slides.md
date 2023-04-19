---
{layout="DS Title Slide"} 
# More Transformers: Filter, Transform, Build

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Filtering Tables

6-8 students will each represent a unique Row of a dataset called “Students.”  

They will line up in the front of the room. 

One student will play the role of The Filter Transformer!

<!-- 
You may need to choose your students strategically. The demonstration, for instance, requires at least one student who wears glasses.
-->

---
{layout="Launch}
# Filtering Tables

The Filter Transformer will receive an expression card. They will read it and make sure that they understand what it will do for each "Row" (student!) in the "Table" (line of students). They will keep that information a secret.

---
{layout="Launch"}
# Filtering Tables

A *contract* is a statement of the _domain_ (input) and _range_ (output) of an expression. Contracts don’t tell us specific inputs. They tell us the data type of input the expression needs. For example, a Contract wouldn’t say that addition requires "3 and 4". Addition works on more than just those two inputs! Instead, it would tells us that addition requires "two Numbers". When we use a Contract, we plug specific numbers or strings into the expression.

A *Purpose Statement* is a way of describing what an expression does. A sample purpose statement looks like this: "consumes an animal, and produces true if the animal is fixed."

---
{layout="Launch"}
# Filtering Tables

The Filter Transformer will walk from one student to the next, referring to the expression (on the card) in order to determine if each student should step forward or step backwards.

Based on who sat and who stayed, what was on the card?


<!--
Here’s how that might look if the Filter Transformer chose an expression card with, "Do they wear glasses?"

- _Filter Transformer stands in front of Student 1 and checks if they are wearing glasses._
- *Filter Transformer to Student 1 (who wears glasses)*: Step forward. (Student 1 steps forward.)
- _Filter Transformer stands in front of Student 2 and checks if they are wearing glasses._
- *Filter Transformer to Student 2 (who does not wear glasses)*: Step back. (Student 2 steps back.)

Have your Filter Transformer volunteer go through all their peers, applying their card to each one. Help students notice that the `Filter` Transformer takes an _expression_, and produces a new table containing only rows for which the expression returns `true`.

The Transformer consumes a student and produces `true` if they are wearing glasses.

-->

---
{layout="InvestigateR"}
# Filtering Tables

- Open the @starter-file{animals} in CODAP.
- Complete the worksheet @printable-exercise{pages/codap-filter.adoc} to explore the functionality of the `Filter` Transformer.
- Pay close attention while entering information into the `Transformer` plugin (pictured to the right). 

@image{images/filter-transformer.png}

---
{layout="Investigate"}
# Filtering Tables

- What happens if you forget to select a dataset from the drop-down menu?
- When does the text color change?
- Does CODAP mind if spelling is off?
- What happens when students save?
- Why might a clear, specific purpose statement be useful?
- When do we see additional datasets added to the drop-down menu of datasets to filter?

---
{layout="Investigate"}
# Filtering Tables

Note that `Age (years)` - or any attribute that is two or more words - needs to be typed within backticks ` ` in order for CODAP to recognize it as an attribute. 

The backtick key is in the upper left corner of the keyboard.


--- 
{layout="Synthesize"}
# Filtering Tables

- What is the role of the `Filter` Transformer? How is its role unique from that of the Transformer's _expression_?
- Suppose we wanted to determine whether cats or dogs get adopted faster. How might using the `Filter` Transformer help?
- If the shelter is purchasing food for older cats, what `Filter` Transformer would we create to determine how many cats to buy for?

<!--
- What is the role of the `Filter` Transformer? How is its role unique from that of the Trasnformer's _expression_?
** _The `Filter` Transformer walks through the table's rows, applying the expression to each row - then producing a new table containing only rows for which the expression returns `true`._
- Suppose we wanted to determine whether cats or dogs get adopted faster. How might using the `Filter` Transformer help?
** _We could use the `Filter` Transformer to produce two new tables - one with only cats, and one with only dogs. We could then analyze and compare the weeks to adoption for each species._
- If the shelter is purchasing food for older cats, what `Filter` Transformer would we create to determine how many cats to buy for?
** _We would filter out cats where `Age (years) > 5`._
-->

---
{layout="Launch"}
# Transforming Columns

Suppose we want to _transform_ our table, converting `pounds` to `kilograms` or `weeks` to `days`. The `Transform Attribute` Transformer makes that possible!

---
{layout="Investigate"}
# Transforming Columns

Complete the worksheet @printable-exercise{pages/codap-transform.adoc} in the @starter-file{animals} in CODAP.

The `Transform Attribute` Transformer walks through the table, applying whatever expression it was given to each row. Whatever the expression produces for that row becomes the value of the column; we name that column when we create the Transformer. In the first example, we gave the Transformer `Age < 5` as its expression, so the new table replaced the age with an indication of whether each animal is young (`true`) or not (`false`).

---
{layout="Synthesize"}
# Transforming Columns

- A dataset from Europe might list everything in metric (centimeters, kilograms, etc), so we use `Transform Attribute` to convert to imperial units (inches, pounds, etc).
- A dataset about schools might include columns for how many students are in the school and how many of those students identify as multi-racial. But when comparing schools of different sizes, what we really want is a column showing what _percentage_ of students identify as multi-racial. We could use `Transform Attribute` to compute that for every row in the table.

---
{layout="Launch"}
# Building Columns

So far, we've used Transformers to _filter_ and to _transform an attribute_. The final Transformer we are exploring today is called `Build Attribute`. 

Can you guess what this Transformer does and how it might be similar to _and_ different from `Transform Attribute`?

---
{layout="Investigate"}
# Building Columns

Complete the worksheet @printable-exercise{pages/codap-build.adoc} in the @starter-file{animals} in CODAP.

---
{layout="Synthesize"}
# Building Columns

- How is `Build Attribute` similar to `Transform Attribute`? How are they different?
- When might it make more sense to _build_ an attribute, rather than to _transform_ it?

<!--
- How is `Build Attribute` similar to `Transform Attribute`? How are they different?
** _``Build Attribute`` creates an additional column, using the expression that we provide. `Transform Attribute` converts an existing column, using the expression that we provide._
- When might it make more sense to _build_ an attribute, rather than to _transform_ it?
** _We would build rather than transform if we want to do comparisons across columns, or need to preserve the original column for any reason (e.g., we want measurements in metric and standard units.)_
-->


---
{layout="Synthesize"}
# Building Columns

Being able to create and define a Transformer  is a _huge_ upgrade in our ability to analyze data! But as a wise person once said, "with great power comes great responsibility"! Dropping all the dogs from our dataset might be a cute exercise in this class, but suppose we want to drop certain populations from a national census? Even a small programming error could erase millions of people, impact funding for things like roads and schools, etc.
