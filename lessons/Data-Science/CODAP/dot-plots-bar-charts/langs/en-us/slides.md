@slidebreak
{layout="DS Title Slide"}  
# Dot Plots and Bar Charts  

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="Launch"}
# Displaying Categorical Variables

Where have you seen infographics and graphs used to display data in the real world?

<!--
    Solicit student responses, and then share with them that today's lesson is all about producing displays in CODAP. Explain that, as a class, you'll walk through some of the basic mechanics of creating a display - and then students will have the opportunity to independently create and explore displays in CODAP.
-->

@slidebreak
{layout="LaunchC"}
# Displaying Categorical Variables

- Open  @starter-file{animals} in CODAP.
- Click the `graph` icon from the horizontal toolbar in the upper left. What appears?

@image{images/codap-upper-left-toolbar.png, 500}

@slidebreak
{layout="LaunchR}
# Displaying Categorical Variables

- Select a dot with your mouse. What happens?
- What happens when you select a table row? How about multiple table rows?
- What happens when you click the "eye" icon (to the right of the graph or the table, depending on which is selected)?


<!--
If students report that a blank graph appears (rather than a scatter plot), prompt them to whitelist CODAP on their ad-blocker. Ad-blockers do seem to inhibit some of the functionality of CODAP (which will fortunately never advertise to users!).

- Select a dot with your mouse. What happens?
** _The dot turns blue, and the corresponding row in the table is highlighted._
- What happens when you select a table row? How about multiple table rows?
** _The corresponding dot(s) turn blue._
- What happens when you click the "eye" icon (to the right of the graph or the table, depending on which is selected)?
** _A menu appears._

-->

@image{images/codap-initial-display.png}


@slidebreak
{layout="Launch"}
# Displaying Categorical Variables

Until we assign variables for the axes, the data points are randomly distributed on the graph. 

Hovering over an orange dot reveals the `name` of that particular animal. Selecting a particular dot causes the table row for that animal to be highlighted in blue. Holding the shift button allows you to select multiple dots in the graphical display, or multiple rows in the table.



@slidebreak
{layout="Launch"}
# Displaying Categorical Variables

When you select a table row (or multiple table rows), the corresponding dots change color. When you set aside selected and / or unselected cases (by using the "eye" icon), you can temporarily alter the amount of pets in the dataset (with the option to restore to the original dataset).

You can also resize the window by dragging its borders.

@slidebreak
{layout="Investigate-DN"}
# Displaying Categorical Variables

Once we have a graph of randomly distributed data points, we can organize the data by selecting attributes from our _table_ that we want to appear on the axes of our graph.

- Practice manipulating the data by completing @printable-exercise{pages/codap-displays-intro.adoc}.
- @optional To dig deeper into bar charts, complete @opt-printable-exercise{bar-chart-notice.adoc}.

<!--
Remind students that categorical data is used to classify, rather than to measure. Only when data is being treated categorically will students be invited to fuse data points to create a bar chart. Quantitative (or numeric) data must measure or compare; it is subject to the laws of arithmetic.

When students make a display of the `sex` of the animals, they will see that some animals are male, some are female and some are hermaphrodites. We use the descriptor _sex_ rather than _gender_ because sex refers to biology, whereas gender refers to identity. Hermaphrodite is the biological term for animals that carry eggs & produce sperm (nearly 1/3 of the non-insect animal species on the planet!). Plants that produce pollen & ovules are also hermaphrodites. While the term was previously used by the medical community to describe intersex people or people who identify as transgender or gender non-binary, it is not biologically accurate. Humans are not able to produce both viable eggs and sperm, so "hermaphrodite" is no longer considered an acceptable term to apply to people.

-->

@slidebreak
{layout="Investigate"}
# Displaying Categorical Variables

Bar charts look a lot like another kind of display called a "histogram", which displays _numeric_ data, not categorical. 

Creating each of these displays begins the same way: we create a dot plot, and then modify it using CODAP's menus. Depending on what type of data the dot plot displays, we can transform it into either a bar chart (for categorical data) or a histogram (for numeric data).

@slidebreak
{layout="Synthesize"}
# Displaying Categorical Variables

Bar charts display how much of the sample belongs to each category. If they are based on sample data from a larger population, we use them to _infer_ the proportion of a whole population that might belong to each category.

Pie charts display categorical data, too, but CODAP doesn't offer them largely because many find them @link{https://www.data-to-viz.com/caveat/pie.html, "challenging to read."}

@slidebreak
{layout="Synthesize"}
# Displaying Categorical Variables

Bar charts are mostly used to _display categorical columns_.

While bars in bar charts should follow some logical order (alphabetical, small-medium-large, etc), they can technically be placed in _any_ order, without changing the meaning of the chart.

<!--
Infographics are a powerful tool for communicating information, especially when made by people who actually understand how to connect visuals to data in meaningful ways. @opt-project{infographics.adoc, infographic-rubric.adoc} is an opportunity for students to become more flexible math thinkers while tapping into their creativity. This project can be made on the computer or with pencil and paper. There's also an @link{pages/infographic-rubric.html, Infographics Rubric} to highlight for you and your students what an excellent infographic includes.
-->

@slidebreak
{layout="Launch"}
# Exploring Other Displays

There are _lots_ of different kinds of charts and plots that we can build in CODAP! 

Spend three minutes seeing how many different displays you can produce using @starter-file{animals}. Be playful! Click buttons and select from menu options to see what you can produce. 

<!-- 
If students need a bit of encouraging, you might prod them to make histograms and scatterplots!)
-->

@slidebreak
{layout="Launch"}
# Exploring Other Displays

Let's share!

* What did you discover?
* When did the `configuration` menu appear? (That's the one that looks like a stacked bar chart.)
* When did the `measure` menu appear? (That's the one that looks like a ruler.)

<!--
- The configuration menu appears when there is another possible configuration of the data. For instance, when dots can be fused into bars - we see this menu.
- The measure menu appears when there is an opportunity to change what is shown *along with the points* (that is, on the same display as a dot plot or scatterplot) - for instance, connecting lines or calculating the count. Histograms and boxplots appear alongside an existing display, so they appear are on the `measure` menu._
-->

@slidebreak
{layout="Investigate"}
# Exploring Other Displays

CODAP is designed to be student-friendly, and its interface encourages guesswork... but we can save some time by being a bit more strategic.

@slidebreak
{layout="Investigate"}
# Exploring Other Displays

We're going to complete @printable-exercise{pages/plot-practice.adoc} together. To make a dot plot showing the sex of animals from the shelter, I will ask myself a series of important questions.

* Which attributes on which axes?
* What type of data?
* What configuration?

<!--
* Which attributes on which axes? _Sex belongs on the either axis._
* What type of data? _Male, female, and hermaphrodite are all categories. The bar chart will display categorical data._
** _CODAP initially creates a dot plot of the data, so no special configuration is needed._

Focus on supporting students in learning how to pose productive questions when looking at data. Invite students to repeat the process you just modeled as they create a bar chart (Q2 on the same page) that shows the species of animals from the shelter.

It might sound like this:
- Which *Column / Attribtue* on which axes?
** _Species belongs on either axis._
- What *Type of Data*?
** Cat, dog, etc. are all categories. The chart will display categorical data.
- What configuration?
** _We need to fuse the dots into bars._
-->

@slidebreak
{layout="Investigate-DN"}
# Exploring Other Displays

- With your partner, complete @printable-exercise{pages/plot-practice-2.adoc} and @printable-exercise{pages/plot-practice-3.adoc}.
- Finally, summarize what you've observed about what display goes with what kind of data on the @printable-exercise{data-displays-organizer.adoc}. It may help to refer back to the "Practice Plotting" worksheets that you just completed. *The "Notes" column can be filled in today, or you can add to it in future classes to use a reference.*

<!--
There are _many_ possible misconceptions about displays that students may encounter here. *But that's ok!* Understanding all those other plots is _not_ a learning goal for this lesson. Rather, the goal at this stage is to have them build familiarity and confidence with the CODAP tool and how it makes data displays.
-->

@slidebreak
{layout="Synthesize"}
# Exploring Other Displays

Today you’ve added more data displays to your toolbox. You can create dot plots and bar charts to visually display categorical data, and you've developed a general approach to guide you as you create other displays.

- What displays did you find that work with just one column of data?
- What displays did you find that work with more than one column of data?
- What displays did you find that work with categorical data?
- What displays did you find that work with quantitative data?



<!--
- What displays did you find that work with just one column of data?
** _dot plots, bar charts, histograms and box plots_
- What displays did you find that work with more than one column of data?
** _scatter plots and lr-plots_
- What displays did you find that work with categorical data?
** _dot plots and bar charts_
- What displays did you find that work with quantitative data?
** _histograms, box plots, scatterplots, and lr-plots_
-->


