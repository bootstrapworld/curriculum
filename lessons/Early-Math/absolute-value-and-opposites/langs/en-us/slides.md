---
{layout="Math Title Slide"}
# Absolute Value and Opposite

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Finding Opposites

- What number is the same distance from zero as @math{8}?
- What number is the same distance from zero as @math{-3}?

@image{images/num-line.png}


<!--
- What number is the same distance from zero as @math{8}?
** _@math{-8}_
- What number is the same distance from zero as @math{-3}?
** _@math{3}_
- The pairs of numbers we've just identified are called @vocab{opposites} - two numbers that are the same distance from zero on the number line, with one negative and one positive.
- What are some other pairs of opposites that you can identify?
** _Possible responses: @math{6.5} and @math{-6.5}; @math{4} and @math{-4}; @math{\frac {7}{3}} and @math{- \frac {7}{3}}._
-->

---
{layout="Launch"}
# Finding Opposites

The pairs of numbers we've just identified are called @vocab{opposites} - two numbers that are the same distance from zero on the number line, with one negative and one positive.


---
{layout="Launch"}
# Finding Opposites

What are some other pairs of opposites that you can identify?

@image{images/num-line.png}

<!--
** _Possible responses: @math{6.5} and @math{-6.5}; @math{4} and @math{-4}; @math{\frac {7}{3}} and @math{- \frac {7}{3}}._
-->

---
{layout="Investigate"}
# Finding Opposites

Today is an exciting day! 

Rather than using an @vocab{operator} at the top of each Circle of Evaluation, we are going to use... @vocab{functions}!

---
{layout="Investigate"}
# Finding Opposites

Operators always have two inputs and, in standard mathematical notation, they always go in the middle of their inputs. @vocab{Functions}, however, can have _any amount_ of inputs - and all kinds of inputs, not just numbers!

Incorporating functions into our Circles of Evaluation will expand their utility. With functions, we can diagram and interpret expressions that include opposites, absolute value, exponents, square roots, Booleans... the list goes on.

---
{layout="InvestigateR"}
# Finding Opposites

The function used to represent "the opposite" is called `negate`. 


`negate` can be used like any other operator that we put at the top of a Circle of Evaluation - with one important difference: when we use `negate`, we include just one argument inside the Circle.

What do you think the Circle to the right evaluates to?


@show{(coe '(negate 2))}

---
{layout="InvestigateR"}
# Finding Opposites

What happens if we nest a negating Circle of Evaluation _inside of_ another negating Circle, as you see on the right?

@show{(coe '(negate (negate 2)))}

<!--
_The opposite of the opposite of a number is the number itself._
-->

---
{layout="Investigate"}
# Finding Opposites

Try negating a few more times, to make sure you've got the hang of it. 

What do each of these Circles evaluate to?

@image{images/practice.png}

---
{layout="Investigate"}
# Finding Opposites

Practice applying `negate` on @printable-exercise{pages/true-or-false-negate.adoc}. Evaluate each side of the @vocab{equation} to confirm if it is true or false.

@image{images/true-or-false.png}


---
{layout="Investigate"}
# Finding Opposites

On @printable-exercise{pages/true-or-false-negate-2.adoc}, explore Circles of Evaluation with @vocab{Variables}, and review previously explored properties (Identity, Commutative, Associative, and Distributive).

@image{images/true-or-false-2.png}

---
{layout="Investigate"}
# Finding Opposites

When we want to show negation of a number or an expression, we just use a negative sign! So, while we can read @math{-45} by simply saying "negative 45," another way to read that value's name is by saying, "the opposite of 45."

Similarly, @math{-(x + m)} can be translated as "the opposite of the sum of @math{x} and @math{m}."

<!--

Precise language is crucial when dealing with this symbol: `-`.

In math we want students to read for _comprehension_, not just mechanically sounding out each symbol in order. We read the @vocab{arithmetic expression} @math{12 - 9} as "12 minus 9" __because subtraction is the "verb"__, not because the minus sign happens to be in the middle!

When we encounter a value such as @math{-20}, however, it is confusing and misleading to name that value "minus 5." Subtraction is not happening here - negation is! But if the teacher uses the "symbols in order" wording, it reinforces the lower level of reading comprehension for students.
-->

---
{layout="Synthesize"}
# Finding Opposites

- Two opposites are 8 units apart from each other. What are they?
- Two opposites are 42.5 units apart from each other. What are they?
- Cia says that opposites are always negative. Are they right? Why?
- We have learned that opposites are two numbers that are the same distance from zero on the number line, with one negative and one positive. Knowing this, what do you think is the opposite of zero?

<!--
- Two opposites are 8 units apart from each other. What are they?
** @math{4} and @math{-4}
- Two opposites are 42.5 units apart from each other. What are they?
** @math{21.5} and @math{-21.5}
- Cia says that opposites are always negative. Are they right? Why?
** _No, opposites are not always negative. Positive numbers always have negative opposites - but negative numbers have positive opposites!_
- We have learned that opposites are two numbers that are the same distance from zero on the number line, with one negative and one positive. Knowing this, what do you think is the opposite of zero?
** _Zero is its own opposite!_
-->


---
{layout="Launch"}
# Absolute Value

What is the distance between these two points on the number line: @math{-8} and @math{5}?

@image{images/num-line.png}


<!--
Give students a minute to contemplate, and then invite them to verbally share their strategies. Record students' thinking on the board, annotating the number line. All strategies are welcome, with a special interest in any discussion that hones in on the idea of _the distance of a number from zero._
-->

---
{layout="Launch"}
# Absolute Value

Absolute value is the (positive) distance of a number from zero.

We annotate absolute value like this: @math{|x|}, with @math{x} being any given number. 

When we encounter an expression like @math{|x|}, we say "the absolute value of @math{x}."


---
{layout="Launch"}
# Absolute Value

Because _opposites_ are the same distance away from zero, they will always have the same absolute value. 

So, @math{|4| = 4} and @math{|-4| = 4}.


---
{layout="Investigate"}
# Absolute Value

The @vocab{function} that we will use to represent absolute value is `abs`. 

It can be used like any other operator that we put at the top of a Circle of Evaluation. 

As with `negate`, when we use `abs`, we include just one argument inside the Circle of Evaluation.

---
{layout="Investigate"}
# Absolute Value

Let's try evaluating some Circles of Evaluation with `abs`! 

What does each of the Circles below evaluate to?

@image{images/practice2.png}

---
{layout="Investigate"}
# Absolute Value

- On @printable-exercise{pages/true-or-false-abs-val.adoc}, you will compare expressions with `abs` to expressions with `negate`
- On the bottom half of the page, determine whether variable equations featuring `negate` and `abs` are always, sometimes, or never true. Be sure to explain your response.


---
{layout="Investigate"}
# Absolute Value

Examine the Circles of Evaluation to determine @printable-exercise{pages/wodb-abs-val-negate.adoc}. The page starts with numeric values and then integrates variables. Place a check mark by each Circle that meets the condition stated on the left.

@image{images/wodb.png}


---
{layout="Synthesize"}
# Absolute Value


Think about the @vocab{algebraic expressions} @math{|h|} and @math{-h}.

- What do we know about the outcomes of each of these expressions?

- When do they produce the same outcome?

- When do they produce different outcomes?

<!--

- What do we know about the outcomes of each of these expressions?
** _@math{|h|} is always positive or zero, while @math{-h} can be negative, zero, or positive._

- When do they produce the same outcome?
** _@math{-h} is positive when @math{h} is negative, and @math{-h} is negative when @math{h} is positive. As a result, @math{|h|} and @math{-h} produce the same outcome only when @math{h} is negative or zero._

- When do they produce different outcomes?
** _@math{|h|} and @math{-h} produce different outcomes when @math{h} is positive._
-->