@slidebreak

{layout="DS Title Slide"}

# Checking Your Work
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
@slidebreak
{layout="Launch"}
# Confirming Analysis
**Samples are taken in Data Science and Computer Programming for different reasons**. 

One of the main purposes of Data Science is to take a representative sample from a larger population, and use information from the sample to infer what’s true about the whole population. 

@slidebreak
{layout="Launch"}
# Confirming Analysis
In programming, we often extract a smaller Table from a larger one, for the purpose of testing that our code seems to do what it’s supposed to. 

**In this lesson, we focus on the tasks of programmers, and consider best practices for setting up a Testing Table that helps us check our code.**

<!--

-->
@slidebreak
{layout="Launch"}
# Confirming Analysis

* Uber and Google are making self-driving cars, which use artificial intelligence to interpret sensor data and make decisions about whether a car should speed up, slow down, or slam on the brakes. This AI is trained on a lot of sample data, which it learns from. **What might be the problem if the sample data only included roads in California**?

* **Why might it be a bad thing to only test medicines on men** (or only on women), before prescribing them to the general public?
<!--

-->
@slidebreak
{layout="Launch"}
# Confirming Analysis

Data scientists usually think in terms of samples that best serve the purpose of _performing inference_: **Samples should be representative of the entire population**, and large enough to get us fairly close to the truth about that population. 

Programmers need to think in terms of _Testing Tables_ that best serve the purpose of verifying that their code does what it’s supposed to: **Testing Tables should be designed to call attention to any imperfections in the code’s instructions**.

@slidebreak
{layout="Launch"}
# Confirming Analysis

**Testing Matters!**

A good Testing Table should be _representative_ of the population, and _relevant_ to what’s being analyzed. A good Testing Table should have...{style="font-size:16pt"}

- _At least_ the columns that matter -- whether we’ll be ordering or filtering by those columns.{style="font-size:16pt"}
- Enough rows to include different circumstances that are relevant to the task at hand. For instance, if our code is supposed to extract certain cats from the animals table, our Testing Table should include at least one animal that’s not a cat.{style="font-size:16pt"}
- Rows that aren’t already sorted, if our analysis is supposed to sort for us.{style="font-size:16pt"}
<!--

-->
@slidebreak
{layout="Launch"}
# Confirming Analysis

Data scientists usually think in terms of samples that best serve the purpose of performing inference: Samples should be representative of the entire population, and large enough to get us fairly close to the truth about that population.


@slidebreak
{layout="Launch"}
# Confirming Analysis

How can we trust that our code is correct?

Programmers need to think in terms of Testing Tables that best serve the purpose of verifying that their code does what it’s supposed to: The Tables should be designed to call attention to any imperfections in the code’s instructions.


<!--
Students have already written lots of code to analyze data. Millions of lines of code just like yours are run on datasets every day. The results are used to tell us whether a drug is safe or not, whether someone should be put on the "no-fly" list, how much someone needs to pay for health insurance, and more. 

But programmers are only human, and everyone makes mistakes! And with so-called "A.I. Code Generators" out there writing more and more code for us, we need better and better ways of _verifying_ that code does exactly what it claims to do!
-->

@slidebreak
{layout="Investigate"}
# Confirming Analysis

Testing Tables can also be used to _verify_ that a certain analysis is correct.

An AI writes code that claims to filter out any shelter data to show only the cats.

* Could we test it using a Table that _already_ contains only cats?
* Could we test it using a Table that has no cats at all?
* Could we test it using a Table that has only cats and dogs?

<!--
* Could we test it using a Table that _already_ contains only cats?
** No! The AI's code might do nothing at all and just return the Table it was given. It would give __the right answer for the wrong reason__! We need to find out if it actually removes non-cat Rows.
* Could we test it using a Table that has no cats at all?
** No! The AI's code might always return a table with no rows (regardless of species!), so giving it a Table without cats will give __the right answer for the wrong reason__! We need to find out if it actually keeps rows for cats.
* Could we test it using a Table that has only cats and dogs?
** No! Maybe the AI's code just removes dogs. We need to see if it removes other species as well.
-->

@slidebreak
{layout="Investigate"}
# Confirming Analysis

Verifying that code does what it does is an important part of checking our work! That's why writing examples is so valuable: it's a chance to think about how the program _should_ work, without worrying as much about _how_ it works.

@slidebreak
{layout="Investigate"}
# Confirming Analysis

The AI writes a function called `fixed-cats` and _claims_ that, given a table of animals, it produces a table with only fixed cats.

* Do you trust it? How could you test it?
* Which animals would you use in a Testing Table?
* Complete @printable-exercise{pages/trust-but-verify.adoc}.
* Open the @starter-file{trust-but-verify}. There are 3 versions of `fixed-cats`. Are they all correct? If not, which ones are broken?

@slidebreak
{layout="Investigate"}
# Confirming Analysis


An AI writes a function called `fixed-cats` and _claims_ that, given a table of animals, it produces a table with only dogs five years or older.

* Do you trust it? How could you test it?
* Which animals would you use in a Testing Table?
* Turn to @printable-exercise{pages/trust-but-verify-2.adoc}. Using the same Starter File, construct a Testing Table and figure out which (if any) of the functions are correct!

@slidebreak
{layout="Synthesize"}
# Confirming Analysis

Complex analysis has more room for mistakes, so it’s critical to think about a Testing Table that allows us to trust that our code really does what it’s supposed to!

*How would you check whether or not a facial recognition system was equally accurate for everyone?*

<!--

-->
@slidebreak
{layout="Launch"}
# When AI isn't Intelligent... 

Law enforcement in many towns has started using facial-recognition software to automatically detect whether someone has a warrant out for their arrest. 

**A lot of facial-recognition software, however, has been trained on sample data containing mostly white faces**. Why might this be a problem?

<!--

-->
@slidebreak
{layout="Investigate"}
# When AI isn't Intelligent... 

- Read "@printable-exercise{pages/ai-article-register.pdf, Summarizing US Congress Testimony on Artificial Intelligence}" or watch this 10-minute video @link{https://youtu.be/eRUEVYndh9c, The Coded Gaze: Bias in Artificial Intelligence}.
- Complete @printable-exercise{ai-reflection.adoc}


@slidebreak
{layout="Synthesize"}
# Synthesize


Discuss the article and/or video, revisiting the following questions:

- What are some concerns that experts and activists have raised about Artificial Intelligence?
- What are some solutions that would address these concerns?
- How would you test whether or not a facial recognition system was equally accurate for everyone?

<!--

-->
