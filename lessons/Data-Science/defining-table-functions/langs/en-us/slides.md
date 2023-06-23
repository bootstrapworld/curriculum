---
{layout="DS Title Slide"}
# Defining Table Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Reviewing Function Definition 

By now you've had a chance to explore functions on their own, thinking of them in terms of several different representations:

- A mapping between _Domain_ and _Range_
- A list of discrete _input values_ and _output values_
- A symbolic _definition_

Now it's time to use those representations to help us work with Tables!

---
{layout="Launch"}
# Reviewing Function Definition 

- Open the @starter-file{row-functions}, save a copy, and click "Run".
- Scroll until you see the definition for `cat-row`. What will you get back if you evaluate `cat-row` in the Interactions Area?
- What species is the animal?
- What is its name?
- How old is it?
- Complete questions 1-3 on @printable-exercise{making-connections.adoc}.

---
{layout="Investigate"}
# Reviewing Function Definition 

The Design Recipe uses multiple representations of functions in a specific order, to help us solve problems. Let's look at an example to see how this works!

_Complete the rest of @printable-exercise{making-connections.adoc}._

<!--
Review student answers, paying particular attention to the connections between "Contract and Purpose" and "Examples".
-->
---
{layout="Investigate"}
# Reviewing Function Definition 

Take a closer look at the four examples in this file:

```{style="font-size:12pt;font-weight:bold"}
# weeks-dot :: Row -> Image
# consumes an animal, and draws a solid purple circle whose
# radius is 5x the number of weeks it took to be adopted
examples:
  weeks-dot(cat-row)   is circle(5 *          4,         "solid", "green")
  weeks-dot(young-row) is circle(5 *          1,         "solid", "green")

  weeks-dot(cat-row)   is circle(5 *   cat-row["weeks"], "solid", "green")
  weeks-dot(young-row) is circle(5 * young-row["weeks"], "solid", "green")
end
```

---
{layout="Investigate"}
# Reviewing Function Definition 

```{style="font-size:12pt;font-weight:bold"}
examples:
  weeks-dot(cat-row)   is circle(5 *          4,         "solid", "green")
  weeks-dot(young-row) is circle(5 *          1,         "solid", "green")

  weeks-dot(cat-row)   is circle(5 *   cat-row["weeks"], "solid", "green")
  weeks-dot(young-row) is circle(5 * young-row["weeks"], "solid", "green")
end
```

These examples show us exactly what should be produced for `cat-row` and `young-row` - the two Rows representing "Miaulis" and "Nori", based on their `weeks` to adoption. But these examples only tell us part of the story!

---
{layout="Investigate"}
# Reviewing Function Definition 

```{style="font-size:12pt;font-weight:bold"}
examples:
  weeks-dot(cat-row)   is circle(5 *          4,         "solid", "green")
  weeks-dot(young-row) is circle(5 *          1,         "solid", "green")

  weeks-dot(cat-row)   is circle(5 *   cat-row["weeks"], "solid", "green")
  weeks-dot(young-row) is circle(5 * young-row["weeks"], "solid", "green")
end
```

In those first examples, where are the number `4` and `1` coming from?

<!--
  The first two examples are _correct_, but they don't show all of their work. The last two examples show how those values are looked up from the example rows. If you're stuck on the examples step, here's a useful trick to get you started: "Complete the following sentence: __For this Row, I...__" Whatever you answer is the precise description of what to do for your example!

*You can use both kinds of examples in your code!* Sometimes we want to use real, concrete numbers to make sure our work is correct. And sometimes we need to show all of our work, to make sure we are defining the function correctly! Programmers often use a mix of the two.
-->

---
{layout="Synthesize"}
# Synthesize

Each step in the Design Recipe helps us write the next one.

- If we can't write our Contract and Purpose, it means we haven't thought through the problem enough. Better to find this out _before_ we write the rest of our function!
- If we're having trouble writing our Examples, **we can check our Contract and Purpose for hints.**
- If we're having trouble writing the Definition, **we can check our Examples  to see the pattern.**

These steps also help us _check our work_. If any two representations don't match, it means there's likely a bug somewhere.

---
{layout="Launch"}
# Design Recipe Telephone

Most computer programs are written by huge teams! It is critical that each team member records their thinking with enough detail for other team members to be able to pick up where they left off.  

We're going to practice collaborative programming and try writing some other Table Functions using the Design Recipe, through an activity called Design Recipe Telephone.

<!--
Divide the class into groups of three.
-->
---
{layout="LaunchR"}
# Design Recipe Telephone

@image{images/DR-Telephone.png, 250}

@table{2,header}
| Word Problem Set 1: | Word Problem Set 2:
| @handout{is-dog.adoc, is-dog}, @handout{days.adoc, days}, @handout{is-young.adoc, is-young} | @opt-printable-exercise{is-old.adoc, is-old}, @opt-printable-exercise{kilos.adoc, kilos}, @opt-printable-exercise{is-cat.adoc, is-cat}

_★ When a team has completed these three Design Recipes, they can use @lesson-link{composing-table-operations/}._

<!--
Decide which groups will use Set 1, and which will use Set 2
-->

---
{layout="Investigate"}
# Design Recipe Telephone

In this activity, each person in your group will start with a different word problem.{style="font-size:12pt"}

* You will each be doing one step of each Design Recipe problem.{style="font-size:12pt"}
* The student who continues working the problem that you start will be dependent on your work, so pay careful attention to making your part as precisely as possible. If they don't have the information they need, they will give it back to you for revision.{style="font-size:12pt"}
* When you complete your step, you will fold your paper to hide the part that you were looking at so that only your work and the rest of the recipe is visible.{style="font-size:12pt"}
* Then you will pass your work to the person to your right.{style="font-size:12pt"}
* The person who has received your paper will review your work, and complete the next step based solely on what you wrote down for them.{style="font-size:12pt"}
* You will receive a different problem from the person to your left.{style="font-size:12pt"}
* If at any point your realize that the person before you didn't provide enough information, you may hand the paper back to them for revision.{style="font-size:12pt"}
* When you've finished all three Design Recipes, turn to the Data Cycle for your set and work as a team to complete it!{style="font-size:12pt"}
---
{layout="InvestigateR"}
# Design Recipe Telephone

@image{images/DR-Telephone.png, 250}

**Set 1**

- @handout{is-dog.adoc}{style="font-size:16pt"}
- @handout{days.adoc}{style="font-size:16pt"}
- @handout{is-young.adoc}{style="font-size:16pt"}

**Set 2**

- @handout{is-old.adoc}{style="font-size:16pt"}
- @handout{kilos.adoc}{style="font-size:16pt"}
- @handout{is-cat.adoc}{style="font-size:16pt"}

<!--
2. Choose which set of word problems you are going to start with and give each student within each group a different word problem.
3. The game of telephone begins!
* Every student write the contract+purpose for their word problem, then folds over the word problem and passes the contract+purpose to the right
* Using their partner's contract+purpose, every student writes their example, circles+labels the variables, then folds over the contract+purpose and passes the examples to the right
* Using their partner's examples, every student writes their definition
-->

---
{layout="InvestigateR"}
# Design Recipe Telephone

@image{images/DR-Telephone.png, 250}

**Set 1 - Putting it all together**

@printable-exercise{data-cycle-1.adoc}


**Set 2 - Putting it all together**

@printable-exercise{data-cycle-1.adoc}


<!--
Have students compose their solutions to the three word problems together to complete their data cycles.
-->

---
{layout="Synthesize"}
# Design Recipe Telephone

- If we already know how to get the answer, why would it ever be important to know how to do each step the slow way?
- Why is it helpful to use each of these steps in the Design Recipe?
- What step do you find the most challenging right now? The easiest?
- What are some functions you might want to define for your _own_ analysis?

<!--
* If we already know how to get the answer, why would it ever be important to know how to do each step the slow way? _Someday we won't be able to get the answer, and knowing the steps will help / So we can help someone else who is stuck / So we can work with someone else and share our thinking / So we can check our work
-->

---
{layout="Supplemental"}
# Additional Exercises

* @opt-printable-exercise{pages/2-blank-recipes.adoc, blank Design Recipes}
* @opt-printable-exercise{pages/data-cycle-1.adoc, blank data cycles}.
