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

@image{images/symmetric.png, 300}

In a @vocab{symmetric} distribution, it’s just as likely for the variable to take a value a certain distance below the middle as it is to take a value that same distance above the middle. Examples:

- It’s just as likely for a 12yr old to be a certain number of inches below average height as it is to be that number of inches above average height.
<!--

-->
---
{layout="LaunchR"}
# Describing Shape

@image{images/left-w-foot.png, 300}

In a distribution that is @vocab{skewed left}, values are clumped around what’s typical, but they trail off to the left with a few unusually low values. Examples:

- Most adults will have close to a full set of 32 teeth, but a few hockey players might have a very small number of teeth. We won’t get anyone in our dataset who has 10 or 20 _extra_ teeth in their mouths!
<!--
Think about the toes on your left foot!
-->
---
{layout="LaunchR"}
# Describing Shape

@image{images/right-w-foot.png, 300}

- A dataset of earnings almost always shows right skewness or high outliers, because there are usually a few values that are so far above average, they can’t be balanced out by any values that are so far below average. (Earnings can’t be negative.)
<!--
Think about the toes on your right foot!
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

- Try bins of 1-pound intervals, then 100-pound intervals. Which of these three histograms best satisfies our rule of thumb?
- On @printable-exercise{pages/identifying-shape-histograms.adoc}, describe the shape of the histograms you see there.
- On @printable-exercise{pages/shape-of-animals-dataset.adoc}, describe the pounds histogram and another one you make yourself. When writing down what you notice, try to use the language Data Scientists use, discussing both skew and outliers.
<!--
Debrief and discuss student answers
-->
---
{layout="InvestigateR"}
# Outliers: Do they stay or do they go?

@image{images/height-outlier.png, 300}

Suppose we survey the heights of 12 year olds, and almost all values are clustered between 50-70in. There's a very low outlier, however, at 6in. __Is there really a 6in tall 12 year old?__ 

Probably not! This could very well be a typo (maybe someone meant to type "60" instead of "6"?). "Junk" data is harmful, because it can drastically change your results!

---
{layout="InvestigateR"}
# Outliers: Do they stay or do they go?

@image{images/stadium-outlier.png, 300}

Suppose we survey the number of minutes it takes for fans to find their seats at a stadium, and almost all values are clustered between 4-16 minutes. There's a very high outlier, however, at 35 minutes. __Did it really take someone 35m to find their seat?__

It's possible! Maybe it's someone who takes a long time getting up stairs, or someone who had to go far out of their way to use the wheelchair ramp!

---
{layout="Investigate"}
# Outliers: Do they stay or do they go?

An outlier can be "junk" data that you need to throw away as part of your analysis, or it could be a really important part of your analysis! 

As a data scientist, *an outlier is a reason to look closer*. 

And whether you decide to keep or remove it from your dataset, make sure you *explain your reasons* in your write-up!

Turn to @printable-exercise{pages/outliers-discussion.adoc}, and reflect on whether an outlier should be preserved or removed for analysis.

---
{layout="Synthesize"}
# Synthesize

Histograms are a powerful way to display a dataset and see its @vocab{shape}. But shape is just one of three key aspects that tell us what’s going on with a quantitative dataset. In the next lessons, we’ll explore the other two: center and spread.

<!--

-->

---
{layout="Launch"}
# Your Own Analysis

How would you describe the shape of the quantitative columns in _your_ dataset?

What do those columns represent?

---
{layout="Investigate"}
# Your Own Analysis

- How are the quantitative columns in your dataset distributed?
@printable-exercise{data-cycle-quantitative.adoc}, and use the Data Cycle to explore two quantitative columns with histograms.
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
