---

# Simple Inequalities

---
# Introducing Booleans 

@table{3}
| @image{images/coe1.png,a} | @image{images/coe2.png,a} | @image{images/coe3.png,a}

{.column}

Convert these Circles of Evaluation into code.

Log into
@ifproglang{wescheme}{ @link{https://www.wescheme.org, WeScheme     } }
@ifproglang{pyret}{    @link{https://code.pyret.org, code.pyret.org (CPO) } }
and see what the code evaluates to.

---
# Introducing Booleans 

@table{3}
| @image{images/coe4.png,a} | @image{images/coe5.png,a} | @image{images/coe6.png,a}

{.column}

You've never seen Circles of Evaluation like these before... but you can probably convert them to code!

Type your code into 

@ifproglang{wescheme}{ @link{https://www.wescheme.org, WeScheme     } }
@ifproglang{pyret}{    @link{https://code.pyret.org, code.pyret.org (CPO) } }

What did the expressions evaluate to? 
What do they think the outputs mean?

---
# Introducing Booleans 

Values like `true` and `false` obviously aren't Numbers or Images. But they also aren't Strings, or else they would have quotes around them. 

We've found a __new data type__, called a @vocab{Boolean}.

---
# Introducing Booleans

* Open the @starter-file{boolean}.
@ifproglang{wescheme}{
* Explore the five functions in this starter file:  `odd?`, `even?`, `less-than-one?`, `continent?`, ``primary-color?``

* All five functions produce @vocab{Booleans}. 
* Through your exploration, see if you can come up with an explanation of what a @vocab{Boolean} is.
}

@ifproglang{pyret}{
* Explore the five functions in this starter file: `is-odd`, `is-even`, `is-less-than-one`, `is-continent`, ``is-primary-color``

* All five functions produce @vocab{Booleans}. 
* Through your exploration, see if you can come up with an explanation of what a @vocab{Boolean} is.
}

---
# Introducing Booleans 

A @vocab{Boolean} is just another @vocab{data type}, like Numbers or Images. But unlike the others there are only two values: `true` and `false`.

---
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
# Introducing Inequalities

Equations typically have finite solution sets: there's only one answer for an unknown, or perhaps several answers. 

Inequalities, on the other hand, can have _infinite_ solutions.  

Inequality expressions divide all of the numbers in the universe into two categories: solutions and non-solutions.  

---
# Introducing Inequalities

* Open the @starter-file{inequalities-simple}.  It includes an example.  
* Read the example code in the file carefully and click run to see the image it returns.  
* Discuss the code with your partner.
* What do you Notice?
* What do you Wonder?

---
# Introducing Inequalities

This starter file includes a special `inequality` function that takes in a function, __which tests numbers in an inequality__, a list of 8 numbers __(to test in the function)__, and plots the numbers and a graph of the inequality on a number line.

The solution set is shaded in blue, with points shaded green (solution) and red (non-solution).

The resulting plot shows the number line, with all solution values shaded in blue. The 8 numbers provided in the list are shown as green (solution) or red (non-solution) circles. A successful input will include 4 solutions and 4 non-solutions, so the image returned will show 4 green dots and 4 red dots.

@image{images/inequality-works.png, "A picture of an inequality displayed on a number line, with four red dots and four green dots"}}

---
# Introducing Inequalities

If your list of 8 values doesn't include an equal number of solutions and non-solutions there will be an unequal distribution of red and green dots and you will get an error message encouraging you to adjust their list.

@image{images/not-quite.png, "A picture of an inequality displayed on a number line, with five red dots and only three green dots"}

---
# Introducing Inequalities

Open to the @printable-exercise{simple-inequalities.adoc} and complete it with a partner, identifying solutions and non-solutions to each inequality and testing them in the @starter-file{inequalities-simple}.

<!--
Encourage students to use negatives, positives, fractions and decimals as they generate their lists.

In order to stop seeing the examples written into the starter file code, students can comment out the example code by adding a # in front of each of the lines they want to hide.
-->

---
# Introducing Inequalities

- What patterns did you observe in how the inequalities worked?

---
# Additional Exercises:

- @opt-printable-exercise{pages/is-hot.adoc}
