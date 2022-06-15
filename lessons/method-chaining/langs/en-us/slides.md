---
{layout="DS Title Slide"}
# Method Chaining

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Design Recipe Practice

The Design Recipe is a powerful tool for solving problems by writing @ifproglang{pyret}{functions} @ifproglang{codap}{expressions}. It's important for this to be like second nature, so let's get some more practice using it.

<!--

-->
---
{layout="Investigate"}
# Design Recipe Practice

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Define the @ifproglang{pyret}{functions} @ifproglang{codap}{Transformers and  expressions} on @printable-exercise{pages/design-recipe-1.adoc} and @printable-exercise{pages/design-recipe-2.adoc}.


<!--

-->
---
{layout="Synthesize"}
# Design Recipe Practice

- Did you find yourselves getting faster at using the Design Recipe?
- What patterns or shortcuts are you noticing, when you use the Design Recipe?

<!--

-->

@ifproglang{pyret}{
---
{layout="Launch"}
# Chaining

Now that we are doing more sophisticated analyses, we might write the following:
```{style="font-size:14pt"}
# get a table with the nametags of all 
# the fixed animals, ordered by species
with-labels = animals-table.build-column("labels", nametag)
fixed-with-labels = with-labels.filter(is-fixed)
result = fixed-with-labels.order-by("species", true)
```

<!--

-->
---
{layout="Launch"}
# Chaining

That's a lot of code, and it also requires us to come up with names for each intermediate step! Pyret allows table methods to be _chained together_, so that we can build, filter _and_ order a Table in one shot. For example:

```
# get a table with the nametags of all 
# the fixed animals, ordered by species
result = animals-table.build-column("labels", nametag).filter(is-fixed).order-by("species", true)
```
---
{layout="Launch"}
# Chaining

It can be difficult to read code that has lots of method calls chained together, so we can add a line-break before each “`.`” to make it more readable. Here’s the exact same code, written with each method on its own line:
```
# get a table with the nametags of all 
# the fixed animals, order by species
animals-table
  .build-column("label", nametag)
  .filter(is-fixed)
  .order-by("species", true)
```

---
{layout="Launch"}
# Chaining

```{style="font-size:16pt"}
# get a table with the nametags of all 
# the fixed animals, order by species
animals-table
  .build-column("label", nametag)
  .filter(is-fixed)
  .order-by("species", true)
```
This code takes the `animals-table`, and builds a new column called `label`. `.build-column` produces a new Table...and we that Table's whose `.filter` method. 
`.filter` produces _yet another Table_ (of all fixed animals) and we call _that_ Table’s `order-by` method. The Table produced by `.order-by` is our final result.{style="font-size:15pt"}
<!--
**Teaching Tip**
Use different color markers to draw _nested boxes_ around each part of the expression, showing where each Table came from.
-->

---
{layout="Launch"}
# Chaining

**Suppose we want to build a column, and then use it to filter our table.**

If we use methods in the wrong order (trying to filter by a column that doesn’t exist yet), we might wind up crashing the program. Even worse, the program might work, but produce results that are incorrect!
}

@ifproglang{codap}{

---
{layout="Launch"}
# Chaining

Now that we are doing more sophisticated analyses, we might find ourselves in a situation where we want to use a series of Transformers!

---
{layout="Launch"}
# Chaining

Suppose a journalist comes to the shelter who wants to write a story about a successful pet adoption -- but she has a very specific set of criteria. The reporter wants to report on the adoption of an animal that weighs no more than 9 kilograms.{style="font-size:14pt"}

She also wants to review an updated copy of the dataset each week (reflecting changes to the shelter's population) before making a decision about which animal to showcase.{style="font-size:14pt"}

---
{layout="Launch"}
# Chaining

In CODAP, we can use the result of one Transformer as the dataset for another Transformer! To help the journalist, you decide that you want to use *two* Transformers: _Build Attribute_ and _Filter_. But in which order?

---
{layout="Launch"}
# Chaining

- The _Build Attribute_ Transformer we must define uses this formula: `pounds/2.205`. It also requires that we provide a name for our new attribute, such as `kilograms`.
- The _Filter_ Transformer that we must define uses this formula: `kilograms<9`.
- Which of the two above Transformers should we apply _first_, `weight-in-kg` or `filter-if-light`?
- What do you predict will happen if we apply them in the wrong order? Why?

---
{layout="Launch"}
# Chaining

A perk of applying Transformers, rather than manipulating the dataset, is that any updates made to the original dataset will flow through the chain. As you chain together Transformers, it is important to remember the following:

**Order matters: Build / Transform, Filter, Sort.**

<!--
**Tip: Saving Transformers and Renaming Tables**

Saving a particular configuration of a Transformer is useful so that the Transformer can be easily accessed in the future. When we save a Transformer, we want to give it a useful name and purpose statement for ease of use later.

We also encourage students to rename tables descriptively. By the end of this exercise, the table students create will have quite a lengthy name: `(Sort(Filter(BuildAttribute(Animals-Dataset))))`. That's a lot of parentheses! As an alternative, students might consider using the following table names in this activity: `animals-in-kg`, followed by `light-animals-in-kg`, and then `ordered-light-animals-in-kg`.
-->

}

---
{layout="Investigate"}
# Chaining

**Order matters: Build @ifproglang{codap}{/Transform}, Filter, Sort.**

How well do you know your table methods? Complete @printable-exercise{pages/chaining-methods.adoc} and @printable-exercise{pages/chaining-methods-order-matters.adoc} to find out.

---
{layout="Synthesize"}
# Chaining

Share your answers - which expressions will produce errors? Why?

As our analysis gets more complex, chaining is a great way to **re-use code we've already written**. 

Less code means a **smaller chance of bugs**. 

<!--
Ask students about their answers to @printable-exercise{pages/chaining-methods-order-matters.adoc}. Which ones produce an error? Why do will they produce an error, and how can this be fixed?
-->

@ifproglang{codap}{

---
{layout="Supplemental"}
# Additional Exercises

- @opt-printable-exercise{pages/chaining-methods-table-transformations.adoc}

<!--

-->
}