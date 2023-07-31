---
{layout="DS Title Slide"}
# Correlations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Correlations have _Form_

You've learned several ways to analyze a single quantitative variable, such as `age` or `pounds` of the animals in our dataset: 

- reporting the center
- computing on the spread
- describing the shape of the distribution 

Together, those numbers tell us what value is **typical**, how much the values **vary**, and what kind of values are **usual or unusual**.

@teacher{(The bolded words above all deal with notions of what it means for a value to be "normal" or "abnormal". These words have loaded meaning in the context of variability, and should be used carefully!)}
---
{layout="Launch"}
# Correlations have _Form_

But those analyses tell us nothing about the **relationship** between animals' ages and weights. 

In order to understand such relationships, we have to expand our view from one column to two. 

This goes hand-in-hand with expanding our display **from a 1-dimensional histogram or box plot to a 2-dimensional scatter plot.**

<!--

-->

---
{layout="InvestigateC"}
# Correlations have _Form_

Form tells us whether a relationship is linear, non-linear or undefined.

@image{images/form.png}

---
{layout="InvestigateR"}
# Correlations have _Form_

**Linear relationships** only make sense if the scatter plot follows a _straight-line pattern_, as in this scatter plot. 

@image{images/1b1.gif}

---
{layout="InvestigateR"}
# Correlations have _Form_

Some patterns are **non-linear**, and may look like a curve or an arc. That means there _is_ a relationship, but it's not purely going up or down.

@image{images/2NL.gif}

---
{layout="InvestigateR"}
# Correlations have _Form_

@image{images/B.gif}

And sometimes there is **no relationship** or pattern at all! That means there's no predictable change in the y-axis as we go from one side of the x-axis to the other.

---
{layout="Investigate"}
# Correlations have _Form_

Turn to @printable-exercise{pages/identifying-form.adoc}, and complete __just the first question__ for each scatter plot, identifying whether the relationship is linear, non-linear or if there's no relationship at all.

<!--
Have the class discuss their answers
-->
---
{layout="Synthesize"}
# Correlations have _Form_

- Which scatter plots seem to have _linear_ relationships?
- Which scatter plots seem to have _non-linear_ relationships?
Which scatter plots seem to have _no relationships_?

<!--
Data Scientists use their eyes all the time! It doesn't make sense to search for correlations when there's no pattern at all, and summarizing with a correlation only makes sense for linear relationships!
-->

---
{layout="LaunchC"}
# Correlations have _Direction_

_Direction_ tells us whether a linear relationship is **positive** or **negative**.

@image{images/direction.png}

---
{layout="LaunchR"}
# Correlations have _Direction_

@right{@image{images/C.gif, 200}}

A **positive** direction means that the line slopes up as we look from left-to-right. Positive relationships are by far most common because of natural tendencies for variables to increase in tandem. For example, “the older the animal, the more it tends to weigh”. This is usually true for human animals, too!

---
{layout="LaunchR"}
# Correlations have _Direction_

@right{@image{images/A.gif, 200}}

A **negative** direction means that the line slopes _down_ as we look from left-to-right. Negative relationships can also occur. For example, “the older a child gets, the fewer new words he or she learns each day.”

<!--
-->
---
{layout="Investigate"}
# Correlations have _Direction_

Complete @printable-exercise{pages/identifying-form.adoc} and focus __just on the second question__, determining whether each of the relationships they previously identified as linear is positive or negative.

<!--
Have the class discuss their answers
-->
---
{layout="SynthesizeR"}
# Correlations have _Direction_

@image{images/2NL.gif}

It only makes sense to look for direction in *linear* relationships!

Why do you think that is?

<!--

-->

---
{layout="LaunchC"}
# Correlations have _Strength_

**Strength** indicates how closely the two variables are correlated.


---
{layout="LaunchR"}
# Correlations have _Strength_

@right{@image{images/A.gif}}**A relationship is strong if knowing the x-value of a data point gives us a very good idea of what its y-value will be** (knowing a student's age gives us a very good idea of what grade they're in). A strong linear relationship means that the points in the scatter plot are all clustered _tightly_ around an invisible line.

<!--
Example of a strong relationship: knowing a student's age gives us a very good idea of what grade they're in
-->

---
{layout="LaunchR"}
# Correlations have _Strength_

@right{@image{images/1a.gif}}**A relationship is weak if x tells us little about y** (a student's age doesn't tell us much about their number of siblings). A weak linear relationship means that the cloud of points is scattered very _loosely_ around the line.


---
{layout="Investigate"}
# Correlations have _Strength_

- Complete @printable-exercise{pages/identifying-form.adoc}, and focus on the third question for each scatter plot, identifying whether the relationship is strong or weak.
- Optional: Complete the card sort on @opt-online-exercise{ https://teacher.desmos.com/activitybuilder/custom/6018c857328251526caea801, Identifying Strength}.

<!--
Have the class discuss their answers
-->
---
{layout="Synthesize"}
# Correlations have _Strength_

- Complete @printable-exercise{pages/reflection-correlations.adoc}.
- Be ready to discuss your answers with the class!

<!--
The worksheet here addresses some common misconceptions:

- Students often conflate strength and direction, thinking that a strong correlation _must_ be positive and a weak one _must_ be negative.
- Students may also falsely believe that there is ALWAYS a correlation between any two variables in their dataset.
- Students often believe that strength and sample size are interchangeable, leading to mistaken assumptions like "any correlation found in a million data points _must_ be strong!"

If time permits, you might also want to have them complete @opt-printable-exercise{pages/identifying-form-matching.adoc}.

-->
---
{layout="Launch"}
# Summarizing Correlations using r-values

You've learned that a correlation can be described by three pieces of information: _Form_, _Direction_, and _Strength_.

Statisticians and Data Scientists have a shorter way of describing all three, called @vocab{r-value}.

<!--

-->
---
{layout="Launch"}
# Summarizing Correlations using r-values

**@math{r} is positive or negative depending on whether the correlation is positive or negative.**

*The strength of a correlation is the distance from zero*: an @math{r}-value of zero means there is no correlation at all, and stronger correlations will be closer to −1 or 1.

<!--

-->
---
{layout="Launch"}
# Summarizing Correlations using r-values

An @math{r}-value of about **±0.65 or ±0.70 or more is generally considered a strong correlation**. 

Anything between **±0.35 and ±0.65 is “moderately correlated”**. 

Anything less than about **±0.25 or ±0.35 may be considered weak**. 

**However, these cutoffs are not an exact science!** In some contexts an @math{r}-value of ±0.50 might be considered impressively strong!

<!--
If it works for you, give students five minutes to play a few rounds of the online game @link{http://guessthecorrelation.com/, Guess the Correlation} to develop intuition with r-values. (This will require creating an account.)
-->
---
{layout="Investigate"}
# Summarizing Correlations using r-values

- Complete @printable-exercise{pages/identifying-form-open-ended.adoc}. For each scatter plot, identify whether the relationship is linear, and, if it is, use @math{r} to summarize direction and strength.
- Be prepared to discuss your answers with the class!

---
{layout="Investigate"}
# Summarizing Correlations using r-values

**Calculating @math{r} from a dataset only tells us the direction and strength of the relationship in _that particular sample_.**

If the correlation between adoption time and age for a representative sample of about 30 of our shelter animals turns out to be +0.44, the correlation for the larger population of animals will probably be _close_ to that, but certainly not the same.

---
{layout="Investigate"}
# Summarizing Correlations using r-values

**Correlation does NOT imply causation.**

It’s easy to be seduced by large @math{r}-values, and believe that we're really onto something that will help us claim that one variable really impacts another! But Data Scientists know better than that...

Complete @printable-exercise{correlation-is-not-causation.adoc}
<!--
If time allows, you may want to emphasize the point that correlation does not imply causation by having students look at the nonsense claims that could be made from the graphs of real world data on the @link{http://tylervigen.com/, Spurious Correlations website}.
-->
---
{layout="Investigate"}
# Summarizing Correlations using r-values

- Let's look for correlations in the Animals Dataset!
- Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
- Complete @printable-exercise{correlations-animals.adoc}.

---
{layout="Synthesize"}
# Summarizing Correlations using r-values

Which corresponded more strongly with time to adoption, `"age"` or `"pounds"`? What does this _mean_?

- People often confuse correlation with causation. What are some examples of this?
- Why is it a problem for society, that people confuse the two?

<!--
_The correlation with `"pounds"` is higher, meaning that an animal's weight is a better predictor of the number of weeks an animal will live at the shelter before being adopted than its age._
-->
---
{layout="Launch"}
# Your Analysis

- What correlations do you think there are in your dataset? 
- Would you like to investigate a grouped sample (subset) of your data to find those correlations?

---
{layout="Investigate"}
# Your Analysis

- Brainstorm a few possible correlations that you might expect to find in your dataset, and make some scatter plots to investigate.
- Turn to @printable-exercise{pages/correlations-in-my-dataset.adoc}, and list three correlations you’d like to search for.
- Investigate these correlations. If you're using a printed workbook, you'll find blank Design Recipes and Data Cycles at the back, just before the Contracts.

---
{layout="Synthesize"}
# Correlations in the Animals Dataset

- What correlations did you find?
- Did you search within any grouped samples? Was the correlation different between groups, or different from the whole population?
- What can you infer from these correlations?
