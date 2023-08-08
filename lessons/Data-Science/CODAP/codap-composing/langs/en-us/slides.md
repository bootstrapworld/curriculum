---
{layout="DS Title Slide"}
# Composing Transformers

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Creating Transformers

One of the perks of using a tool like CODAP is that it invites experimentation, prompting us to play with a variety of inputs until we have designed exactly the Transformer we need.

Sometimes, however, relying on experimentation can limit our ability to _plan_ our data transformations. Familiarizing ourselves with exactly which inputs each Transformer requires can help us to efficiently transform data, without relying on guessing and checking every time.

---
{layout="Launch"}
# Creating Transformers


Each Transformer we've worked with consumes a different amount of arguments, represented in the table below.

@image{images/transformer-table.png}


---
{layout="Launch"}
# Creating Transformers


- How many arguments does Filter require? How about Build Attribute? Transform Attribute?
- Why does each Transformer require a different number of arguments?

<!--
** _Filter requires 2 arguments. Build Attribute requires 3 arguments. Transform Attribute requires 4 arguments._
** _All Transformeres require a Transformer type and a dataset. Beyond that, Filter only needs a Boolean to know which rows to include and exclude from the new dataset. Build and Transform both require a new attribute name. Transform also needs to know which attribute is being transformed._
-->


---
{layout="Investigate"}
# Creating Transformers

"Transformer Cards" are a tool for thinking about what specific arguments each Transformer requires. Let's practice creating Transformer Cards to represent various Transformers.

- As a class, let's complete  @printable-exercise{create-transformer-cards.adoc}.
- In the last column, give each Transformer a useful and descriptive name.
- On your own, complete the handout @handout{create-transformer-cards-2.adoc}.

<!--
Confirm that students have correct responses on their Transformer Cards, as these cards are central to the subsequent segment of the lesson.
-->

---
{layout="Synthesize"}
# Creating Transformers

- Did you get more comfortable creating Transformer cards as you completed these two pages?
- What obstacles did you encounter?
- What is the value of naming Transformers?

---
{layout="Launch"}
# Composing Transformers

We already know how to filter, transform, and build columns - but what if we want to do _multiple things, all at once?_ Filtering, transforming and building are powerful transformations, but when they are _combined_ they become even more powerful!

Let's play a game to explore what happens when we combine Transformers...


---
{layout="Launch"}
# Composing Transformers

*Get Ready:*

- Each pair of students needs one set of cut-out cards from @handout{create-transformer-cards-2.adoc}.
- Each pair of students will need to refer to the three-row table of animals on the top of the page.

---
{layout="Launch"}
# Composing Transformers

*Gameplay:*

- Student 1: Randomly choose two cards and lay them down face up in front of your partner _in the order that you chose them_.
- Student 2: Determine the output of "playing" those two cards _in that order_ by referring to the three-row table of animals.
- Return the cards to the deck, shuffle, and play another round.

---
{layout="Launch"}
# Composing Transformers

*Challenges:*

Look at the cards in the deck. See if you can deal your partner two cards that...
- produce an error
- produce the same dataset, regardless of the order in which they are dealt
- produce a dataset with just _one_ animal
- produce an empty dataset (not an error!)

What did you discover about _composing_ Transformers?

---
{layout="Launch"}
# Composing Transformers

If we use our Transformers in the wrong order (trying to filter by a column that doesn’t exist yet, for example), we might wind up crashing the program. *Order matters: Build / Transform, _then_ Filter.*



---
{layout="Investigate"}
# Composing Transformers

One way to organize our thoughts is to diagram what we want to do, using the @vocab{Circles of Evaluation}. The rules are simple:

**1) Every Circle must have one - and only one! - saved Transformer written at the top.**

Each Transformer card that you created required different information, including the Transformer Type, the dataset, the expression, etc.

@show{(coe '(filter-if-fixed t)) }


---
{layout="Investigate"}
# Composing Transformers


Once a Transformer is named and _saved_, however, it needs just *one* piece of information from you: the dataset that you want to transform! This leads us to the second rule of Circles of Evaluation:

**2) The dataset that the Transformer consumes is written in the the middle of the Circle.**

Let's think about our Transformer cards again. The @vocab{Circle of Evaluation} for `filter-if-fixed` looks like this:


@show{(coe '(filter-if-fixed t)) }

---
{layout="Investigate"}
# Composing Transformers

But what if we want to play _another_ Transformer card? The  Circle of Evaluation above produces a _table_ ... which brings us to the third rule of Circles of Evaluation:

---
{layout="Investigate"}
# Composing Transformers


**3) Circles can contain other Circles!**

Let's say that after drawing `filter-if-fixed`, your partner draws `filter-if-young`. You could represent this sequence of cards like this:

@show{(coe '(filter-if-young (filter-if-fixed t))) }


---
{layout="Investigate"}
# Composing Transformers

A perk of composing saved Transformers is that everything is just a "view" of the original data, rather than a _change_ made to that data. Changes can cause tables to go out of sync, resulting in hard-to-find bugs and invalid results. 

With Transformers, any updates made to the original dataset will flow through the composition, keeping everything in sync. Transformers can also be reused, eliminating duplicate work.

---
{layout="Investigate"}
# Composing Transformers

Tip: Rename tables descriptively!

As you compose Transformers, you may note that table names start to become quite lengthy, for example:

`(weight-in-kg(filter-if-light(Animals-Dataset)))` 

That's a lot of parentheses! As an alternative, consider renaming the table something simpler. For instance, `light-animals-in-kg` would be a more easily interpreted table name.

---
{layout="Investigate"}
# Composing Transformers

Sometimes, the hardest part of solving a problem is knowing what you want to do, rather than worrying about how to do it. For example, sometimes solving an equation is a lot easier than __setting it up in the first place__. 

Circles of Evaluation give us an opportunity to think through what we want to do, before getting in front of the computer and worrying about how to do it. Circles of Evaluation let us think and plan, without getting bogged down by small details.

---
{layout="Investigate"}
# Composing Transformers


- Complete @printable-exercise{pages/matching-composed-transformers.adoc}.
- When you're finished, do @printable-exercise{pages/planning-transformer-composition.adoc}, where you will draw composed Circles of Evaluation based on a given prompt.

---
{layout="Synthesize"}
# Composing Transformers


Was it helpful to think about the Circles, without worrying about CODAP? Why or why not?