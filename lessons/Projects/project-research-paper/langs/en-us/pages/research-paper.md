# Research Paper

## <Title>
A data analysis performed by
<First and Last Name(s)>
for <Teacher Name>
on <Date>

<span style="color:blue"> 
NOTE: You are going to see a LOT of blue text in this file… this text is here to provide you with examples, please delete it as you complete each section.
</span>

Published Pyret file:  
<span style="color:blue"> 
&lt;Insert Link - You will have to republish your code & manually update this as the file changes. Hint: If you want to save the Pyret expressions you used to make the Data Displays in the file, add them to the Definitions Area. If you don’t want them to build every time, you can comment them out with # at the beginning of the line, just as you would comment any other notes for yourself or your teammates.&gt;
</span>

Link to spreadsheet:  <Insert Link>

## About the Data
Why is this topic important to you, and to your friends, family, and/or community? Why should someone outside your community care about this topic?

<span style="color:blue"> 
Copy & paste from your “Exploring a Dataset” file. 
</span>

Where did the dataset come from? How many rows does it have, and what do they represent? What columns does it have? Are they categorical or quantitative? What data types are they?

<span style="color:blue">
Copy & paste from your “Exploring a Dataset” file
</span>

Let’s consider the columns of the dataset. Describe two categorical columns and two quantitative columns.  Provide the datatype and a few examples from each column.
</span>

<span style="color:blue">
Refer to your dataset to respond to this question.

## Research Questions

What question(s) are you trying to answer? Why do the question(s) matter? Who would care about the answers to these questions?

<span style="color:blue"> 
Copy and paste the most interesting questions from the end of your “Exploring a Dataset” file and tell us why they matter.

EXAMPLE:
We want to know how much the weight of an animal affects the time it takes to be adopted. If weight is really important, and we know that different breeds of animals are larger than others, we could predict how sales of different breeds at pet stores are going to affect the animals that shelters need to house for a long time
</span>

What are some different subsets that made sense for your dataset?

<span style="color:blue"> 
EXAMPLE:
We needed to create grouped samples for just the dogs, just the rabbits, and just the cats, as well as the young animals and the old ones. Since most animals reach maturity after one year, we decided that any animal under the age of 1 is "young".

We defined the following functions: is-dog, is-cat, is-rabbit, is-old, and is-young

Grouped samples were created using:
```dogs = filter(animals-table, is-dog)```
```cats = filter(animals-table, is-cats)```
```rabbits = filter(animals-table, is-rabbit)```
```old = filter(animals-table, is-old)```
```young = filter(animals-table, is-young)```
</span>

## Analysis

Tell your Data Story, describing each of the Data Cycles you used. You should share any relevant displays and measures that you made, the findings you took from them, and the question(s) they sparked. 

<span style="color:blue"> 
EXAMPLE:
We started out making a scatter plot for all the animals, using pounds as the explanatory variable and weeks as the response variable:
scatter-plot(animals-table, "name", "pounds", "weeks")

INSERT IMAGE WITH HTML

The resulting scatter plot clumps most of the data on the bottom-left corner of the chart. That means there are a few outliers that weigh a lot, and/or take a long time to be adopted. This is consistent with our measures of center and spread for these columns! It looks like the points tend to slope up as we go farther to the right, which might mean there’s a connection between how much an animal weighs and how long it takes to be adopted.

We also made a similar scatter plot for grouped samples of data, looking at young v. old animals, as well as a sample of just the dogs….

&lt; more data stories here &gt;

We computed the R-value for the scatter plot of all the animals, and found a moderate, positive correlation (R=0.65) between pounds and weight. The correlations for other grouped samples were…

&lt; more correlation discussion &gt;

We performed linear regression on these columns, producing the chart below:


The predictor function has a slope of 0.083, meaning that for each additional pound we predict an additional 0.83 additional weeks for that animal to find a home. We repeated this analysis, for dogs, cats, rabbits, old animals and young animals…

&lt; more analysis here &gt;
</span> 

## Discussion

Summarize your findings. Provide any insights or conclusions.

<span style="color:blue"> 
EXAMPLE:
Ultimately, there does appear to be a connection between an animals’ weight and it's time-to-adoption. This connection is stronger for dogs than for the general population, but not stronger for cats…

&lt; continued discussion of findings &gt;
</span> 

What are possible threats to validity? How do they impact your findings?

<span style="color:blue"> 
EXAMPLE:
It’s possible that there was some selection bias at work. Since we don’t know which shelter the animals dataset came from, we have no way of knowing if the animals at this shelter are representative of animals at other shelters. There could also be confounding variables: perhaps all the apartments near this one shelter only allow small dogs, which is skewing the dataset by making larger dogs much harder to adopt than they would be in another neighborhood.

&lt; continued discussion of threats to validity &gt;
</span> 

Are there any ethical implications?

<span style="color:blue"> 
EXAMPLE:
Publishing this data might convince other people that larger dogs are less desirable, and lead to an unfair bias against large dogs. Instead of merely reporting on this phenomenon, this paper might make the phenomenon worse!

&lt; continued discussion of ethical implications &gt;
</span> 


What are some opportunities for further analysis, and future research?

<span style="color:blue"> 
EXAMPLE:
It would be useful to gather more data from other animal shelters, to increase our sample size. It would also be nice to gather data on specific breeds of animals, since that may have played a role in adoption time…
</span> 


Confirm you have incorporated at least one interesting:
&#9744; Pie Chart		&#9744; Bar Chart		&#9744; Scatter Plot
&#9744; Histogram		&#9744; Box Plot 		&#9744; Linear Regression Plot
