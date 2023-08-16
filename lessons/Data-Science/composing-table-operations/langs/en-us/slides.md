---
{layout="DS Title Slide"}
# Composing Table Operations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Design Recipe Practice

When filtering rows or building columns, we need to write @ifproglang{pyret}{functions}@ifproglang{codap}{Transformer expressions}. __This should be done carefully!__ We want our results to be rock solid and accurate, especially if they're going to be used in ways that affect the world around us.

---
{layout="Launch"}
# Design Recipe Practice

The Design Recipe is a sequence of steps that helps us document, test out, and write @ifproglang{pyret}{functions} @ifproglang{codap}{Transformer expressions} that let us dig deeper into our data, and analyze it more carefully. It's important for this to be like second nature, so let's get some practice using it.


@ifproglang{codap}{
---
{layout="LaunchC"}
# Design Recipe Practice

Let's look at @printable-exercise{pages/design-recipe-1.adoc} together.

First, we need to decide which Transformer to use: Filter, Transform, or Build. 

@image{images/transformer-name.png}

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

@image{images/example-tables.png}

---
{layout="LaunchC"}
# Design Recipe Practice

Now, we are ready to drill down on the contents of our Transformer.

- First - the *contract*, which requires a domain and a range. 

- Next, we need a clear *purpose statement*, which describes what the expression does to each row. 

- And finally, we enter our *expression*, in this case: `species = "dog"`.

@image{images/contents.png}

<!--
Whenever we are filtering, we can expect the Contract to be the same: Row -> Boolean.

In this case, the expression will consume an animal and compute whether the species is "dog" - as our example tables (above) demonstrate!

Each time students encounter a new word problem, we encourage working through it with paper and pencil, as above; the Design Recipe slows down students' thinking and encourages them to reason through each scenario fully rather than guessing haphazardly.
-->
}

---
{layout="Investigate"}
# Design Recipe Practice

Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.

Define the @ifproglang{pyret}{functions} @ifproglang{codap}{Transformers and  expressions} on @ifproglang{pyret}{@printable-exercise{pages/design-recipe-1.adoc} and} @printable-exercise{pages/design-recipe-2.adoc}.


<!--
Suppose we want to build a table of Animals that are fixed _and_ old, or a table of animals that are cats _or_ dogs?

By using the `and` and `or` operators, we can _combine_ Boolean tests @ifproglang{codap}{on a single Transformer, like `Filter`.} @ifproglang{pyret}{, as in: `(1 > 2) and ("a" == "b")`} @ifproglang{codap}{Once we've opened the `Filter` Transformer, we would tell CODAP to keep all rows that satisfy `Species = "cat" and Species = "dog"`}. This is handy for more complex programs! For example, we might want to ask if a character in a video game has run out of health points _and_ if they have any more lives. We might want to know if someone’s ZIP Code puts them in Texas or New Mexico. When you go out to eat at a restaurant, you might ask what items on the menu have meat and cheese.

@ifproglang{pyret}{For many of the situations where you might use `and`, there's actually a much more powerful mechanism you can use, called _Composition_!} @ifproglang{codap}{When we want to compose _different_ Transformers, however, this strategy will not work. We'll need to find another way!}
-->

---
{layout="Synthesize"}
# Design Recipe Practice

- Did you find yourselves getting faster at using the Design Recipe?
- What patterns or shortcuts are you noticing, when you use the Design Recipe?

<!--

-->

---
{layout="Launch"}
# Composing

We already know how to filter, sort, and build columns - but what if we want to do _multiple things, all at once?_ Sorting, Filtering and Building are powerful operations, but when they are _combined_ they become even more powerful!

---
{layout="Launch"}
# Composing

A journalist comes to the shelter who wants to write a story about a successful pet adoption -- but she has a very specific set of criteria. The reporter wants to report on the adoption of an animal that weighs *no more than 9 kilograms* (they don't use "pounds" in Britain!).

To provide her with this data, what operations do we need to do to our dataset?

<!--
We need to filter, showing only rows that are greater than 9kg. We also need to add a column that shows weight in kilograms, dividing pounds by 2.2.
-->

---
{layout="Launch"}
# Composing

Order matters: Build @ifproglang{codap}{/ Transform}, Filter, Sort.

What do you think will happen if we try to filter animals that weigh more than 9kg, before actually building a `"kilos"` column?

<!--
(Sample responses:) It will crash! The computer won't like it!
-->

---
{layout="Launch"}
# Composing

If we use our @ifproglang{pyret}{functions} @ifproglang{codap}{Transformers} in the wrong order (trying to filter by a column that doesn’t exist yet), we might wind up crashing the program. But even worse, the program might run but produce nonsensical results!

---
{layout="Investigate"}
# Composing

One way to organize our thoughts is to diagram what we want to do, using the @vocab{Circles of Evaluation}. The rules are simple:

1) Every Circle must have one - and only one! - @ifproglang{pyret}{function} @ifproglang{codap}{Transformer type}, written at the top.

2) The arguments of the @ifproglang{pyret}{function} @ifproglang{codap}{Transformer} are written left-to-right, in the middle of the Circle.

---
{layout="Launch"}
# Composing

Values like Numbers, String, and Booleans are still written by themselves. It's only when we want to use a @ifproglang{pyret}{function} @ifproglang{codap}{Transformer} that we need to draw a Circle, and write the values inside from left-to-right.


@ifproglang{pyret}{
---
{layout="LaunchC"}
# Composing

Let's try diagraming what we need to do for the journalist, using the Circles of Evaluation. We always build first, so let's start there. According to the @vocab{contract}, we know the name of the function is `build-column`, and it needs three arguments: the animals table, the name of the new column `"kilos"`, and the `kilograms` function.

@image{images/build-col-coe.png}
}


@ifproglang{codap}{
---
{layout="LaunchC"}
# Composing

Let's try diagraming what we need to do for the journalist, using the Circles of Evaluation. We always build first, so let's start there. We know that our transformer needs three things: the animals table, the name of the new column `"kilos"` and the formula expression.

}

---
{layout="LaunchC"}
# Composing

But we also need to filter by that new column, so that we only have animals weighing more than 9kg! That means we need another Circle of Evaluation. We know `filter` goes at the top. But what table are we using for the first argument? It can’t be the animals-table again, because that doesn’t have a `"kilos"` column.


@ifproglang{pyret}{
---
{layout="LaunchC"}
# Composing

3\. Circles can contain other Circles!

Our first Circle of Evaluation _produces a table_, and that's the one we want to use as the first input to `filter`!

@image{images/filter-build-col-coe.png}
}



@ifproglang{codap}{
---
{layout="LaunchC"}
# Composing

1) Circles can contain other Circles!

Our first Circle of Evaluation _produces a table_, and that's the one we want to use as the first input to `filter`!

}

---
{layout="Investigate"}
# Composing

- Complete @printable-exercise{pages/composing-table-operations.adoc}.
- @optional For more of a challenge, tackle @opt-printable-exercise{pages/composing-table-operations-order-matters.adoc}


@ifproglang{pyret}{
---
{layout="Investigate"}
# Composing

To convert a Circle of Evaluation into code, **we start at the outside and work our way in**. After each function we write a pair of parentheses, and then convert each argument inside the Circle. The code for this Circle of Evaluation would be @show{(code '(pie-chart (filter animals-table is-dog) "fixed"))}.


---
{layout="Investigate"}
# Composing

@show{(code '(pie-chart (filter animals-table is-dog) "fixed"))}

- Type the above code into Pyret and see what you get!
- Draw the Circle of Evaluation showing how to make a bar chart showing the species in the shelter, __but only for old animals__. Then convert it to code and type it into Pyret.
- For practice converting Circles of Evaluation into code, complete @printable-exercise{pages/building-from-circles-1.adoc}.

<!--
Use different color markers to draw the Circles of Evaluation, and then use those same colors when writing the code. This helps make the connection between Circles and code clearer.
-->
}

@ifproglang{codap}{
---
{layout="Investigate"}
# Composing

A perk of composing Transformers is that everything is just a "view" of the original data, rather than a _change_ made to that data. 

Changes can cause tables to go out of sync, resulting in hard-to-find bugs and invalid results. With Transformers, any updates made to the original dataset will flow through the composition, keeping everything in sync. 

Transformers can also be reused, eliminating duplicate work.

<!--
Saving a particular configuration of a Transformer is useful so that the Transformer can be easily accessed in the future. When we save a Transformer, we want to give it a useful name and purpose statement for ease of use later.

We also encourage students to rename tables descriptively. By the end of this exercise, the table students create will have quite a lengthy name: `(weight-in-kg(filter-if-light(Animals-Dataset)))`. That's a lot of parentheses! As an alternative, students might consider using renaming the table. For instance, `light-animals-in-kg` might be a more useful table name, here.
-->
}

---
{layout="Investigate"}
# Composing

Circles of Evaluation let us think and plan, without worrying about small details.

Sometimes, the hardest part of solving a problem is knowing what you want to do, rather than worrying about how to do it. 


<!--
For example, sometimes solving an equation is a lot easier than __setting it up in the first place__. Circles of Evaluation give us an opportiunity to think through what we want to do, before getting in front of the computer and worrying about how to do it.
-->

---
{layout="InvestigateC"}
# Composing

Armed with these tools, we can do some pretty complex analysis! We can even think of data displays as another kind of table operation. What will this Circle of Evaluation produce?

@image{images/box-plot-coe.png}


---
{layout="Investigate"}
# Composing

Complete @printable-exercise{pages/planning-table-operations.adoc}.

<!--
Review student answers to @printable-exercise{pages/planning-table-operations.adoc}.
-->

---
{layout="Synthesize"}
# Composing

Was it helpful to think about the Circles, without worrying about @ifproglang{pyret}{Pyret}@ifproglang{codap}{CODAP}? Why or why not?

---
{layout="Supplemental"}
# Additional Materials

@opt-printable-exercise{pages/building-from-circles-2.adoc}

