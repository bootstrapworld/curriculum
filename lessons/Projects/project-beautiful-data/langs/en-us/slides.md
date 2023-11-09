@slidebreak

{layout="DS Title Slide"}

# Project: Beautiful Data
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="Launch"}
# Beautiful Data Project

Data visualization is where data science and creativity mix. Data displays are meant to __tell a story__, and storytelling is an art form!

@slidebreak
{layout="Launch"}
# Beautiful Data Project

Take a moment to explore the resources below, and choose **one display** that really interests you:

- @opt-online-exercise{https://pudding.cool/projects/vocabulary/index.html, The Largest Vocabulary in Hip Hop}
- @opt-online-exercise{https://insightfulinteraction.com/immigration200years.html, 200 Years of Immigration}
- @opt-online-exercise{https://informationisbeautiful.net/, Information is Beautiful}

@slidebreak
{layout="Launch"}
# Beautiful Data Project

@right{@image{images/box-n-whisker-plot.png, 250}}Suppose we lined up all animals' weights from smallest to largest, and then split them in half by taking the @vocab{median}.{style="font-size:16pt"}

We can learn something about the @vocab{spread} of the dataset by taking the _median of each half_, splitting the population into four equal-sized @vocab{quartiles}.{style="font-size:16pt"}


<!--
Allow students ample time to check out the provided resources. You might consider inviting a few students to share their reflections on the varying displays.

We recommend printing and distributing the student-facing @handout{beautiful-data-rubric.adoc} to help students understand the scope of the project and your expectations at the outset. Teachers are welcome and encouraged to edit and adapt the rubric for their unique classroom context.
-->

@slidebreak
{layout="Launch"}
# Beautiful Data Project

On @handout{beautiful-data-reflect.adoc}, respond to the first two questions.}


@slidebreak
{layout="Launch"}
# Beautiful Data Project

Today, you're going to get a chance to create your own customized data visualization - one that connects artistic expression to data in ways that are relevant and meaningful.

The first step is to find your data!


@slidebreak
{layout="Launch"}
# Beautiful Data Project

- @lesson-link{choosing-your-dataset/pages/datasets-and-starter-files.adoc, Choose a dataset} that interests you - or one that you're already working with - and use `bar-chart`, `pie-chart`, `histogram`, or `scatter-plot` to create a display.
- Write down a title for the display you created on @handout{beautiful-data-reflect.adoc}, Q3.
- Respond to Q4: What does this display show? Why would it be interesting to someone else?

@slidebreak
{layout="Investigate"}
# Beautiful Data Project


<!--
*Note*: the term “Range” means something different in statistics than it does in algebra and programming!)
-->
@slidebreak
{layout="Investigate"}
# Beautiful Data Project

The scatter plot below suggests a moderate correlation between age and weeks: older animals take longer to be adopted, but it’s not as direct a connection as others might think! It's time to get curious, and ask ourselves: *What data is missing?*

@image{images/age-v-weeks.gif, 300}

<!--

-->
@slidebreak
{layout="InvestigateR"}
# Beautiful Data Project

In the scatter plot, we might wonder whether the species matters, how big the animal is, or whether or not it’s fixed. This gives us both _an observation_ and a _more advanced question_ to ask about our data: *Different species of animals have very different lifespans. Is the correlation between age and adoption time different for each species?*


@image{images/age-v-weeks.gif, 300}


@slidebreak
{layout="Investigate"}
# Beautiful Data Project
 
- Think about at least two columns that might give you more insight into your data, and why those other columns matter in the display(s) you’ve chosen.
- Write the observations and questions in @handout{beautiful-data-reflect.adoc} for Q5.

@slidebreak
{layout="Investigate"}
# Beautiful Data Project

Once we wrote code to add the species column to our data display by customizing the dots, we saw some interesting results!

@image{images/age-v-weeks-species-dot.png, 350}

@slidebreak
{layout="InvestigateR"}
# Beautiful Data Project

Right away, we could see that cats and dogs take longer to be adopted based on their age, but the impact of each extra year is much smaller for cats than for dogs. It’s almost like we have two stronger correlations in the same display: the line for dogs slopes up more steeply, and the line for cats is more gentle. When all the dots looked the same, these lines blurred each other out to create one weak-to-moderate correlation.

@image{images/age-v-weeks-species-dot.png, 350}

@slidebreak
{layout="Investigate"}
# Beautiful Data Project

- In your Pryet file, define a row-consuming function that produces custom images for each Row in your dataset using your new column(s).
- Use that row-consuming function to create a data display that makes the data pop and really shows the deeper patterns at work.
- Write a paragraph about how your custom display uses visual cues to enhance the display. As in our animals example, write about what new insights you gained and why you couldn’t see them in the original display.

<!--
Finally, students publish and submit their completed worksheets and program links. Specify how you would like students to submit Pyret files. Email, a form, or any SMS that allows students to share links (ie, Google Classroom or Schoolology) will work.

Encourage students to self-assess and revise their work. Peer review is a powerful tool if time allows! The @handout{beautiful-data-rubric.adoc, "rubric"} is a useful resource for facilitating both self and peer review.

Finally, celebrate students' work! In many instances, students will want to share their project, given how much time they have invested. Class or public presentations can instill a sense of pride.
-->	

