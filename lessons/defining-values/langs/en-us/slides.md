---
{layout="Math Title Slide"}
# Defining Values

---
{layout="Launch"}
# What's in Common? 

Take a look at the expressions below:

@ifproglang{wescheme}{

```
(star 50 "solid" "green")
(scale 3 (star 50 "solid" "green"))
(scale .5 (star 50 "solid" "green"))
(rotate 45 (star 50 "solid" "green"))
(rotate 45 (scale 3 (star 50 "solid" "green")))
```
- What code do they all have in common?
}

@ifproglang{pyret}{
```
star(50, "solid", "green")
scale(3, star(50, "solid", "green"))
scale(0.5, star(50, "solid", "green"))
rotate(45, star(50, "solid", "green"))
rotate(45, scale(3, star(50, "solid", "green")))
```
- What code do they all have in common?
}

- What would happen if you were asked to change the color of all the stars to gold?

---
{layout="Launch"}
# What's in Common? 

Duplicate code is almost always bad! 

- __Readability:__ The more code there is, the harder it can be to read.
- __Performance:__ Why re-evaluate the same code a dozen times, when we can evaluate it _once_ and use the result as many times as we need?
- __Maintainability:__ Suppose we need to change the size of the stars in the examples above. We would have to make sure every line is changed, which leaves a lot of room for error.

---
{layout="Launch"}
# What's in Common? 

In math, if we define a value, like @math{x = 4}, 

we can evaluate expressions using that value, like @math{x + 2}.

@ifproglang{wescheme}{
WeScheme uses the word "define" to make this even clearer! We can type `(define x (4))` to define `x` to be the value 4.
}

@ifproglang{pyret}{
Pyret is no different!
} 

---
{layout="Investigate"}
# What's in Common? 

Complete @starter-file{defining-values} and complete the Notice and Wonder exercise on @printable-exercise{pages/defining-values-explore.adoc} with your partner.

Complete the remaining questions and add some definitions of your own in the definitions area. Be sure to click *Run* again before you try testing them out.

---
{layout="Synthesize"}
# What's in Common? 

- What data types can we define values for?

- What values did you decide to define? When might they be useful?

---
{layout="Launch"}
# Using Defined Values

Open to @printable-exercise{chinese-flag.adoc}

<!--
It will direct them to open the @starter-file{flags-china} once they complete the first half of the questions on the page.
-->

---
{layout="Investigate-DN"}
# Using Defined Values

Define `sun` to be the image: 

@show{(code '(radial-star 30 20 50 "solid" "yellow"))} 

Then turn to @printable-exercise{pages/coe-why-define-values.adoc}

The first row of the table has been completed for you. Work with your partner to explain what is happening in that first row before completing the rest of the page. 

---
{layout="Synthesize"}
# Using Defined Values

Why is defining values useful?{style="font-size:24pt"}

---
{layout="Supplemental"}
# Additional Exercises:

* @printable-exercise{pages/writing-code-using-defined-values.adoc}
@ifproglang{wescheme}{
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5ff46882e3b4660c751f707e?collections=5fbecc2b40d7aa0d844956f0, Matching Code to Images using overlay & put-image}
}
@ifproglang{pyret}{
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90f1289c78e0d2a5bccfc, Matching Code to Images using overlay & put-image}
}