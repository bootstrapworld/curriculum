---
{layout="Math Title Slide"}
# Translating Between Words and Math

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Circles of Evaluation

Your teacher is going to give you an envelope that contains three sets of cards.

With your partner, look through the first card set (of three) that your teacher gave you. What do you notice?

---
{layout="Launch"}
# Circles of Evaluation

The first set of cards includes arithmetic expressions. 

The expressions on these cards each include the number 15, the number 3, and an operator. 



---
{layout="Launch"}
# Circles of Evaluation

Now, look through the second set of cards. 

What do you notice?

<!--
    Students should observe that each card includes a an oval-shaped diagram. They may also notice the position of the numbers and operator within that diagram.

-->

---
{layout="LaunchR"}
# Circles of Evaluation

This second set of cards includes Circles of Evaluation.

- Every Circle must have one - and only one! - operator (or function!), written at the top.

- The inputs of the operator are written left to right, in the middle of the Circle. 

@show{(coe '(/ 15 3))}


---
{layout="Launch"}
# Circles of Evaluation

- With your partner, match each Arithmetic Expression card with the corresponding Circle of Evaluation card. Do not sort the Verbal Expression cards yet.
- There are more Circles of Evaluation than expressions. Create a separate pile for any cards that do not have a match.
- Lay the cards out on the table in front of you so you can clearly see both the Circle of Evaluation and the expression.
- Discuss any questions that arose.

<!--
Circulate as students sort their cards, ensuring that they are carefully analyzing each card so that they see the connection between the arithmetic expression and the Circle of Evaluation. This first phase of matching cards should be relatively quick - but it might raise questions on a few topics:

- *Symbols*. Circles of Evaluation utilize `*` to represent multiplication and `/` to represent division. (Why? Circles of Evaluation are a bridge representation - one which can eventually be used to help students learn to code! These are also the symbols used to type mathematical expressions into a search bar! _Although we use these symbols on all of our materials, you and your students can use whichever operator symbols are most comfortable._)

- *Order of terms*. While @math{5 + 3} and @math{3 + 5} both evaluate to the same _answer_, they are not the same _expression_. Highlight this difference for students.

- *Position of the operator*. The operator always belongs at the top of the Circle, and not in between terms. Explain to students that this is a convention we must follow when working with Circles of Evaluation.
-->

---
{layout="Launch"}
# Order of Operations

- Now, you’re going to receive a set of cards with Verbal Expressions - expressions written out in words.

- One at a time, take turns reading each card from the Verbal Expressions set out loud. After reading the card, place it with the corresponding Circle of Evaluation and Expression cards. Some sets will include just 3 cards, and others will have more.

- Explain to your partner how and why you placed each card.

- You and your partner must agree on each card’s placement before advancing to the next.

<!--
Again, circulate during the activity. As students match Verbal Expressions to their Arithmetic Expressions and Circles of Evaluation, additional challenges may arise. In particular:

- *One-third of 15*. This card will likely motivate some discussion. Take advantage of opportunities to help students connect multiplication and division as inverse operations. Explain to students that another way to represent this expression is @math{\frac{1}{3} \times 15}. Dividing by 3 produces the same outcome as multiplying by @math{\frac{1}{3}}.
- *Translating subtraction.* Students often translate "3 less than 15" into @math{3 - 15}, rather than @math{15 - 3}. Discuss the meaning of the word "less" in this context. Sometimes, asking, “What value is 3 less than 15?” can help students to make the connection. (The word "than" tends to force the numbers to appear in the _opposite_ order in which the language arranges them.)

Reading expressions aloud can often help students think about the meaning of the words.
-->


---
{layout="Launch"}
# Circles of Evaluation

- Turn to @printable-exercise{pages/translating.adoc}. Each row of the table represents a single arithmetic expression, written in three different ways. Fill in the empty spaces so that all three representations match.

- Next, complete @printable-exercise{pages/matching-words-to-circles.adoc}.

<!--
    Ensure that students are confident creating and analyzing simple Circles, as the next section of the lesson introduces another layer of complexity.
-->

---
{layout="InvestigateC"}
# Circles of Evaluation

Circles of Evaluation can contain other Circles of Evaluation.

The Circle of Evaluation for @math{3 \times 5 + 3} looks like this:

@show{(coe '(+ (* 3 5) 3))}

---
{layout="Investigate"}
# Circles of Evaluation

- First, practice @printable-exercise{pages/translate-words-to-circles.adoc}.

- Then, translate in the __other__ direction on @printable-exercise{pages/translate-circles-to-words.adoc}.

- When you’re finished, complete @printable-exercise{pages/translation-table1.adoc} and @printable-exercise{pages/translation-table2.adoc, "Part 2"} to practice moving between all three representations (the mathematical expression, the Circle of Evaluation, the verbal expression).

- Optional: Try @printable-exercise{pages/matching-math-to-words.adoc},

<!-- Note: On Translating from Circles to Words, there are multiple correct translations. Be sure to spend a moment going over students' solutions. Some translations into words are clearer than others; the subsequent section of this lesson will explore that notion in greater depth.
-->

---
{layout="Synthesize"}
# Circles of Evaluation


- We did lots of different translations between Circles of Evaluation, verbal expressions, and arithmetic expressions.

- Was there any type of translation that was more challenging for you?

- Is there more than one way to draw the Circle of Evaluation for @math{1 + 2} ? If so, is one way more "correct" than the other?

---
{layout="Launch"}
# The Ambiguity of Words

Read this sentence: 

*"Bruno told Gus that Mr. Schneider suspected that he had cheated on the science test."* {style="font-size:24pt"}

Who do you think is in trouble: Bruno or Gus?

How could you rewrite this sentence to make it clearer?

<!--
** _Discuss the two different possible interpretations of the sentence, which illustrate how even grammatically correct sentences in English can create confusion!_
-->

---
{layout="Launch"}
# The Ambiguity of Words

Math is precise, but that precision is difficult to preserve when we switch to words. Often, sentences can be ambiguous, meaning that there is more than one way to interpret them!

---
{layout="InvestigateC"}
# The Ambiguity of Words

Take a look at this expression: _"the sum of three and two multiplied by eight"_ {style="font-size:16pt"}

Are we multiplying first and then adding (as represented by the Circle on the left), or adding first and then multiplying (as represented by the Circle on the right)? {style="font-size:16pt"}

@image{images/coes.png}

<!--
    In this case, there are multiple ways to translate the sentence. (Would inserting a comma after the word “two” provides clarity?)

-->

---
{layout="Investigate"}
# The Ambiguity of Words

- Complete @printable-exercise{pages/ambiguity-of-words.adoc}, drawing two possible Circles for each verbal expression.

- What happens when you translate each Circle into a mathematical expression? Do the expressions produce the same result?

- Did you notice anything interesting about the last two expressions, compared to the others on the page?

- Now, try @printable-exercise{rewriting-ambiguous-expressions.adoc}.

- Did the two versions of the expressions produce the same results?


<!--
- Do the expressions produce the same result? _The expressions are structurally different, and generally produce different results (with two noteworthy exceptions!)_
- Last two expressions? _These expressions use only multiplication or only addition. As a result, the two expressions you wrote evaluated to the same outcome._

-->

---
{layout="Investigate"}
# The Ambiguity of Words

- On @printable-exercise{pages/ambiguous-or-clear.adoc}, identify the expressions that have two different numeric translations.

- When you encounter an expression that is ambiguous, rewrite it two times - once for each possible interpretation.

- When you encounter an expression that is clear, draw its Circle of Evaluation.

---
{layout="Synthesize"}
# The Ambiguity of Words

- Why are some expressions in words ambiguous and others are not?

- Do you think that expressions written in the language of math have ambiguity?

- Are Circles of Evaluation ever ambiguous?