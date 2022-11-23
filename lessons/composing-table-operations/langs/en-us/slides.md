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

@ifproglang{codap}{
---
{layout="LaunchC"}
# Design Recipe Practice

Let's look at this @printable-exercise{pages/design-recipe-1.adoc} worksheet together.

First, we need to decide which Transformer to use: Filter, Transform, or Build. 

@image{images/transformer-name.png, "top section of a Design Recipe"}

<!---
  Based on the Transformer's already-provided name, students should deduce that they will use Filter. They can then record the Transformer's name on the line.
-->

---
{layout="Launch"}
# Design Recipe Practice

Next, we provide *example tables*. 

In this case, we want to know the animals' names and their species, so we write down those column names. We want to list a few different animals - at least one that is a dog, and at least one that is not - to represent the variety of animals on the table. 


---
{layout="LaunchC"}
# Design Recipe Practice

Then we think about what our transformed table will look like:

- Will Sasha be on the new table? _No, Sasha is a cat. We only want dogs!_

- Will Fritz be on the new table? _Yes, Fritz is a dog._

- Will Toggle be on the new table? _Yes, Toggle is a dog._

@image{images/example-tables.png, "filled in example tables from Design Recipe worksheet"}

---
{layout="LaunchC"}
# Design Recipe Practice

Now, we are ready to drill down on the contents of our Transformer.

- First - the *contract*, which requires a domain and a range. 

- Next, we need a clear *purpose statement* which describes what the expression does to each row. 

- And finally, we enter our *expression*, in this case: `species = "dog"`.

@image{images/contents.png, "contract, purpose statement, expression"}

<!--
Whenever we are filtering, we can expect the contract to be the same: Row -> Boolean.

In this case, the expression will consume an animal and compute whether the species is "dog" - as our example tables (above) demonstrate!

Each time students encounter a new word problem, we encourage working through it with paper and pencil, as above; the Design Recipe slows down students' thinking and encourages them to reason through each scenario fully rather than guessing haphazardly.
-->
}

---
{layout="Investigate"}
# Design Recipe Practice

- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Define the @ifproglang{pyret}{functions} @ifproglang{codap}{Transformers and  expressions} on @ifproglang{pyret}{@printable-exercise{pages/design-recipe-1.adoc} and} @printable-exercise{pages/design-recipe-2.adoc}.


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

Suppose we start with some number A, and want to add B, C and D to it. The code below will get the job done:
```
x = A + B                # starting with A, add B
y = x + C                # then add C....
result = y + D           # then add D to get our result
```

Why is this code ugly, or hard to read?

<!--
Why is this code ugly, or hard to read? Many lines of code means more to read and more possible places for bugs. This code creates names for each step. But we don't really care about `x` or `y` -- we just want the final answer `result`!
-->  

---
{layout="Launch"}
# Chaining

We can easily _chain these operators together_, to do all the calculation in one line of code:
```
result = A + B + C + D
```
---
{layout="Launch"}
# Chaining

- Open your saved Table Methods Starter File (or @starter-file{table-methods, open a new one}), and click "Run".
- Can you make a table with a new column called "nametag" that is populated using the `label` function?
- Can you take _that_ table, and filter it so it only shows the fixed animals?
- Can you sort _that_ table by species?

---
{layout="Launch"}
# Chaining


Let's look at one possible solution to these challenges:
```
x = animals-table.build-column("labels", nametag)    # starting with our table, and add labels
y = with-labels.filter(is-fixed)                     # then filter by is-fixed...
result = fixed-with-labels.order-by("species", true) # then sort by species to get our result
```

Why is this code ugly, or hard to read?

<!--
  Many lines of code means more to read and more possible places for bugs. This code creates names for each step. But we don't really care about `x` or `y` -- we just want the final answer `result`!
-->

---
{layout="Launch"}
# Chaining


Pyret allows table methods to be _chained together_, so that we can build, filter _and_ order a Table in one shot. 

```
result = animals-table.build-column("labels", nametag).filter(is-fixed).order-by("species", true)
```

 
<!--
- We take the `animals-table`, and produce a new table with an extra column called `label`.
- Then call _that_ Table's `.filter` method, producing a new table with a `label` column and only rows for fixed animals.
- Then we call _that_ Table’s `order-by` method, producing a new, sorted table of fixed animals with a `label` column.

-->
---
{layout="Launch"}
# Chaining

It can be difficult to read code that has lots of method calls chained together, so we can add a line-break before each `.` to make it more readable. Here’s the exact same code, written with each method on its own line:

```
# get a table with the nametags of all 
# the fixed animals, ordered by species
result = animals-table.build-column("labels", nametag).filter(is-fixed).order-by("species", true)
```


---
{layout="Launch"}
# Chaining

* Take a minute to think about what code you would write to sort the animals table by the kilograms column.
* Do you think
`animals-table.order-by("kilograms", true).build-column("kilograms", kilos)`
will generate the table we want? Why or why not? 

Test your hypothesis by typing the code that you think will build the table into the starter file!
}

@ifproglang{codap}{

---
{layout="Launch"}
# Chaining

Now that we are doing more sophisticated analyses, we might find ourselves in a situation where we want to use a series of Transformers!

---
{layout="Launch"}
# Chaining

Suppose a journalist comes to the shelter who wants to write a story about a successful pet adoption -- but she has a very specific set of criteria. The reporter wants to report on the adoption of an animal that weighs no more than 9 kilograms.

She also wants to review an updated copy of the dataset each week (reflecting changes to the shelter's population) before making a decision about which animal to showcase.

---
{layout="Launch"}
# Chaining

In CODAP, we can use the result of one Transformer as the dataset for another Transformer! 

To help the journalist, you decide that you want to use *two* Transformers: _Build Attribute_ and _Filter_. But in which order?

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