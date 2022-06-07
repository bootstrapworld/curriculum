---
{layout="DS Title Slide"}
# Defining Table Functions

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Computing Images from Rows

By now you've had a chance to explore functions on their own, thinking of them in terms of several different representations:

- A mapping between _Domain_ and _Range_
- A list of discrete _input values_ and _output values_
- A symbolic _definition_

Now it's time to use those representations to help us work with Tables!

<!--

-->
---
{layout="Launch"}
# Computing Images from Rows

- Open the @starter-file{row-functions}, save a copy, and click "Run".
- Scroll until you see the definition for `cat-row`. What will you get back if you evaluate `cat-row` in the Interactions Area?
- What species is the animal?
- What is its name?
- How old is it?
- Complete questions 1-3 on @printable-exercise{making-connections.adoc}.

<!--

-->
---
{layout="Investigate"}
# Computing Images from Rows

The Design Recipe uses multiple representations of functions in a specific order, to help us solve problems. Let's look at an example to see how this works!

_Complete the rest of @printable-exercise{making-connections.adoc}._

<!--
Review student answers, paying particular attention to the connections between "Contract and Purpose" and "Examples".
-->
---
{layout="Launch"}
# Computing Images from Rows

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

<!--

-->
---
{layout="Launch"}
# Computing Images from Rows

```{style="font-size:12pt;font-weight:bold"}
examples:
  weeks-dot(cat-row)   is circle(5 *          4,         "solid", "green")
  weeks-dot(young-row) is circle(5 *          1,         "solid", "green")

  weeks-dot(cat-row)   is circle(5 *   cat-row["weeks"], "solid", "green")
  weeks-dot(young-row) is circle(5 * young-row["weeks"], "solid", "green")
end
```

These examples show us exactly what should be produced for `cat-row` and `young-row` - the two Rows representing "Miaulis" and "Nori", based on their `weeks` to adoption. But these examples only tell us part of the story!

<!--

-->
---
{layout="Launch"}
# Computing Images from Rows

```{style="font-size:12pt;font-weight:bold"}
examples:
  weeks-dot(cat-row)   is circle(5 *          4,         "solid", "green")
  weeks-dot(young-row) is circle(5 *          1,         "solid", "green")

  weeks-dot(cat-row)   is circle(5 *   cat-row["weeks"], "solid", "green")
  weeks-dot(young-row) is circle(5 * young-row["weeks"], "solid", "green")
end
```

In those first examples, where are the number `4` and `1` coming from?

---
{layout="Synthesize"}
# Synthesize

Each step in the Design Recipe helps us write the next one.

- If we can't write our Contract and Purpose, it means we haven't thought through the problem enough. Better to find this out _before_ we write the rest of our function!
- If we're having trouble writing our Examples, **we can check our Contract and Purpose for hints.**
- If we're having trouble writing the Definition, **we can check our Examples  to see the pattern.**

These steps also help us _check our work_. If any two representations don't match, it means there's likely a bug somewhere.

---
{layout="LaunchR"}
# Design Recipe Telephone

@image{images/DR-Telephone.png, "Design Recipe Telephone", 250}

Let's get some practice defining functions and working with tables!

You'll be divided into groups of three, and each group will get 3 word problems to solve as a team.

Once you've finished, those solutions can be composed to analyze the Animals Dataset in a surprising way!

<!--
1. Divide the class into groups of three.
-->

---
{layout="InvestigateR"}
# Design Recipe Telephone

@image{images/DR-Telephone.png, "Design Recipe Telephone", 250}

**Set 1**

- @opt-printable-exercise{is-dog.adoc}{style="font-size:16pt"}
- @opt-printable-exercise{days.adoc}{style="font-size:16pt"}
- @opt-printable-exercise{is-young.adoc}{style="font-size:16pt"}

**Set 2**

- @opt-printable-exercise{is-old.adoc}{style="font-size:16pt"}
- @opt-printable-exercise{kilos.adoc}{style="font-size:16pt"}
- @opt-printable-exercise{is-cat.adoc}{style="font-size:16pt"}

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

@image{images/DR-Telephone.png, "Design Recipe Telephone", 250}

**Set 1 - Putting it all together**

@printable-exercise{data-cycle-1.adoc}


**Set 2 - Putting it all together**

@printable-exercise{data-cycle-2.adoc}


<!--
Have students compose their solutions to the three word problems together to complete their data cycles.
-->

---
{layout="Synthesize"}
# Design Recipe Telephone

- Why is it helpful to use each of these steps in the Design Recipe?
- What step do you find the most challenging right now? The easiest?
- What are some functions you might want to define for your _own_ analysis?

<!--

-->
