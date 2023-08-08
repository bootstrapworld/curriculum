---
{layout="Math Title Slide"}
# Simple Inequalities

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchC"}
# Introducing Booleans 

Convert these Circles of Evaluation into code. Then, log into @starter-file{editor} and see what the code evaluates to.{style="font-size:24pt"}

@image{images/set-of-coes1.png}{width="550"}


---
{layout="LaunchC"}
# Introducing Booleans 

Hypothesize: What do these Circles of Evaluation mean? What do they evaluate to?{style="font-size:24pt"}

@image{images/set-of-coes2.png}{width="750"}

---
{layout="Launch"}
# Introducing Booleans 

Values like `true` and `false` obviously aren't Numbers or Images. But they also aren't Strings, or else they would have quotes around them. 

We've found a __new data type__, called a @vocab{Boolean}.

---
{layout="Investigate-DN"}
# Introducing Booleans

* Open the @starter-file{boolean}.
* Explore the five functions in this starter file.
* All five functions produce @vocab{Booleans}. 
* Through your exploration, see if you can come up with an explanation of what a @vocab{Boolean} is.

---
{layout="Investigate-DN"}
# Introducing Booleans 

* Turn to @printable-exercise{boolean-functions.adoc} and use the @starter-file{boolean} to complete the questions.
* Identify inputs that will make each function produce `true`.
* Identify inputs that will make each function produce `false`.

<!--
Students will see functions on this page that they've never encountered before! But instead of answering their questions, encourage them to make a _guess_ about what they do, and then type it in to discover for themselves.
- Explicitly point out that _everything they know still works!_ They can use their reasoning about Circles of Evaluation and Contracts to figure things out.

Common Misconceptions
- Many students - especially traditionally high-achieving ones - will be very concerned about writing examples that are "wrong." The misconception here is that an expression that produces `false` is somehow _incorrect_. You can preempt this in advance, by explaining that our Boolean-producing functions _should sometimes return false_.
-->

---
{layout="Launch"}
# Introducing Inequalities

Equations typically have finite solution sets: there's only one answer for an unknown, or perhaps several answers. 

Inequalities, on the other hand, can have _infinite_ solutions.  

Inequality expressions divide all of the numbers in the universe into two categories: solutions and non-solutions.  

<!--
	_It is important that students learn to recognize that there are many possible solutions and non-solutions to an inequality and are able to identify whether or not a given number is or isn't part of the @vocab{solution set}._
-->


---
{layout="LaunchC"}
# Introducing Inequalities

- We are going to practice identifying whether or not a given number is part of the @vocab{solution set}.
- Open the @starter-file{inequalities-simple} and click "Run".
- Look at the graph that appears, as well as the provided code (lines 10, 18, and 26).

<!--
Sample Graph for discussion on next slide
-->

---
{layout="LaunchC"}
# Introducing Inequalities

- What do you Notice? 
- What do you Wonder?

@image{images/inequality-works.png}

<!--
Students might observe the following:

* This starter file includes a special `inequality` function that takes in a function __(which tests numbers in an inequality)__ and a list of 8 numbers __(to test in the function)__.

* When we click "Run", we see a graph of the inequality on a number line.

* The solution set is shaded in blue.

* The 8 numbers provided in the list are shown as dots on the numberline. They will appear:
** green _when they're part of the solution set_
** red _when they are non-solutions_
-->

---
{layout="Launch"}
# Introducing Inequalities

- Look at line 18 in the @starter-file{inequalities-simple}. 
- Edit the list of values by deleting _one_ of the `negative signs`.
- Hit "Run" and examine the graph that appears.

<!--
Sample Graph for discussion on next slide
-->
	
---
{layout="LaunchC"}
# Introducing Inequalities

How is this graph different from the one you first produced?

@image{images/not-quite2.png}

<!--
A successful input in this starter file will include 4 solutions and 4 non-solutions; in other words, the image returned will show 4 green dots and 4 red dots.

When you modify the list of numbers, you will see that there are now 5 red dots and 4 green dots - along with a message that says, _"Challenge yourself: Find 4 true examples and 4 false"_.
-->	

---
{layout="Investigate-DN"}
# Introducing Inequalities

- Complete @printable-exercise{simple-inequalities.adoc} with a partner, identifying solutions and non-solutions to each inequality and testing them in the @starter-file{inequalities-simple}.
- For each inequality, find 4 solutions and 4 non-solutions.
- Try using negatives, positives, fractions and decimals as you generate your lists.

---
{layout="Synthesize"}
# Introducing Inequalities

What patterns did you observe in how the inequalities worked?

---
{layout="Supplemental"}
# Additional Exercises

@opt-printable-exercise{pages/is-hot.adoc}
