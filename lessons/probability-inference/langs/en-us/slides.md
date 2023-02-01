---
{layout="DS Title Slide"}
# Probability, Inference, & Sample Size{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

A stranger on the street invites you to a game of chance. They'll flip a coin, and you'll win money if you can predict whether it lands heads-or-tails. If you guess wrong, however, you pay THEM. 

"It's a pure game of chance", they tell you, "we each have equal odds of winning".
<!--

-->
---
{layout="LaunchR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

- What do you think? Can you trust them to play fair?
- For a fair coin, what are the chances of it landing heads? Tails?
- How do you know if a coin is fair or not?

<!--

-->
---
{layout="Investigate"}
# How to Spot a Scam

**A fair coin should land on "heads" about as often as it lands on "tails".**

When we approach a strange coin, we start out assuming that it's fair and will land on "heads" about 50% of the time. 

This is called the @vocab{null hypothesis}. A weighted coin, on the other hand, might be heavier on one side to force it to come up heads more often! But how do we test whether a coin is fair or not? 

_How do we test the null hypothesis?_


<!--

-->
---
{layout="InvestigateR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

Open @starter-file{fair-coins}, and complete @printable-exercise{fair-coins.adoc}

There are a few coins defined in this file. Which ones are fair? Which ones are weighted?

<!--
Have students share back their sample results, and their predictions after 5 samples and then 20 samples.

Which samples seem to support the null hypothesis? Which ones undermine it?
-->
---
{layout="Investigate"}
# How to Spot a Scam

In Statistics and Data Science, samples like these don't *prove* any claim about the coins! Instead, they either _produce evidence for or against_ a claim. The larger the sample, the more evidence we have to _support or reject the @vocab{null hypothesis}_. 

The chances of flipping "heads" from a fair coin three times in a row are pretty good: one-in-8! Maybe it was just the luck of the draw, and the coin is still fair. 

<!--
*Common Misconceptions*
Students may think that _any_ sample from a fair coin should have an equal number of heads and tails outcomes. That's not true at all! A fair coin _might_ land on "tails" three times in a row! The fact that this is possible doesn't mean it's _likely_. Landing on "tails" five times in a row? Still possible, but much less likely.

This is where arithmetic thinking and statistical thinking diverge: it's not a question of what is _possible_, but rather what is _probable_.
-->
---
{layout="InvestigateR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

But what are the chances of flipping "heads" 10 times in a row? 100 times? We might say "There's a one in a million chance of a fair coin coming up heads 100 times. No _way_ is this coin fair!"

But of course, there *is* a way. It's just..._incredibly unlikely_.

<!--
*Common Misconceptions*
Students may think that _any_ sample from a fair coin should have an equal number of heads and tails outcomes. That's not true at all! A fair coin _might_ land on "tails" three times in a row! The fact that this is possible doesn't mean it's _likely_. Landing on "tails" five times in a row? Still possible, but much less likely.

This is where arithmetic thinking and statistical thinking diverge: it's not a question of what is _possible_, but rather what is _probable_.
-->
---
{layout="Synthesize"}
# How to Spot a Scam

- Suppose we are rolling a 6-sided die. How could we tell if it's weighted or not?
- Could a coin come up "heads" twice in a row, and still be a fair coin? Why or why not? What about 10 times in a row? 20?
- What is the relationship between how weighted a coin is, and how many samples you need to figure it out?

<!--

-->
---
{layout="Synthesize"}
# How to Spot a Scam

A fair coin should land on heads about 50% of the time. If a coin landed on heads _100%_ of the time, it wouldn't take long to figure out that something was up!

But a trick coin that comes up heads 60% of the time would need a much larger sample to be detected. There's a connection to be found here, between _sample size_ and _deviation_. **A subtle deviation might be enough to guarantee that a casino turn a profit, and be virtually undetectable without a massive sample!**

<!--

-->

---
{layout="LaunchR"}
# Probability v. Inference

@image{images/heads.png, 110} 

In the coin-flip activity, we took samples of each coin and used our knowledge of _probability_ to make _inferences_ about whether the coins were fair or weighted.

In other words, we *knew how the coin should behave before we even started sampling* coin-flips, and then checked to see if the samples matched our expectation.

<!--

-->

---
{layout="Launch"}
# Probability v. Inference

In statistics, we run the process in reverse: we take a sample and then *_infer_ something we didn't know to begin with*.

**Inference Reasons Backwards; Probability Reasons Forwards.**

<!--

-->

---
{layout="Launch"}
# Probability v. Inference

@vocab{Statistical inference} is used to gain information in practically every field of study you can imagine: medicine, business, politics, history; even art!

Suppose we want to estimate what percentage of all Americans plan to vote for a certain candidate.  We don't have time to ask every single person who they’re voting for, so pollsters instead take a _sample_ of Americans, and _infer_ how all Americans feel based on the sample.


<!--

-->

---
{layout="Launch"}
# Probability v. Inference

Just like our coin-flip, we can start out with the null hypothesis: assuming that the vote is split equally. Flipping a coin 10 times isn't enough to infer whether it's weighted, and polling 10 people isn't enough to prove that one candidate is in the lead. _But if we survey enough people_ we can infer something about the whole population.

**Sample size matters!**
<!--

-->

---
{layout="Launch"}
# Probability v. Inference

**But there's more to taking a good sample than just taking a _big_ sample.**
* We're taking a survey of religions in our neighborhood. There's a Baptist church right down the street, so we could get a nice big sample by asking everyone there...right?
* Taking a sample of whoever is nearby is called a _convenience sample_. Why is a convenience sample a problem in this example?
* Would it be problematic to only call voters who are registered Democrats? To only call voters under 25? To only call regular churchgoers? Why or why not?

<!--

-->
---
{layout="Launch"}
# Probability v. Inference

**Why would someone want a BAD sample?**

When designing a survey or collecting data, Data Scientists need to make sure they are working hard to get a good, random sample that reflects the population. Lazy surveys can result in some really bad data! _But poor sampling can also happen when someone is trying to hide something, or to oppress or erase a group of people._

For example: A teacher who wants the class to vote for a trip to the dinosaur museum might only call on the students who they know love dinosaurs, and then say "well, everyone I asked wanted that one!"{style="font-size:14pt"}

<!--
Another example
* A city that is worried about childhood depression could survey children to ask about their mood...but only conduct the survey at an amusement park!
-->
---
{layout="Launch"}
# Probability v. Inference

**Why would someone want a BAD sample?**

A mayor who wants to claim that they ended homelessness could order census-takers to only talk to people in verified home addresses. Since homeless people don't typically have an address, the census would show no homeless people in the city!

*Can you think of other examples where biased sampling has been used - or could be used - to harm people?*
---
{layout="Investigate"}
# Probability v. Inference

The main reason for doing inference is to guess about something that’s _unknown_ for the whole population. 

...and the Animals Dataset we've been using is just one _sample_ taken from a very large animal shelter!

@ifproglang{pyret}{

---
{layout="Investigate"}
# Probability v. Inference

How much can we infer about the whole population of hundreds of animals, by looking at just this one sample? 

Let’s see what happens if we switch from smaller to larger sample sizes.

- **Open** the @starter-file{expanded-animals}, **save** a copy and click "**Run**".
- Complete @printable-exercise{pages/sampling-and-inference.adoc}, sharing their results and discussing with the group.
- Optional: complete @opt-printable-exercise{pages/predictions-from-samples.adoc}

}
<!--
Divide the class into groups of 3-5 students.
-->


@ifproglang{codap}{
---
{layout="Investigate"}
# Probability v. Inference

We're going to analyze which is better at guessing the truth about an entire population - a small sample of 10 randomly selected animals, or a large sample of 40 randomly selected animals.

---
{layout="InvestigateR"}
# Probability v. Inference

@image{images/sampler-plugin-default.PNG,250}

Select `Sampler` from the Plugins dropdown menu.

The `Sampler` plugin features a _Mixer_, _Spinner_, and _Collector_. Today, we’ll be using the _Collector_, which chooses a specified number of cases from a dataset.

What do you _notice_ about the `Sampler`? What do you _wonder_?
<!--
Possible wonderings include: How many turquoise balls are there? Why is there that amount? How many brackets are alongside the collection of turquoise balls? Why are there that many?
-->
---
{layout="Investigate"}
# Probability v. Inference

*With or without "replacement"?*

If we pick cards from a deck, each sample _changes the outcomes_ of the ones that follow. There's only one Ace of Hearts in the deck, and you can't draw it twice! When flipping a coin, each sample has the same number of possible outcomes as the one before: heads or tails. It's as if each one has been _replaced_ with a copy of the same outcome.

---
{layout="Investigate"}
# Probability v. Inference

*Rolling dice or flipping a coin?* Sampling _with_ replacement. 

*Drawing cards from a deck?* Sampling _without_ replacement.

- Can you think of other examples for each?
- Select the `Options` tab of the `Sampler`.
- Which makes the most sense for our dataset: collecting cases _with replacement_ or _without replacement_?

<!--
Discuss with the class, making sure everyone understands which one this is!
-->
---
{layout="Investigate"}
# Probability v. Inference

- Designate the number of items to select and the number of samples to collect.
- What would it mean to select three samples of five items each? (These are CODAP's default settings.)
- Enter the correct specifications for 1 collection of 10 items.
-  Click `Start` to observe the sampling simulation.
- When it's complete, the sample will be shown as a new table called itled `experiment/samples/items`. Rename it (by clicking on its title) to `small-sample`.


<!--
Ensure that students understand all the components of the new table they’ve created!
-->
---
{layout="Investigate"}
# Probability v. Inference

- We want `large-sample` (on the worksheet) to be its own unique table! To produce a new table using `Sampler`, reopen the plugin rather than simply modifying the number of items.
- Complete @printable-exercise{pages/sampling-and-inference.adoc}, sharing their results and discussing with the group.

<!--
Divide the class into groups of 3-5 students.
-->
}
---
{layout="Synthesize"}
# Probability v. Inference

* Were larger samples always better for guessing the truth about the whole population? If so, how much better?
* Why is taking a random sample important for avoiding bias in our analyses?

<!--
*Common Misconceptions*
Many people mistakenly believe that larger populations need to be represented by larger samples. In fact, the formulas that Data Scientists use to assess how good a job the sample does is only based on the _sample size_, not the population size.
-->
---
{layout="Supplemental"}

- Project: @opt-project{food-habits-project.adoc, rubric-food-habits.adoc}
- Project: @opt-project{time-use-project.adoc, rubric-time-use.adoc}
