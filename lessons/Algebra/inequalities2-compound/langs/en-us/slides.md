---
{layout="Math Title Slide"}
# Compound Inequalities: Solutions & Non-Solutions {style="font-size:27pt"} 

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Introducing Compound Inequalities

We use inequalities for lots of things:

- Is it hot out? (@math{temperature \gt 80°})
- Did I get paid enough for painting that fence? (@math{paid \ge $100})
- Are the cookies finished baking? (@math{timer = 0})

What other examples can you come up with?

---
{layout="Launch"}
# Introducing Compound Inequalities

Many times we need to _combine_ inequalities:

- Should I go to the beach? (@math{temperature \gt 80°} and @math{weather = "sunny"}){style="font-size:16pt"}
- Was this burrito worth the price? (@math{taste = "delicious"} and @math{price \leq $15}){style="font-size:16pt"}

What other examples can you come up with?

<!--
Guide students through other examples of `and` and `or` with various statements, such as "I'm wearing a red shirt AND I'm a math teacher, true or false?" or "I'm an NBA basketball star OR I'm having pizza for lunch, true or false?". This can make for a good sit-down, stand-up activity, where students take turns saying compound Boolean statements and everyone stands if that statement is true for them.
-->

---
{layout="Investigate-DN"}
# Introducing Compound Inequalities

Both mathematics and programming have ways of combining - or _composing_ - inequalities.

Complete:

- @printable-exercise{pages/boolean-coe-to-code1.adoc}
- @printable-exercise{pages/and-or.adoc}

---
{layout="Synthesize"}
# Introducing Compound Inequalities

Expressions using `and` only produce `true` if both of their sub-expressions are `true`.
Expressions using `or` produce `true` if *either* of their sub-expressions are `true`.

True or False?
- I'm wearing a red shirt and I'm a math teacher.
- I'm an NBA basketball star or I'm having pizza for lunch.

Write your own compound Boolean statements.

<!--
When describing compound inequalities, be careful not to use "english shortcuts". For example, we might say "I am holding a marker _and_ an eraser" instead of "I am holding a marker _and_ I am holding an eraser." These sentences mean the same thing, but the first one obscures the fact that "and" joins two complete phrases. For ELL/ESL students, this is unecessarily adds to cognitive load!
-->

---
{layout="Launch"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

Complete @printable-exercise{compound-warmup.adoc}.

---
{layout="Investigate-DN"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

* Open the @starter-file{inequalities-compound}.
* Click "Run" to see graphs of the inequalities you've just considered. 
* Four graphs will appear: The top two are the simple inequalities we've just discussed. 
* Complete @printable-exercise{compound-explore.adoc}.


---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

`and-intersection` takes in two functions and a list of numbers and produces a graph with the points and the shaded @vocab{intersection} of values that make both of the inequalities true.

---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

@image{images/intersection1.png}

In this example,

* the circle on 5 is red because 5 is not part of the solution - it _is not_ bigger than itself.
* the circle on 15 is green because 15 is part of the solution - it _is_ less than or equal to 15.


---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

`or-union` takes in two functions and a list of numbers and produces a graph with the points and the shaded @vocab{union} of values that make either or both of the inequalities true.

**In order to make an `or` statement true, a number only has to make one of the inequalities true**

---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

@image{images/union-infinite1.png}

In this example, `or-union` resulted in the whole number line being shaded blue because every number in the universe is either greater than 5 or less than or equal to 15 - there aren't any non-solutions!

@teacher{Once students are familiar with the starter file, they are ready to use it as they practice identifying solutions and non-solutions for compound inequalities.}

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

Not all graphs of `or-union` will look like this! Consider @math{x \lt 1} `or` @math{x \lt 3}, for example.

- Turn to @printable-exercise{compound-inequality-solutions.adoc}.
- Explore the compound inequalities listed using the @starter-file{inequalities-compound}, identifying solutions and non-solutions for each.

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

Instead of defining two functions as simple inequalities, we can produce an inequality graph by defining one function to be a @vocab{compound inequality}!

In the following activity, we'll analyze inequality graphs and define a _single_ function that produces the graph.

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

- Turn to @printable-exercise{compound-inequality-functions.adoc}.
- Write code to describe the compound inequalities pictured.

@ifproglang{pyret}{@optional Try @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fdf8618945cb549d457fb85, Matching Compound Inequality Functions and plots}
}

---
{layout="Synthesize"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

How did the graphs of intersections and unions differ?

---
{layout="Supplemental"}
# Additional Exercises

@opt-printable-exercise{pages/boolean-coe-to-code2.adoc}

