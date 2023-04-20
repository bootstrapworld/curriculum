---
{layout="Math Title Slide"}
# Compound Inequalities: Solutions & Non-Solutions{style="font-size:36pt"}

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

- Should I go to the beach? (@math{temperature \gt 80°} and @math{weather = "sunny"})
- Was this burrito worth the price? (@math{taste = "delicious"} and @math{price \leq $15})

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

- What are 4 solutions for @math{x \gt 5} ?
- What are 4 non-solutions for @math{x \gt 5}?
- What are 4 solutions for @math{x \le 15}?
- What are 4 non-solutions for @math{x \le 15}?
- What numbers are in the solutions set of  @math{x \gt 5} `and` @math{x \le 15}, making _both_ of these inequalities true?
- How would that be different from the solution set of @math{x \gt 5} `or` @math{x \le 15}, making _at least one_ of these inequalities true?

<!--
The questions above could be printed from @opt-printable-exercise{compound-warmup.adoc}.
-->

---
{layout="Investigate-DN"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

* Open the @starter-file{inequalities-compound}.
* Click "Run" to see the graphs you've just considered. Four graphs will appear: The top two are the simple inequalities we've just discussed. 
* Were your solutions and non-solutions correct?


---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

The bottom two graphs are produced by the special functions `and-intersection` and `or-union`. 

- What does `and-intersection` do?
- Why is the circle on 5 red and the circle on 15 green?
- Do you think every graph made with `and-intersection` will have different color dots at the ends? Why or why not?

@image{images/intersection1.png}


---
{layout="InvestigateC"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

- What does `or-union` do?
- Why did the graph of this `or-union` result in the whole number line being shaded blue?
- Not all graphs of `or-union` will look like this. Can you think of a pair of inequalities whose union won't shade the whole graph?

@image{images/union-infinite1.png}

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

Change the function definition on _line 8_ to @math{x \lt 5} and the definition on _line 9_ to @math{x \ge 15} and, before you click "Run", take a moment to think about what the new graphs of `and-intersection` and `or-union` will look like. 

Then click "Run" and take a look.

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

- What does the new `and-intersection` graph look like?
- What does the new `or-union` graph look like?
- Why is the dot for 5 red and the dot for 15 green?
- Which of the 8 numbers from the list are part of the solution set? How do you know?
- Is 3 part of the solution set? How do you know?
- Is 10 part of the solution set? How do you know?

---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

Once you are familiar with the starter file, you are ready to use it as you practice identifying solutions and non-solutions for compound inequalities.

- Turn to @printable-exercise{compound-inequality-solutions.adoc}.
- Explore the compound inequalities listed using the @starter-file{inequalities-compound}, identifying solutions and non-solutions for each.


---
{layout="Investigate"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

In the following activity, you will analyze inequality graphs and define a _single_ function that produces the graph. Let's look at the first example together.

- Turn to @printable-exercise{compound-inequality-functions.adoc}.
- Write code to describe the compound inequalities pictured.

---
{layout="Synthesize"}
# Solutions and Non-Solutions of Compound Inequalities {style="font-size:22pt"}

How did the graphs of intersections and unions differ?

---
{layout="Supplemental"}
# Additional Exercises

@opt-printable-exercise{pages/boolean-coe-to-code2.adoc}

