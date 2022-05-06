---

# Compound Inequalities: Solutions & Non-Solutions

---
# Introducing Compound Inequalities

We use inequalities for lots of things:

- Is it hot out? (@math{temperature \gt 80°})
- Did I get paid enough for painting that fence? (@math{paid \ge $100})
- Are the cookies finished baking? (@math{timer = 0})

What other examples can you come up with?

---
# Introducing Compound Inequalities

Many times we need to _combine_ inequalities:

- Should I go to the beach? (@math{temperature \gt 80°} and @math{weather = "sunny"})
- Was this burrito worth the price? (@math{taste = "delicious"} and @math{price \leq $15})

What other examples can you come up with?

<!--
Guide students through other examples of `and` and `or` with various statements, such as "I'm wearing a red shirt AND I'm a math teacher, true or false?" or "I'm an NBA basketball star OR I'm having pizza for lunch, true or false?". This can make for a good sit-down, stand-up activity, where students take turns saying compound boolean statements and everyone stands if that statement is true for them.
-->

---
# Introducing Compound Inequalities

Both mathematics and programming have ways of combining - or _composing_ - inequalities.

Complete @printable-exercise{pages/boolean-coe-to-code1.adoc} and @printable-exercise{pages/and-or.adoc}.

---
# Introducing Compound Inequalities

- Expressions using `and` only produce `true` if both of their sub-expressions are `true`.
- Expressions using `or` produce `true` if *either* of their sub-expressions are `true`.

<!--
When describing compound inequalities, be careful not to use "english shortcuts". For example, we might say "I am holding a marker _and_ an eraser" instead of "I am holding a marker _and_ I am holding an eraser." These sentences mean the same thing, but the first one obscures the fact that "and" joins two complete phrases. For ELL/ESL students, this is unecessarily adds to cognitive load!
-->

---
# Solutions and Non-Solutions of Compound Inequalities

Identify 4 solutions and 4 non-solutions for each of the following inequalities.

* @math{x \gt 5}
* @math{x \le 15}

---
# Solutions and Non-Solutions of Compound Inequalities

What about the solution set of @math{x \gt 5} `and` @math{x \le 15}?  What numbers make both of these inequality expressions true?

How would that be different from @math{x \gt 5} `or` @math{x \le 15}?  What numbers make at least one of these inequality expressions true?


---
# Solutions and Non-Solutions of Compound Inequalities

Open @starter-file{inequalities-compound}, read the code carefully and click run to see the graphs you've just considered.

This starter file includes two special functions.

---
# Solutions and Non-Solutions of Compound Inequalities

`and-intersection` takes in two functions and a list of numbers and produces a graph with the points and the shaded @vocab{intersection} of values that make both of the inequalities true.

@show{ (code '(define (gt5 x) (> x 5))) }

@show{ (code '(define (lte15 x) (<= x 15))) }

@show{ (code '(and-intersection gt5 lte15 (list -5 -2.1 0 5 10 39/5 15 20))) }

@image{images/intersection1.png,"A compound inequality displayed on a number line, showing the intersection of two simple inequalities"}

---
# Solutions and Non-Solutions of Compound Inequalities

@show{ (code '(define (lt5 x) (< x 5))) }

@show{ (code '(define (gte15 x) (>= x 15))) }

@show{ (code '(and-intersection lt5 gte15 (list -5 -2.1 0 5 10 39/5 15 20))) }

_Note: Some pairs of inequalities do not intersect at all and therefore have *no solutions*._

@image{images/intersection-no-solution1.png,"A compound inequality displayed on a number line, showing no intersection and therefore no solutions"}

---
# Solutions and Non-Solutions of Compound Inequalities

`or-union` takes in two functions and a list of numbers and produces a graph with the points and the shaded @vocab{union} of values that make either or both of the inequalities true.

@show{ (code '(define (lt5 x) (< x 5))) }

@show{ (code '(define (gte15 x) (>= x 15))) }

@show{ (code '(or-union lt5 gte15 (list -5 -2.1 0 5 10 39/5 15 20))) }

@image{images/union1.png,"A compound inequality displayed on a number line, showing the union of two simple inequalities"}

---
# Solutions and Non-Solutions of Compound Inequalities

@show{ (code '(define (gt5 x) (> x 5))) }

@show{ (code '(define (lte15 x) (<= x 15))) }

@show{ (code '(or-union gt5 lte15 (list -5 -2.1 0 5 10 39/5 15 20))) }

_Note: Some @vocab{unions}, like the one below, include *all real numbers*; they have have *infinite solutions* that satisfy at least one of the inequalities._

@image{images/union-infinite1.png,"A compound inequality displayed on a number line, showing an infinite union"}

---
# Solutions and Non-Solutions of Compound Inequalities

Turn to @printable-exercise{compound-inequality-solutions.adoc} and explore the compound inequalities listed using the @starter-file{inequalities-compound}, identifying solutions and non-solutions for each.

---
# Solutions and Non-Solutions of Compound Inequalities

Instead of defining two functions as simple inequalities, we could produce the same graph by defining one function to be a compound inequality.

@show{ (code '(define (fiveto15 x)(and (> x 5) (<= x 15)))) }
@show{ (code '(inequality fiveto15 (list -5 -2.1 0 5 10 12 15 20))) }

Turn to @printable-exercise{compound-inequality-functions.adoc} and write code to describe the compound inequalities pictured.

<!--
@ifproglang{pyret}{If you have time, have students open to @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fdf8618945cb549d457fb85, Matching Compound Inequality Functions and plots}
}
-->

---
# Solutions and Non-Solutions of Compound Inequalities

How did the graphs of intersections and unions differ?

---
# Additional Exercises:

- @opt-printable-exercise{pages/boolean-coe-to-code2.adoc}

