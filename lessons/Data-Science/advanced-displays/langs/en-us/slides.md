---
{layout="DS Title Slide"}
# Advanced Displays

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Processing Rows with Functions

@center{@image{images/age-v-weeks-species-dot.png}}

Sometimes, data science means you need to be creative and artistic!

How is this plot different from ones you've seen before?

This scatter plot isn't just _prettier_ - it's also more useful! Scatter plots typically only show two variables from each Row in the Table (the x and y), but this plot is showing us **three**.

What is the third column being visualized here?
<!--
The third column being visualized is `species`! By drawing the dots differently, we've been able to pack a third dimension of data into an otherwise 2d graph.
-->
---
{layout="Launch"}
# Processing Rows with Functions

To dig deeper into your data, sometimes you need to see more than 2 variables at once! By processing each Row separately, we can make use of all the columns we want to draw beautiful, creative, and insightful data displays. In this lesson, you'll learn how to do just that.

<!--
Answer to #1: __What a function consumes__ is not the same as the __work the function does__. Both functions consumed Rows, but one function looked up the `age` column - a Number - and the other looked up the `species` column - a String.

Answer to #2: It's similar in that it makes images based on numeric data, from the one argument in its Domain. But instead of that argument _being a Number_, it's a _Row that contains a Number_. So instead of using that input verbatim, the function needs to use a lookup to get that Number out of the Row.

-->
---
{layout="Launch"}
# Processing Rows with Functions

But how do we process each Row separately? You've learned how to take a complex value like a Row, and lookup a column. We could write a line of code that does that for every Row in the table... but that would take a long time and would result in a LOT of code! You've also seen how to define functions that consume simple values, and __do all the repetitive work for us__. Let's put those two concepts together, and define functions that consume Rows!


---
{layout="Investigate"}
# Processing Rows with Functions

- Turn to @printable-exercise{age-dot.adoc}, and complete the top half of the page (questions 1 and 2).
- Compare your answers to some other students'. If you each wrote down different answers, talk about what's different and what's the same.

@teacher{
Review student answers. Every student should have the same code for this part!
}
---
{layout="Investigate"}
# Processing Rows with Functions

- You could imagine doing this for every animal in the shelter, but that would be a lot of very repetitive work. This is exactly what functions are made for!
- Open your saved Animals Starter File (or @starter-file{animals, "start a new one"}), and type the Contract, Examples, and Definition for `age-dot` into the Definitions Area.
- Click "Run", and make sure your examples pass. Then try using your new function on some of the other Rows defined there, like `lizard-row` and `cat-row`.

@teacher{
Review the Contract, Examples and Definition with students, making sure to point out the connections between each representation!
}

---
{layout="Investigate"}
# Processing Rows with Functions

- Turn to @printable-exercise{species-tag.adoc}, and complete the top half of the page (questions 1 and 2).
- When you are confident with the code you have written - check with your teacher or a partner - complete the rest of the page to define a function `species-tag`.
- In your Animals Starter File, type the Contract, Examples, and Definition for `species-tag` into the Definitions Area.
- Click "Run", and make sure your examples pass. Then try using your new function on some of the other Rows defined there, like `lizard-row` and `cat-row`.

<!--

-->
---
{layout="Synthesize"}
# Processing Rows with Functions

* One of the functions we wrote used the `age` column, and the other used the `species` column. One is a Number and the other is a String, so why did both functions consume _Rows?_
* How is this similar to the other functions you've defined, like `gt` and `bc`? How is it different?


@teacher{
* One of the functions we wrote used the `age` column, and the other used the `species` column. One is a Number and the other is a String, so why did both functions consume _Rows?_
** __What a function consumes__ is not the same as the __work the function does__. Both functions consumed Rows, but one function looked up the `age` column - a Number - and the other looked up the `species` column - a String.
* How is this similar to the other functions you've defined, like `gt` and `bc`? How is it different?
** It's similar in that it makes images based on numeric data, from the one argument in its Domain. But instead of that argument _being a Number_, it's a _Row that contains a Number_. So instead of using that input verbatim, the function needs to use a lookup to get that Number out of the Row.
}
---
{layout="LaunchR"}
# Image Scatter Plots

@right{@image{images/pounds-v-weeks.png, 450}}

**Do you think an animal's weight affects how long it stays at the shelter? Why or why not?**

Many apartment buildings have limits on how heavy a pet can be, which could make bigger animals harder to adopt. If we're looking for a relationship between two variables, we know that we need a scatter plot! Let's start out by making a scatter plot to look for a relationship between Pounds and Weeks.

<!--

-->
---
{layout="LaunchR"}
# Image Scatter Plots

@right{@image{images/pounds-v-weeks.png, 450}}

There seems to be a positive relationship, but it's not very strong.

- What other factors might influence how quickly an animal is adopted?

Let's say we want to consider the influence of *age* on how how quickly an animal is adopted - while simultaneously considering the relationship between pounds and weeks to adoption. Fortunately, there's a way to do this... __image-scatter-plots!__

<!--
- What other factors might influence how quickly an animal is adopted?
** _Invite students to share their ideas and explain their rationale. Possible responses: Maybe fixed animals are adopted more quickly. Maybe some species are adopted more quickly. Maybe age plays a role..._

Let's say we want to consider the influence of *age* on how how quickly an animal is adopted - while simultaneously considering the relationship between pounds and weeks to adoption. Fortunately, there's a way to do this... __custom scatter plots!__
-->
---
{layout="Investigate"}
# Image Scatter Plots

- Open the @starter-file{custom-scatter-plot}.
- With a partner or in small groups, complete Numbers 1-7 on @printable-exercise{image-scatter-explore.adoc}.
- Based on the work that you just completed, what is the Contract for `image-scatter-plot`?

@teacher{_Discuss as a class, or in small groups. See explanation, below, of the `image-scatter-plot` Contract._}

---
{layout="Investigate"}
# Image Scatter Plots

The Contract for `image-scatter-plot` looks pretty different from other contracts we've seen.

```
image-scatter-plot :: (
  t  :: Table,
  xs :: String,
  ys :: String,
  f  :: (Row -> Image)
) -> Image
```

This Domain is interesting: Table, String, String and...*a Function that consumes a Row and produces an Image!*

---
{layout="InvestigateR"}
# Image Scatter Plots

@center{@image{images/age-dot.png, 450}}


- What do you think the resulting custom scatter plot will look like? You may want to refer back to @printable-exercise{age-dot.adoc}.
- Now complete questions 8, 9, and 10 on @printable-exercise{image-scatter-explore.adoc} to see the scatter plot that will be generated and then experiment with modifying its code.

@teacher{
- What do you think the resulting custom scatter plot will look like? You may want to refer back to @printable-exercise{age-dot.adoc}.
** _Students should make predictions based on their work on @printable-exercise{age-dot.adoc}._
- Now complete questions 8, 9, and 10 on @printable-exercise{image-scatter-explore.adoc} to see the scatter plot that will be generated and then experiment with modifying its code.
** _The scatter plot that will be generated is on the right._
}
---
{layout="InvestigateR"}
# Image Scatter Plots

@center{@image{images/species-tag.png, 450}}

- Do the bottom portion of the worksheet, which invites you to consider what new insights you can glean from your custom displays.
- How did having the dots labeled with the _species_ change your understanding of the data?

@teacher{
** __The `species-tag` @vocab{scatter plot} (right) makes it clear that we may want to analyze each species separately, rather than grouping them all together. (In the Grouped Samples lesson, students will learn how to do just that!)__
}
---
{layout="SynthesizeR"}
# Image Scatter Plots

@center{@image{images/species-tag.png, 450}}

* What other ways could we use the columns in each row of the Animals Table to pack more information into our scatter plots?
* How are the charts produced by `image-scatter-plot` different from those produced by `scatter-plot`? Why do these differences exist? (Think about their Contracts!)
* How might image-scatter-plot be useful to your own analysis?

@teacher{
* What other ways could we use the columns in each row of the Animals Table to pack more information into our scatter plots?
** Use legs and age to determine width and height of a rectangle
** Use different colors or shapes based on species, sex, or fixed-status
* How are the charts produced by `image-scatter-plot` different from those produced by `scatter-plot`? Why do these differences exist? (Think about their Contracts!)
** `image-scatter-plot` consumes a function that can draw different dots depending on each Row in the dataset, along with information about which columns contain the x- and y-coordinates. In contrast, `scatter-plot` because it only consumes information about _where_ the dots are drawn, and not _how_ they are drawn.
* How might image-scatter-plot be useful to your own analysis?
}

---
{layout="Launch"}
# Piecewise/Conditional Functions

* the `scatter-plot` function makes uniform blue dots
* the `image-scatter-plot` function can label each point with a custom image, computed by a helper function that consumes a Row and produces an Image

How could we use _different color dots_ for each species? Or perhaps draw different shapes depending on whether an animal was fixed or not?

This requires a more powerful kind of function, known in math as a @vocab{piecewise function} because it has more than one "piece". In programming, these are often called "conditional" functions, because each piece is used depending on which condition is met.

---
{layout="InvestigateR"}
# Piecewise/Conditional Functions

@center{@image{images/pounds-v-weeks.png, 450}}

* __Starting on paper__, complete @printable-exercise{pages/piecewise-explore.adoc}.
* When you're finishing thinking and writing, open the @starter-file{piecewise-displays} and experiment!
* Can you come up with another piecewise function?
* Make sure to finish the remainder of the page!

<!--

-->
---
{layout="Investigate"}
# Image Scatter Plots

```
image-scatter-plot :: (
  t  :: Table,
  xs :: String,
  ys :: String,
  f  :: (Row -> Image)
) -> Image
```

The function `image-scatter-plot` has an interesting Domain: Table, String, String and... what is that last part?... *a Function that consumes a Row and produces an Image*!

<!--

-->
---
{layout="Investigate"}
# Image Scatter Plots

- What do you think the resulting custom scatter plot will look like? You may want to refer back to @printable-exercise{age-dot.adoc}.
- Now complete questions 8, 9, and 10 on @printable-exercise{image-scatter-explore.adoc} to see the scatter plot that will be generated and then experiment with modifying its code.

---
{layout="InvestigateR"}
# Image Scatter Plots

@center{@image{images/age-dot.png, 450}}

- Do the bottom portion of the worksheet, which invites you to consider what new insights you can glean from your custom displays.
- How did having the dots labeled with the *species* change your understanding of the data?

<!--
__The `species-tag` @vocab{scatter plot} (below) makes it clear that we may want to analyze each species separately, rather than grouping them all together. (In the Grouped Samples lesson, students will learn how to do just that!)__

-->
---
{layout="Synthesize"}
# Image Scatter Plots

* What other ways could we use the columns in each row of the Animals Table to pack more information into our scatter plots?
* How are the charts produced by `image-scatter-plot` different from those produced by `scatter-plot`? Why do these differences exist? (Think about their Contracts!)
* How might image-scatter-plot be useful to your own analysis?

<!--

-->
---
{layout="Launch"}
# Piecewise/Conditional Functions

So far, we've seen that...

* the `scatter-plot` function makes uniform blue dots
* the `image-scatter-plot` function can label each point with a custom image, computed by a helper function that consumes a Row and produces an Image

How could we use *different colored dots* for each species? Or perhaps draw different shapes depending on whether an animal was fixed or not?

<!--
*NOTE:* Math teachers may want their students to confront piecewise functions more deeply, and CS teachers may want to spend more time on conditionals. While not a part of the Data Science pathway, the @lesson-link{piecewise-functions-conditionals/} lesson includes a lot of supporting material and practice pages for these topics, with greater emphasis on the math connections.
-->

---
{layout="Launch"}
# Piecewise/Conditional Functions

This requires a more powerful kind of function, known in math as a @vocab{piecewise function} because it has more than one "piece". In programming, these are often called "conditional" functions, because each piece is used depending on which condition is met.

---
{layout="Investigate"}
# Piecewise/Conditional Functions

Pyret allows us to create advanced displays for several types of charts. You can find them in the back of your workbook, but here is the complete list:

@show{(contracts
  '("image-scatter-plot" ("Table" "String" "String" "(Row -> Image)") "Image")
  '("image-histogram" ("Table" "String" "Number" "(Row -> Image)") "Image")
  '("image-bar-chart" ("Table" "String" "(Row -> Image)") "Image")
  '("image-pie-chart" ("Table" "String" "(Row -> Image)") "Image")
)}

---
{layout="Synthesize"}
# Piecewise/Conditional Functions

- How do piecewise functions expand what is possible for displaying data?
- How could you see this power being used to help express complex relationships?

---
{layout="Supplemental"}

- @opt-project{beautiful-data-project.adoc, beautiful-data-rubric.adoc} 
