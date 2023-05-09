---
{layout="DS Title Slide"}
# Visualizing the "Shape" of Data

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Describing Shape

@image{images/skew-right.png,  300}

Shape is one way to _summarize_ information in a dataset, to quickly describe what values are more or less common. 

**It's about more than numbers!** Data Scientists spend a lot of time looking at data displays to examine their shape! 

If all you look at is the numbers, you lose a lot of insight into your dataset.

<!--

-->
---
{layout="Launch"}
# Describing Shape

**Histograms create __fixed-size__ bins, which contain varying numbers of data points.**

We can think of the data being "squeezed" into these fixed bins, like globs of pizza dough being pushed into tubes. When there isn't much data that fits into a bin, the tube is mostly empty. But when lots of data points fall within a bin, the dough stacks up in the tube. This is why the height of a histogram bar tells us how much data is "squeezed" into that bin!

<!--

-->
---
{layout="LaunchR"}
# Describing Shape

@image{images/skew-right.png,  300}

Consider the image on the right: most of the data points are clustered on the left side, and it contains a few unusually high values way off to the right. But how do we describe this shape, and what does it mean?

Let's look at some real-world examples of the most common shapes...

<!--

-->
---
{layout="LaunchR"}
# Describing Shape

@image{images/right-w-foot.png, 300}

In a distribution that is @vocab{skewed right}, values are clumped around what’s typical, but they trail off to the right with a few unusually high values.{style="font-size:18pt"}

(Picture the shape of the toes on your right foot.){style="font-size:12pt"} 

We see this shape often in the real world, because there are many variables -- like “income” or “age” -- for which a few individuals have unusually high values, which aren’t balanced out by unusually low values.{style="font-size:14pt"}

(Things like “income” and "age" can’t be less than zero).{style="font-size:12pt"}

<!--
- Age when a woman in the U.S. gives birth would be skewed right or have high outliers. A few women would be much older (40+ years) than the average age of 26 (check the tabloids!), but none of them could be even close to 40 years _below_ average to balance things out!

- A dataset of earnings almost always shows right skewness or high outliers, because there are usually a few values that are so far above average, they can’t be balanced out by any values that are so far below average. (Earnings can’t be negative.)
-->

---
{layout="LaunchR"}
# Describing Shape

@image{images/left-w-foot.png, 300}

In a distribution that is @vocab{skewed left}, values are clumped around what’s typical, but they trail off to the left with a few unusually low values.{style="font-size:18pt"}

(Picture the toes on your left foot.){style="font-size:12pt"} 

Most adults will have close to a full set of 32 teeth, but a few hockey players might have a very small number of teeth. We won’t get anyone in our dataset who has 10 or 20 _extra_ teeth in their mouths!{style="font-size:14pt"}

---
{layout="LaunchR"}
# Describing Shape

@image{images/symmetric.png, 300}

In a @vocab{symmetric} distribution, it’s just as likely for the variable to take a value a certain distance below the middle as it is to take a value that same distance above the middle. Examples:

It’s just as likely for a newborn baby to be a certain number of ounces below @vocab{average} weight as it is to be that number of ounces above average weight.{style="font-size:14pt"}
<!--

-->
---
{layout="Investigate"}
# Describing Shape

* Open your saved Animals Starter File, or @starter-file{animals, make a new copy}.
* Make a histogram for the pounds column in the animals table, sorting the animals into 20-pound bins:
* Would you describe the shape of your histogram as being skewed left, skewed right, or symmetric?
* Which one of these statements is justified by the histogram’s shape?
  * _A few of the animals were unusually light_
  * _A few of the animals were unusually heavy_
  * _It was just as likely for an animal to be a certain amount below or above average weight._


<!--

-->
---
{layout="Investigate"}
# Describing Shape

- Try bins of 1-pound intervals, then 100-pound intervals. 
- Which of the three histograms you made best satisfies our rule of thumb (aim for 5 to 10 bins)?
- On @printable-exercise{pages/identifying-shape-histograms.adoc}, describe the shape of the histograms you see there.
- On @printable-exercise{pages/shape-of-animals-dataset.adoc}, describe the pounds histogram and another one you make yourself. When writing down what you notice, try to use the language Data Scientists use, discussing both skew and outliers.
<!--
* __Students should enter the code: @show{(code '(histogram animals-table "name" "pounds" 20))}__
* _The histogram is skewed left._
* _The statement "a few of the animals were unusually heavy" is the only one that applies, given the histogram's shape._
* _Our rule of thumb is that a histogram should have between 5–10 bins. The first histogram we made - with 20-pound bins - had a total of ten bins, so it best satisfies our rule._

-->
---
{layout="InvestigateR"}
# Outliers: Do they stay or do they go?

@image{images/height-outlier.png, 300}

Suppose we survey the heights of 12 year olds, and almost all values are clustered between 50-70in. There's a very low outlier, however, at 6in. __Is there really a 6in tall 12 year old?__{style="font-size:14pt"} 

Probably not! This could very well be a typo (maybe someone meant to type "60" instead of "6"?). "Junk" data is harmful, because it can drastically change your results!{style="font-size:14pt"}

---
{layout="InvestigateR"}
# Outliers: Do they stay or do they go?

@image{images/stadium-outlier.png, 300}

Suppose we survey the number of minutes it takes for fans to find their seats at a stadium, and almost all values are clustered between 4-16 minutes. There's a very high outlier, however, at 35 minutes. __Did it really take someone 35m to find their seat?__{style="font-size:14pt"}

It's possible! Maybe it's someone who takes a long time getting up stairs, or someone who had to go far out of their way to use the wheelchair ramp!{style="font-size:14pt"}

---
{layout="Investigate"}
# Outliers: Do they stay or do they go?

An outlier can be "junk" data that you need to throw away as part of your analysis, or it could be a really important part of your analysis!{style="font-size:16pt"} 

__As a data scientist, *an outlier is a reason to look closer*.__ 

And whether you decide to keep or remove it from your dataset, make sure you *explain your reasons* in your write-up!

Turn to @printable-exercise{pages/outliers-discussion.adoc}, and reflect on whether an outlier should be preserved or removed for analysis.{style="font-size:16pt"}

<!--
What Shape Makes Sense?

If time allows, here's a great way to get students walking around and thinking more deeply about distributions!

Using flip-chart paper or whiteboard space, designate poster-sized regions around the classroom titled "Symmetric", "Skew Left", and "Skew Right". You may want to have 2-3 of each, depending on the number of students and size of the classroom. Divide the class into teams, such that each group takes a region of the room.

Each team looks at the region they're in front of, and must (a) draw a histogram with that shape and (b) __brainstorm a sample that would likely result in that distribution__. Once each team has completed the task, the teams rotate to the next poster and brainstorm another sample. They complete this until every team has come up with at least one unique example for symmetric, skew left, and skew right distributions.
-->

---
{layout="Synthesize"}
# Synthesize

Histograms are a powerful way to display a dataset and see its @vocab{shape}. But shape is just one of three key aspects that tell us what’s going on with a quantitative dataset. We will also want to learn about center and spread!

<!--

-->

---
{layout="Launch"}
# Your Own Analysis

Let's take a look at the shape of the quantitative columns in _your_ dataset...

<!--
Scaffolding provided on next slide!
-->

---
{layout="Investigate"}
# Your Own Analysis

- Turn to @printable-exercise{data-cycle-quantitative.adoc}, and use the Data Cycle to explore two quantitative columns with histograms.
- Then add these displays - and your interpretations! - to the "Making Displays" section of your @starter-file{exploration-paper}.
- Do these displays bring up any interesting questions? If so, add them to the end of the document.

---
{layout="Synthesize"}
# Your Own Analysis

Share your findings! 

Were any of them surprising? 

What, if any, outliers did you discover when making histograms?

<!--

-->
