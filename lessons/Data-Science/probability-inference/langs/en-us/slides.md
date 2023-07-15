---
{layout="DS Title Slide"}
# Probability, Inference, & Sample Size{style="font-size:36pt"}

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# How to Spot a Scam

@right{@image{images/heads.png, 110}} A stranger on the street invites you to play a game of chance. They’ll flip a coin repeatedly. On each flip, the stranger gives you a dollar if it comes up tails. If it comes up heads, you pay them a dollar.

"It's a pure game of chance", they tell you, "we each have equal odds of winning".
<!--

-->
---
{layout="LaunchR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

If you decide to play the game, how could you then decide if the stranger’s coin is fair, or if the stranger is scamming you?

- For a fair coin, what are the chances of it landing heads? Tails?
- How do you know if a coin is fair or not?

@teacher{
- For a fair coin, what are the chances of it landing heads? Tails?
** _A fair coin has a 50% chance of landing heads and a 50% chance of landing tails._
- How do you know if a coin is fair or not?
** _Flip it! The more flips you make, the more accurately you can assess if it is fair or not._
}

---
{layout="Investigate"}
# How to Spot a Scam

**A fair coin should land on "heads" about as often as it lands on "tails": half the time.**

In general, we assume that in the long run, an ordinary coin will land on "heads" 50% of the time. Our assumption that there is no bias towards "heads" or "tails" is our "null hypothesis". A weighted coin, on the other hand, might be heavier on one side, creating a @vocab{bias} toward one side! And since we lose money on heads, we’re worried about bias in favor of heads.

_How do we test the null hypothesis?_

---
{layout="InvestigateR"}
# How to Spot a Scam

@image{images/heads.png, 110} 

Open @starter-file{fair-coins}, and complete @printable-exercise{fair-coins.adoc}

Do any samples seem to undermine the null hypothesis?

@teacher{
Have students share back their sample results, and their predictions after 5 samples and then 20 samples.}

<!--
@ifproglang{codap}{The above starter file is in Pyret, a coding platform that will be unfamiliar to students. Students do *not* need to know any to complete the lesson. They will simply hit "Run" several times.}
-->

---
{layout="Investigate"}
# How to Spot a Scam

In Statistics and Data Science, samples like these don't *prove* anything about the coins! Instead, they either _produce enough evidence to reject the null hypothesis, or fail to do so_. If the null hypothesis is actually false, larger samples give us a better chance of producing evidence to reject it.

The chances of getting "heads" from a fair coin three times in a row aren't too small: 1-in-8! Maybe it was just the luck of the draw, and the coin is still fair.

@teacher{
*Common Misconceptions*
Students may think that _any_ sample from a fair coin should have an equal number of heads and tails outcomes. That's not true at all! A fair coin _might_ land on "tails" three times in a row! The fact that this is possible doesn't mean it's _likely_. Landing on "tails" five times in a row? Still possible, but much less likely.

This is where arithmetic thinking and statistical thinking diverge: it's not a question of what is _possible_, but rather what is _probable_.}

---
{layout="Investigate"}
# How to Spot a Scam

Should we suspect a scam if the stranger’s coin flipped heads 10 times in a row? The probability of a fair coin getting no tails in 10 flips is @math{{\frac{1}{2}}^{10}}, or roughly 0.001. 

So here’s what we’d have to say about our hypothesis test:

**"If the coin was fair, the probability of getting so few (zero) tails in 10 flips is just 0.001."**

---
{layout="Investigate"}
# How to Spot a Scam

**"If the coin was fair, the probability of getting so few (zero) tails in 10 flips is just 0.001."**

Statisticians would say it slightly differently:
__"If the null hypothesis were true, then the probability of getting sample results at least as extreme as the ones observed is 0.001."__

But of course, there *is* a way. It's just..._incredibly unlikely_.

---
{layout="Synthesize"}
# How to Spot a Scam

- Suppose we are rolling a 6-sided die. How could we tell if it's weighted or not?
- Could a coin come up "heads" twice in a row, and still be a fair coin? Why or why not? What about 10 times in a row? 20?
- What is the relationship between how weighted a coin is, and how many samples you need to figure it out?

@teacher{
- Suppose we are rolling a 6-sided die. How could we tell if it's weighted or not?
** _We could record how many times the die landed on each number after rolling many times. If the die is fair, we should see that it lands on each number approximately equally._
- Could a coin come up "heads" twice in a row, and still be a fair coin? Why or why not? What about 10 times in a row? 20?
** _The coin could be fair in all of these intsances! Heads 20 times in a row, however, is extremely unlikely._
- What is the relationship between how weighted a coin is, and how many samples you need to figure it out?
** _A fair coin should land on heads about 50% of the time._ If a coin has been designed to land on heads _100%_ of the time, it wouldn't take long to figure out that something was up! A trick coin designed to come up heads _60%_ of the time, however, would need a much larger sample to be detected. The smaller the bias, the larger the sample we need to see it. A small bias might be enough to guarantee that a casino turn a profit, and be virtually undetectable without a massive sample!
}

---
{layout="LaunchR"}
# Probability v. Inference

@image{images/heads.png, 110} 

**Probability reasons forwards**

Because we know that the chance of coming up heads each time for a "population" of flips of a fair coin is 0.5, we can do probability calculations like "the probability of getting all three heads in three coin flips is @math{0.5 \times 0.5 \times 0.5 = 0.125}." Likewise, we can say the probability of getting three of a kind in a randomly dealt set of five cards is 0.02.

---
{layout="Launch"}
# Probability v. Inference

"Based on what we know is true in the population, what’s the chance of this or that happening in a sample?" 

_*This is the kind of reasoning involved in probability.*_

---
{layout="Launch"}
# Probability v. Inference

**Inference Reasons Backwards**

In the coin-flip activity, we took samples of coin flips and used our knowledge about _chance_ and _probability_ to make @vocab{inferences} about whether the coin was fair or weighted.

In other words, we looked at sample results and used them to decide what to believe about the population of all flips of that coin: __was the overall chance of heads really 0.5?__


---
{layout="LaunchR"}
# Probability v. Inference

@image{images/heads.png, 110} 

"Based on what we saw in our sample, what do we believe is true about the underlying population?" 

_*This is the kind of reasoning involved in inference.*_

@vocab{Statistical inference} is used to gain information in practically every field of study you can imagine: medicine, business, politics, history; even art!

---
{layout="Launch"}
# Probability v. Inference

Suppose we want to estimate what percentage of all Americans plan to vote for a certain candidate.  We don't have time to ask every single person who they’re voting for, so pollsters instead take a _sample_ of Americans, and _infer_ how all Americans feel based on the sample.

Just like our coin-flip, we can start out with the null hypothesis: assuming that the vote is split equally. Flipping a coin 10 times isn't enough to infer whether it's weighted, and polling 10 people isn't enough to convince us that one candidate is in the lead. _But if we survey enough people_ we can be fairly confident in inferring something about the whole population.

---
{layout="Launch"}
# Probability v. Inference

**Sample size matters!**

* We're taking a survey of religions in our neighborhood. There's a Baptist church right down the street, so we could get a nice big sample by asking everyone there...right?
* Taking a sample of whoever is nearby is called a _convenience sample_. Why is a convenience sample a problem in this example?
* Would it be problematic to only call voters who are registered Democrats? To only call voters under 25? To only call regular churchgoers? Why or why not?

@teacher{
* We're taking a survey of religions in our neighborhood. There's a Baptist church right down the street, so we could get a nice big sample by asking everyone there...right?
** _Sampling this population would reveal to us that everyone in the neighborhood is Baptist, which might not be the case!_
* Taking a sample of whoever is nearby is called a _convenience sample_. Why is a convenience sample a problem in this example?
** _Everyone at the church is Baptist, but the entire neighborhood might not be._
* Would it be problematic to only call voters who are registered Democrats? To only call voters under 25? To only call regular churchgoers? Why or why not?
** _Calling only certain segments of the population will not reveal the way an entire population will vote._
}
---
{layout="Launch"}
# Probability v. Inference

**Bad samples can be an accident - or malice!**

When designing a survey or collecting data, Data Scientists need to make sure they are working hard to get a good, random sample that reflects the population. Lazy surveys can result in some really bad data! _But poor sampling can also happen when someone is trying to hide something, or to oppress or erase a group of people._

{layout="Launch"}
# Probability v. Inference

**Bad samples can be an accident - or malice!**

* A teacher who wants the class to vote for a trip to the dinosaur museum might only call on the students who they know love dinosaurs, and then say "well, everyone I asked wanted that one!"{style="font-size:15pt"}
* A mayor who wants to claim that they ended homelessness could order census-takers to only talk to people in verified home addresses. Since homeless people don't typically have an address, the census would show no homeless people in the city!{style="font-size:15pt"}
* A city that is worried about childhood depression could survey children to ask about their mood...but only conduct the survey at an amusement park!{style="font-size:15pt"}

*Can you think of other examples where biased sampling has been used - or could be used - to harm people?*

---
{layout="Investigate"}
# Probability v. Inference

The main reason for doing inference is to guess about something that’s _unknown_ for the whole population. 

A useful step along the way is to practice with situations where we happen to _know_ what’s true for the whole population. As an exercise, we can keep taking @vocab{random samples} from that population and see how close they tend to get us to the truth.

The Animals Dataset we've been using is just one _sample_ taken from a very large animal shelter.

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

}

**Random samples help avoid bias, and larger samples get closer estimates of what’s true for the whole population.**

---
{layout="Synthesize"}
# Probability v. Inference

* Were larger samples always better for guessing the truth about the whole population? If so, how much better?
* Why is taking a @vocab{random sample} important for avoiding bias in our analyses?

@teacher{
*Common Misconceptions*
Many people mistakenly believe that larger populations need to be represented by larger samples. In fact, the formulas that Data Scientists use to assess how good a job the sample does is only based on the _sample size_, not the population size.}

---
{layout="Supplemental"}
# Additional Exercises

- @opt-project{food-habits-project.adoc, rubric-food-habits.adoc}
- @opt-project{time-use-project.adoc, rubric-time-use.adoc}
