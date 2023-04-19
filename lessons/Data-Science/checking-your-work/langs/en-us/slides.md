---

{layout="DS Title Slide"}

# Checking Your Work
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Confirming Analysis
**Samples are taken in Data Science and Computer Programming for different reasons**. 

One of the main purposes of Data Science is to take a representative sample from a larger population, and use information from the sample to infer what’s true about the whole population. 

---
{layout="Launch"}
# Confirming Analysis
In programming, we often extract a smaller Table from a larger one, for the purpose of testing that our code seems to do what it’s supposed to. 

**In this lesson, we focus on the tasks of programmers, and consider best practices for setting up a Testing Table that helps us check our code.**

<!--

-->
---
{layout="Launch"}
# Confirming Analysis
* Uber and Google are making self-driving cars, which use artificial intelligence to interpret sensor data and make decisions about whether a car should speed up, slow down, or slam on the brakes. This AI is trained on a lot of sample data, which it learns from. **What might be the problem if the sample data only included roads in California**?

* **Why might it be a bad thing to only test medicines on men** (or only on women), before prescribing them to the general public?
<!--

-->
---
{layout="Launch"}
# Confirming Analysis

Data scientists usually think in terms of samples that best serve the purpose of _performing inference_: **Samples should be representative of the entire population**, and large enough to get us fairly close to the truth about that population. 

Programmers need to think in terms of _Testing Tables_ that best serve the purpose of verifying that their code does what it’s supposed to: **Testing Tables should be designed to call attention to any imperfections in the code’s instructions**.

---
{layout="Launch"}
# Confirming Analysis
**Testing Matters!**

A good Testing Table should be _representative_ of the population, and _relevant_ to what’s being analyzed. A good Testing Table should have...{style="font-size:16pt"}

- _At least_ the columns that matter -- whether we’ll be ordering or filtering by those columns.{style="font-size:16pt"}
- Enough rows to include different circumstances that are relevant to the task at hand. For instance, if our code is supposed to extract certain cats from the animals table, our Testing Table should include at least one animal that’s not a cat.{style="font-size:16pt"}
- Rows that aren’t already sorted, if our analysis is supposed to sort for us.{style="font-size:16pt"}
<!--

-->
---
{layout="Investigate"}
# Confirming Analysis

Testing Tables can also be used to _verify_ that a certain analysis is correct. Code that filters a table to show only cats can’t be verified with a Testing Table that _already_ has only cats. (Why not?)

Code that shows only the kittens...sorted in ascending order by weight must be verified by a Table containing cats, non-cats, old and young cats... __and rows that aren’t already sorted!__

<!--

-->
---
{layout="Investigate"}
# Confirming Analysis

* Someone hands you a function called `fixed-cats` and _claims_ that it: given a table of animals, it produces a table with only fixed cats.
* Do you trust it? How could you test it?
* Which animals would you would use in a Testing Table?
---
{layout="Investigate"}
# Confirming Analysis

* Complete @printable-exercise{pages/trust-but-verify.adoc}.
* Open the @starter-file{trust-but-verify}. There are 3 versions of `fixed-cats`. Are they all correct? If not, which ones are broken?
* Turn to @printable-exercise{pages/trust-but-verify-2.adoc}. Using the same Starter File, construct a Testing Table and figure out which (if any) of the functions are correct!

<!--

-->
---
{layout="Synthesize"}
# Confirming Analysis

Complex analysis has more room for mistakes, so it’s critical to think about a Testing Table that allows us to trust that our code really does what it’s supposed to!

*How would you check whether or not a facial recognition system was equally accurate for everyone?*

<!--

-->
---
{layout="Launch"}
# When AI isn't Intelligent... 

Law enforcement in many towns has started using facial-recognition software to automatically detect whether someone has a warrant out for their arrest. 

**A lot of facial-recognition software, however, has been trained on sample data containing mostly white faces**. Why might this be a problem?

<!--

-->
---
{layout="Investigate"}
# When AI isn't Intelligent... 

- Read @link{https://www.theregister.com/2019/05/22/congress_facial_recognition/, this article, summarizing US Congress Testimony on Artificial Intelligence} or watch this 10-minute video @link{https://youtu.be/eRUEVYndh9c, The Coded Gaze: Bias in Artificial Intelligence}.
- Complete @printable-exercise{ai-reflection.adoc}


---
{layout="Synthesize"}
# Synthesize

Discuss the article and/or video. Be sure to end the discussion with a focus on how to address the concerns!

<!--

-->
