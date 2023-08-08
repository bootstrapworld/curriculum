---
{layout="DS Title Slide"}
# Threats to Validity

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Threats to Validity

**Survey says: “People prefer cats to dogs”**

As good Data Scientists, the staff at the animal shelter are constantly gathering data about their animals, their volunteers, and the people who come to visit. But just because they have data doesn’t mean the conclusions they draw from it are correct! 

For example: suppose they surveyed 1,000 cat-owners and found that 95% of them thought cats were the best pet. Could they really claim that people generally prefer cats to dogs?


<!--
Have students share back what they think. The issue here is that cat-owners are not a representative sample of the population, so the claim is invalid.
-->
---
{layout="Launch"}
# Threats to Validity

There’s more to data analysis than simply collecting data and crunching numbers. In the example of the cat-owning survey, the claim that “people prefer cats to dogs” is *invalid* because the data itself wasn’t representative of the whole population (of course cat-owners are partial to cats!). 

This is just one example of what are called @vocab{Threats to Validity}.

<!--

-->
---
{layout="Launch"}
# Threats to Validity

(1) **Selection bias** - Data was gathered from a biased sample of the population. This is the problem with surveying _cat owners_ to find out which animal is most loved!

(2) **Bias in the study design** - Data was gathered using a “loaded” question like “Since annual vet care comes to about $300 for dogs and only about half of that for cats, would you say that owning a cat is less of a burden than owning a dog?” This could easily lead to a misrepresentation of people’s true opinions. 

<!--

-->
---
{layout="Launch"}
# Threats to Validity

(3) **Poor choice of summary data** - Even if the selection is unbiased, sometimes outliers are so extreme that they make the mean completely useless at best - and misleading at worst.

(4) **Confounding variables** - A study might find that cat owners are more likely to use public transportation than dog owners. But it's not that owning a cat means you drive less: people who live in big cities are more likely to use public transportation, _and_ also more likely to own cats.  

More examples of confounding variables can be found in @lesson-link{correlations/pages/correlation-is-not-causation.adoc}.

---
{layout="Investigate"}
# Threats to Validity

On @printable-exercise{pages/threats-to-validity-1.adoc} and @printable-exercise{pages/threats-to-validity-2.adoc}, you’ll find four different claims backed by four different datasets. 

Each one of those claims suffers from a serious threat to validity. Can you figure out what those threats are?

@optional respond to @opt-printable-exercise{selection-bias-v-biased-study.adoc}

<!--

-->
---
{layout="Synthesize"}
# Threats to Validity

**Life is messy, and there are _always_ threats to validity**

Data Science is about doing the best you can to minimize those threats, and to be up front about what they are whenever you publish a finding. When you do your own analysis, make sure you include a discussion of the threats to validity!

<!--

-->
---
{layout="Launch"}
# Fake News!

You've already seen a number of ways that statistics can be misused:

1. Using the mean instead of the median with heavily-skewed data
2. Using the wrong language when describing a Linear Regression
3. Using a correlation to imply causation

<!--

-->
---
{layout="Launch"}
# Fake News!

There are other ways to mislead the audience as well:

**Intentionally using the wrong chart** - suppose the census asks for data from different groups of people, and gets _none_ from one group. That would be very suspicious! The missing group would be an empty space on bar chart, but a pie chart would hide that absence completely - making it less likely that anyone would even notice that group had been "erased"!

**Changing the scale of a chart** - Changing the y-axis of a scatter plot can make the slope of the regression line seem smaller: "look, that line is basically flat anyway!"

---
{layout="Launch"}
# Fake News!

With all the news being shared through newspapers, television, radio, and social media, it’s important to be critical consumers of information!

<!--

-->
---
{layout="Investigate"}
# Fake News!

* On @printable-exercise{pages/fake-news.adoc}, you’ll find some deliberately misleading claims made by slimy Data Scientists. **Why shouldn't these claims should be trusted?**
* Once you’ve finished, consider your own dataset and analysis: what misleading claims could someone make about your work? Turn to @printable-exercise{pages/lies-darned-lies-n-statistics.adoc}, and **come up with four misleading claims based on data or displays from your work.**
* Trade papers with another group, and see if you can figure out why each other’s claims are not to be trusted!


<!--
Have students trade papers with another group, and see if you can figure out why each other’s claims are not to be trusted!
-->
---
{layout="Synthesize"}
# Synthesize

What "lies" did you all come up with?

Was anyone able to stump the other group?

<!--

-->

---
{layout="Launch"}
# Your Analysis

In every analysis, there are always threats to validity. It's important to always be upfront about what those threats are, so that anyone who reads your analysis can make their own decision.

<!--

-->

---
{layout="Investigate"}
# Your Analysis

Fill in the Findings portion of your @starter-file{research-paper}, discussing threats to validity and drawing conclusions from their linear regression results.

<!--
In this @opt-project{project-threats-to-validity.adoc, rubric-threats-to-validity.adoc}, students pretend to be terrible data scientists who develop and support claims based on faulty sampling techniques (selection bias, bias in the study design, poor choice of summary data, and confounding variables). This is a fun opportunity for your students to demonstrate their understanding of the impact of various threats to validity.
-->

---
{layout="Synthesize"}
# Your Analysis

What threats to validity did you find? What were they?

<!--

-->

---
{layout="Supplemental"}
# Additional Practice

- @opt-printable-exercise{pages/identifying-threats-1.adoc}
- @opt-printable-exercise{pages/identifying-threats-2.adoc}
- @opt-printable-exercise{pages/identifying-threats-3.adoc}
- @opt-project{pages/project-threats-to-validity.adoc, pages/rubric-threats-to-validity.adoc}

<!--

-->