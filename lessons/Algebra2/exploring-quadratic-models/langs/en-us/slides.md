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

- Open the @online-exercise{https://code.pyret.org/editor#share=1RESEiKCepBRV3_AbthDydHaq5b9BN2zy, Fuel Efficiency Starter File}
- From the File menu, select "Save a Copy", and click "Run".
- Working in pairs or small groups, complete questions 1-9 of @printable-exercise{pages/exploring-mpg.adoc}.

<!--
Review student answers to confirm that students see a _non-linear_ relationship in the dataset with a relatively strong correlation.
-->
---
{layout="InvestigateR"}
# Looking for Patterns

@image{images/fuel-efficiency-quadratic.png}

Even though some cars are more efficient than others, fuel efficiency generally increases from 15 to roughly 55mph. But after 55mph, fuel efficiency _decreases._

- Let's try to build a linear model for this data!{style="font-size: 15pt"}
- Working in pairs or small groups, complete the rest of of @printable-exercise{pages/exploring-mpg.adoc}.{style="font-size: 15pt"}

<!--

-->

---
{layout="Investigate"}
# Looking for Patterns

By now you've tried to fit quite a few linear models to this data, and we're not getting anywhere!

@table{3}
| We can build linear models that fit the "increasing" half of the data... | We can build linear models that fit the "decreasing" half of the data... | We can build linear models that try to split the difference...
| @image{images/fuel-efficiency-linear1.png} | @image{images/fuel-efficiency-linear2.png} | @image{images/fuel-efficiency-linear3.png}

...but all of them are so far away from so many points, and our @math{R^2} is pretty bad.

<!--

-->
---
{layout="Synthesize"}
# Looking for Patterns

- Why aren't linear models working for us?
- What else could we try?

<!--

-->
---
{layout="Launch"}
# Fitting Quadratic Models

Linear models are great for fitting simple relationships. But the real world isn't so simple, and more often than not linear models are just too primitive to handle that complexity.


<!--

-->
---
{layout="LaunchC"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

Relationships that rise and fall like this are called _quadratic relationships_. They form shapes that look like arches, called parabolas. Sometimes the data only includes the _rising_ part of the parabola, sometimes it only includes the _falling_ part, and and sometimes it includes both!{style="font-size: 16pt"}

<!--
We often think about variables of a model being _independent_ from one another, each contributing a little to the outcome we are measuring. But sometimes one input will amplify the result of another input, meaning their combined contribution is greater than the sum of their separate contributions.

A quadratic relationship often means that one or more variables is _interacting_ with another variable. In our miles-per-gallon example, it turns out that a linear increase in speed has a _more than linear effect_ on mpg!
-->

---
{layout="Launch"}
# Fitting Quadratic Models

Quadratic relationships show up all the time!

- When an athlete is young, they improve as they get stronger and more skilled. But as they age, they begin to lose their speed and strength.
- A ball dropped from a tall building will get faster and faster as it falls.
- Many nutrients are good for you, and the more you take the healthier you are...up to a point. After that, too much of a mineral or vitamin can cause problems.

Can you think of other real-world examples where a relationship is likely quadratic?

<!--

-->
---
{layout="Launch"}
# Fitting Quadratic Models

You should already be familiar with the different forms of linear models (Standard, Point-Slope, and Slope-Intercept). Depending on what part of the model we care about most, we might choose to use one display over another.

The same is true for quadratic models:

@table{3}
| Standard Form 		| Vertex Form			| Factored Form
| @math{y=ax^2+bx+c}	| @math{y=a(x−h)^2+k}	| @math{y=a(x−r_1)(x−r_2)}

<!--

-->
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


<!--

-->
---
{layout="LaunchR"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

In this case, we've already come to some conclusions about the @vocab{vertex} of our parabola, where cars are most fuel-efficient: *45mph*. That makes Vertex Form a useful place to start, since we already know the value of @math{H}:

@center{@math{y=a(x-45)^2+k}}

<!--
Now we need to figure out the values of @math{a} and @math{k}!
-->

---
{layout="Investigate"}
# Fitting Quadratic Models

@center{@math{y=a(x-45)^2+k}}

But what do each of the coefficients in Vertex Form mean?

- Open @starter-file{alg2-exploring-quadratics} in Desmos.
- Use Desmos to complete @printable-exercise{graphing-models.adoc}.

<!--

-->
---
{layout="Investigate"}
# Fitting Quadratic Models

Now that we have a sense for what these coefficients mean, let's try to model the speed-v-mpg relationship using a quadratic model!

Complete @printable-exercise{model-speed-v-mpg.adoc}

<!--

-->
---
{layout="SynthesizeR"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

You've had a chance to experiment with quadratic models in vertex form:

@center{@math{y=a(x−h)^2+k}}

* How do you translate a parabola left and right?
* How do you translate a parabola up and down?
* How do you make a parabola "narrower" or "wider"?

<!--
* How do you translate a parabola left and right?
** Change the value of @math{h}
* How do you translate a parabola up and down?
** Change the value of @math{k}
* How do you make a parabola "narrower" or "wider"?
** Change the value of @math{a}
-->
---
{layout="SynthesizeR"}
# Fitting Quadratic Models

@image{images/fuel-efficiency-quadratic.png}

* What was the highest @math{R^2} you were able to get? What model was it?
* Could a quadratic model be used to fit a *linear* relationship?

<!--

-->
---