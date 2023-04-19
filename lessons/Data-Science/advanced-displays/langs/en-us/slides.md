---
{layout="DS Title Slide"}
# Custom Scatter Plots

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Image Scatter Plots

@image{images/age-v-weeks.gif, 450}

Not all data points are created equal! Dogs and rabbits are very different, but when viewing all the animals on the same scatter plot, these differences are hidden.{style="font-size:16pt"}

Now that we know how to define functions that draw shapes, we can start thinking about how to **customize the dots on our scatter plots**. {style="font-size:16pt"}

This makes the displays more interesting, and helps us to dig deeper into analyzing the data.{style="font-size:16pt"}

<!--

-->
---
{layout="Investigate"}
# Image Scatter Plots

Turn to @printable-exercise{defining-row-functions.adoc}, and **complete numbers 1-3 at the top of the page.**

Be ready to discuss your answers with the class!

<!--
Review students' answers to these first three questions. It's important to check for understanding before proceeding!

-->
---
{layout="Investigate"}
# Image Scatter Plots

Return to @printable-exercise{defining-row-functions.adoc}, and complete the rest of the page to define a function `species-tag`.

<!--
Review student answers before having them open the @starter-file{custom-scatter-plot} and read through the code.
-->
---
{layout="Investigate"}
# Image Scatter Plots

* Open @starter-file{custom-scatter-plot}
* How (if at all) does your definition of `species-tag` differ from what's here?
* What do you Notice? What do you Wonder?
* What functions you see defined here? What do they do?
* What Rows do you see defined here?

<!--
Discuss these as a class
-->
---
{layout="Investigate"}
# Image Scatter Plots

The contract for `image-scatter-plot` looks pretty different from other contracts we've seen:

```{style="font-weight:bold"}
image-scatter-plot :: (
  t  :: Table,
  xs :: String,
  ys :: String,
  f  :: (Row -> Image)
) -> Image
```

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
What is the **Domain** of `image-scatter-plot`?


<!--
_Table, String, String and... what is that last part?... **a Function that consumes a Row and produces an Image!**_
-->
---
{layout="Investigate"}
# Image Scatter Plots

- Comment-out the `scatter-plot` expression in the program by putting a `#` at the start of line 53. This will "turn off" the expression, by telling Pyret to ignore that line.
- Complete @printable-exercise{pages/image-scatter-explore.adoc}.

<!--

-->
---
{layout="SynthesizeC"}
# Image Scatter Plots

@image{images/species-tag.png, 450}

How did having the dots labeled with the species change your understanding of the data?

<!--
Make sure to direct the conversation back to *Data Science!*
_This scatter plot makes it clear that we may want to analyze each species separately, rather than grouping them all together!_ In the Grouped Samples lesson, students will learn how to do just that.
-->
---
{layout="SynthesizeC"}
# Image Scatter Plots

What did the other functions in the file do?

@image{images/legs-tag.png, 422} 
@image{images/age-tag.png, 410}

<!--
The `legs-tag` function _made blue rings whose size was determined by the number of legs the animal had. `age-tag` made stars whose size was double the age of the animal._
-->
---
{layout="SynthesizeC"}
# Image Scatter Plots

@image{images/species-tag.png, 450}

* What data type is `species-tag`? What does it do?
* How does `image-scatter-plot` work?
<!--
* What data type is `species-tag`?
** _A function that consumes a Row and produces an Image_
-->
---
{layout="Synthesize"}
# Image Scatter Plots

* How might `image-scatter-plot` be useful in your _own_ analysis?

---
{layout="Launch"}
# Optional: Using Conditionals
So far, we've seen that...

* the `scatter-plot` function makes uniform blue dots
* the `image-scatter-plot` function can label each point with some text, a different sized dot, or a star.

What other ideas do you have for how else we could make scatter plots be more interesting than the ones with plain blue dots?


<!--
**This entire section is Optional. Students delve deeper into programming to create more sophisticated image-scatter-plots, which can then feed deeper analysis**

Math teachers alike may want their students to confront piecewise functions more deeply, and CS teachers may want to spend more time on conditionals. While not a part of the Data Science pathway, the @lesson-link{piecewise-functions-conditionals/} lesson includes a lot of supporting material and practice pages for these topics.
-->
---
{layout="LaunchR"}
# Using Conditionals

@image{images/age-v-weeks-species-dot.png, 450}

* Optional: open the @opt-starter-file{piecewise-displays} and complete @opt-printable-exercise{pages/species-dot-explore.adoc}.
* What does this new visualization tell us about the relationship between age and weeks?
* What other analysis would be helpful here?

<!--

-->

---
{layout="Investigate"}
# Using Conditionals

* Optional: open @opt-printable-exercise{species-dot-dr.adoc}
* What is the contract for `species-dot`?
* What is the purpose of `species-dot`?
* How many examples do we need to write?
* Optional: Complete @opt-printable-exercise{sex-dot-dr.adoc}, to write a new helper function that will make differently-colored dots based on the animals' sex.

<!--
Make sure that students write the Contract __first__ , and check in with their partner __and__ the teacher before proceeding.

Once they've got the Contract, have them come up with `examples:` for _each sex_. Once again, have them check with a partner _and_ the teacher before finishing the page.
-->

---
{layout="Investigate"}
# Using Conditionals

Once another student _and_ the teacher have checked your work, type the `sex-dot` function into your starter file, and use it to make an `image-scatter-plot` using `age` as the x-axis and `weeks` as the y-axis.


<!--
Debrief, and ask students to explain what the code does. Pay special attention to students' ability to articulate the "if/then" statements!
-->

---
{layout="Investigate"}
# Using Conditionals

- Optional: to @opt-printable-exercise{pages/species-image-explore.adoc} and open the @opt-starter-file{piecewise-animal-images} Starter File.
- How does using clipart help us to better understand the data?
- What _risks_ might there be to using clipart in displays?
- We have seen a lot of different image scatter plots today! What ideas do you have for how `image-scatter-plot` could be used to deepen the analysis of your dataset?

<!--
For students who are really ready for a challenge, direct them to the @opt-starter-file{custom-scatter-plot-w-range} and @opt-printable-exercise{value-range-dot-explore.adoc}
-->

---
{layout="Synthesize"}
# Using Conditionals

How do piecewise functions expand what is possible with the `image-scatter-plot` function?

<!--
-->
