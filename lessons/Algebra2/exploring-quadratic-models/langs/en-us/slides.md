---
{layout="DS Title Slide"}
# Exploring Quadratic Models

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Looking for Patterns

When you're driving, what speed will save you the most money on gas?

- Open the @starter-file{alg2-fuel-efficiency}
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete the first section of @printable-exercise{pages/exploring-mpg.adoc}.

@teacher{Review student answers to confirm that students see a _non-linear_ relationship in the dataset with a relatively strong correlation. Students should generally agree that the relationship is a curve (parabola), which opens downwards and has a vertex at _roughly_ 45mpg.  **Make sure students have agreed on this vertex**, as its location is important for the next activity!}

---
{layout="InvestigateR"}
# Looking for Patterns

@image{images/fuel-efficiency-quadratic.png}

There's definitely a relationship here. Even though some cars are more efficient than others, fuel efficiency generally increases from 15 to around 40-60mph. But after about 60mph, fuel efficiency _decreases._

We also know that the best-possible linear model isn't very good!

---
{layout="Investigate"}
# Looking for Patterns

@table{3}
| We can build linear models that fit the "increasing" half of the data... | We can build linear models that fit the "decreasing" half of the data... | We can build linear models that try to split the difference...
| @image{images/fuel-efficiency-linear1.png} | @image{images/fuel-efficiency-linear2.png} | @image{images/fuel-efficiency-linear3.png}

...but all of them are so far away from so many points, and our @math{R^2} is pretty bad.

---
{layout="Investigate"}
# Looking for Patterns

Complete the rest of @printable-exercise{pages/exploring-mpg.adoc}. Be ready to share back and describe the curve you drew.

@teacher{
Have students share their curves, encouraging them to identify where they "peak" and where they cross the bottom of the scatter plot (one option is to project the scatter plot on a whiteboard and have students come up and draw all of their curves on it). These locations will be important anchor concepts on which to build in the next section.
}

---
{layout="Synthesize"}
# Looking for Patterns

- Why don't linear models work for us?
- What kinds of curves did you draw to fit better?
- Are there any mathematical functions that look like those curves?

---
{layout="Launch"}
# Fitting Quadratic Models

Linear models are great for fitting simple relationships. But the real world isn't so simple, and more often than not linear models are just too primitive to handle that complexity.

---
{layout="LaunchC"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

Relationships that rise and fall like this are called _quadratic relationships_. They form shapes that look like arches, called parabolas. Sometimes the data only includes the _rising_ part of the parabola, sometimes it only includes the _falling_ part, and and sometimes it includes both.{style="font-size: 16pt"}

---
{layout="Launch"}
# Fitting Quadratic Models

*Linear relationships* grow by a fixed intervals. *Quadratic relationships* grow by intervals that get bigger by fixed amounts!

OPTIONAL
- Complete @opt-printable-exercise{classifying-tables.adoc} to explore the growth of quadratic functions.
- Complete @opt-printable-exercise{classifying-plots.adoc} to explore the shape of quadratic graphs.

---
{layout="Launch"}
# Fitting Quadratic Models

**Quadratic relationships show up all the time!**

- When an athlete is young, they improve as they get stronger and more skilled. But as they age, they begin to lose their speed and strength.
- A ball dropped from a tall building will get faster and faster as it falls.
- Many nutrients are good for you, and the more you take the healthier you are...up to a point. After that, too much of a mineral or vitamin can cause problems.

---
{layout="Launch"}
# Fitting Quadratic Models

In the case of our fuel efficiency dataset, there's a definite "rise and fall" pattern! But there almost appears to be a "dip" around 40mph. Does that mean we should stick to linear models? Why or why not?

@teacher{Have students discuss and share back with the class. If necessary, remind students that _models are - by defintion - approximations of the real world._ The fact that a parabola isn't a perfect fit doesn't mean that it's not a quadratic relationship!}

---
{layout="LaunchC"}
# Fitting Quadratic Models

The existence of a "dip" like this is normal in real data, but it doesn't mean that the overall shape of this relationship isn't quadratic. There's no such thing as a perfect model! If we try to draw a parabola through this dataset, we wind up with something like the image below:

@center{@image{images/fuel-efficiency-fit.png, 600}}

---
{layout="Launch"}
# Fitting Quadratic Models

You already know that linear relationships can be described with terms like "slope" and "y-intercept". Parabolas have their own terms, as well.

- Do all parabolas have y-intercepts?
- Do parabolas have _slope?_
- If "slope" and "y-intercept" are critical parts of a linear relationship, what do you think the important parts of a quadratic relationship might be?

---
{layout="LaunchR"}
# Fitting Quadratic Models

- @vocab{vertex} - In a quadratic relationship, the vertex is the point at which a parabola "changes direction", and goes from climbing to sinking (or vice versa).
- @vocab{maxima} - The highest point in a parabola that "opens down"
- @vocab{minima} - The lowest point in a parabola that "opens up"

@image{images/opens.png, 175}

---
{layout="LaunchR"}
# Fitting Quadratic Models

@vocab{y-intercept} - Like linear models, parabolas always cross the y-axis once when x=0.

@image{images/y-intercept.png, 175}

---
{layout="LaunchR"}
# Fitting Quadratic Models

@vocab{x-intercepts} / @vocab{roots} - All linear functions cross the x-axis once, when y=0. These are sometimes called "roots", or "zeros" of the function. A quadratic function can cross the x-axis once, twice, or even __no times at all!__

@image{images/roots.png, 200}

---
{layout="Investigate"}
# Fitting Quadratic Models

You should already be familiar with the different forms of linear models:

@table{3}
| Slope-intercept		| Point-slope				| Standard
| @math{y = mx+b}		| @math{y-y_1 = m(x-x_1)}	| @math{Ax+By = C}

Depending on what part of the model we care about most, we might choose to use one display over another.

---
{layout="Investigate"}
# Fitting Quadratic Models

The same is true for quadratic models:

@table{3}
| Standard Form 		| Vertex Form			| Factored Form
| @math{y=ax^2+bx+c}	| @math{y=a(x−h)^2+k}	| @math{y=a(x−r_1)(x−r_2)}

Depending on what part of the model we care about most, we might choose to use one display over another.

---
{layout="Launch"}
# Fitting Quadratic Models

@table{3}
| Standard Form 		| Vertex Form			| Factored Form
| @math{y=ax^2+bx+c}	| @math{y=a(x−h)^2+k}	| @math{y=a(x−r_1)(x−r_2)}

- Standard Form makes it easy to find the y-intercept of the parabola @math{c}
- Vertex Form makes it easy to find the vertex (minima or maxima) of the parabola
- Factored Form makes it easy to find the roots of the parabola

Given what we've already found out about this dataset, which form should we start with?

---
{layout="LaunchR"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

In this case, we've already come to some conclusions about the @vocab{vertex} of our parabola, where cars are most fuel-efficient: *45mph*. That makes Vertex Form a useful place to start, since we already know the value of @math{H}:

@center{@math{y=a(x-45)^2+k}}

@teacher{Now we need to figure out the values of @math{a} and @math{k}.}


---
{layout="Investigate"}
# Fitting Quadratic Models

@center{@math{y=a(x-45)^2+k}}

But what do each of the coefficients in Vertex Form mean?

- Open @starter-file{alg2-exploring-quadratics} in Desmos.
- Use Desmos to complete @printable-exercise{graphing-models.adoc}.

---
{layout="Investigate"}
# Fitting Quadratic Models

You've had a chance to experiment with quadratic models in vertex form:

@center{@math{y=a(x−h)^2+k}}

* How do you translate a parabola left and right?
* How do you translate a parabola up and down?
* How do you make a parabola "narrower" or "wider"?
* If you were fitting a quadratic model in vertex form to a scatter plot, which coefficient would you try to get right _first?_ Which one would you worry about _last?_

@teacher{
* How do you translate a parabola left and right?
** Change the value of @math{h}
* How do you translate a parabola up and down?
** Change the value of @math{k}
* How do you make a parabola "narrower" or "wider"?
** Change the value of @math{a}	
}

---
{layout="Investigate"}
# Fitting Quadratic Models

Now that we have a sense for what these coefficients mean, let's try to model the speed-v-mpg relationship using a quadratic model!

Complete @printable-exercise{model-speed-v-mpg.adoc}

---
{layout="SynthesizeR"}
# Fitting Quadratic Models

* What was the highest @math{R^2} you were able to get? What model was it?
* Could a quadratic model be used to fit a linear relationship?
* Do you notice anything interesting about the values of @math{h} and @math{k}?

@teacher{
* What was the highest @math{R^2} you were able to get? What model was it?
** Responses will vary
* Could a quadratic model be used to fit a linear relationship?
** YES! If the coefficient of the quadratic term is zero, it's equivalent to a linear model.
* Do you notice anything interesting about the values of @math{h} and @math{k}?
** They are the coordinates of the vertex!	
}
---
== Additional Exercises

- @opt-printable-exercise{classifying-tables.adoc}
- @opt-printable-exercise{classifying-plots.adoc}
---