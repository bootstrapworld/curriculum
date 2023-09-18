---
{layout="Math Title Slide"}
# Permutations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Permutation with Replacement

Luigi's Family Restaurant is about to open, and it's going to be the hottest restaurant in town. They have a menu with six different dishes, and they plan to offer a four-course "Italian Safari" dinner for the low-low price of $9.95 per person. 

@image{images/pizza.png}


---
{layout="Launch"}
# Permutation with Replacement


The gimmick is that diners can __choose the order of the courses:__ you might start with Lasagna, but your friend can start with the Chicken Parmesan, and so on. And if your friend happens to really, *really* like Chicken Parmesan, they can choose to eat it for all four courses!

---
{layout="Launch"}
# Permutation with Replacement

They advertise "an almost-endless number of dining experiences." In fact, Luigi himself guarantees free food for life for anyone who can eat every possible configuration. If you ate dinner there every night, how long would it take to try each one? In other words, __how many ways can you reshuffle those four courses__?

---
{layout="Launch"}
# Permutation with Replacement

Luigi isn't going to give away free food just because you order four courses - he wants you to order four courses _in every possible order_! In situations where order matters, the set of possible options is called @vocab{permutations}.

In Permutations, order matters!


---
{layout="Launch"}
# Permutation with Replacement

In some restaurants, you're not allowed to order the same item for more than one course. In other words, __once you've picked lasagna, it's no longer on the menu for your next course!__ This is called *permutation _without_ replacement*.

Luigi is a nice guy, so once you order lasagna it is "replaced" with the option to order it again for the next course! This is called *permutation _with_ replacement*.

---
{layout="Launch"}
# Permutation with Replacement

With six dishes to choose from and four courses to eat, how many @vocab{permutations} are there? How many meals would we have to eat, to get free food for life?


---
{layout="Investigate"}
# Permutation with Replacement

Luigi has six possible dishes to choose from. 

- How many permutations could there be for a 1-course dinner?
- How many permutations could there be for a 2-course dinner?
- How many permutations could there be for a 3-course dinner?
- Is there a pattern here?

---
{layout="Investigate"}
# Permutation with Replacement

It's useful to use __tree diagrams__, so we can see what our possible choices are. A tree diagram is a way of tracking a series of events. In this case, each course we choose is an event.


---
{layout="InvestigateC"}
# Permutation with Replacement

Let's diagram all permutations for a 1-course meal. With six menu items, a 1-course meal could be Lasagna, Pizza, Chicken, Ravioli, Soup or Ziti. That means the set of all possible 1-course @vocab{permutations} has six different meals. In less than a week, we'd have tried all the possibilities!

@image{images/6-1-course-permute-w-replacement.png}


---
{layout="InvestigateC"}
# Permutation with Replacement

But what about a 2-course meal? Each of our 1st-course choices has __another tree__ underneath it!

After we've picked our first course, how many options do we have for the second? 

@image{images/6-2-course-permute-w-replacement.png}


<!--
Every time we get to make a choice, each endpoint in our tree sprouts six more branches.

If we choose Lasagna for our first course... we can choose it again for the second course or we can choose any of the other options, which means we still have six choices. In other words, someone could order Lasagna & Lasagna (L-L), Lasagna & Pizza (L-P), Lasagna & Chicken (L-C), Lasagna & Ravioli (L-R), Lasagna & Soup (L-S), or Lasagna & Ziti (L-Z).  That's six possible orders with Lasagna as the first course. Each of the other first course options also comes with six possible second course order options... that's @math{6 \times 6} ! So, instead of taking six days to try all the permutations, now it takes __36 days__ - more than a month!
-->

---
{layout="Investigate"}
# Permutation with Replacement

- For practice with tree-diagrams and permutations, complete @printable-exercise{pages/tree-diagrams.adoc}.
- How many permutations would there be in a 3-course meal?

---
{layout="Investigate"}
# Permutation with Replacement

The number of @vocab{permutations} is computed based on two things:

- The number of possible menu __items__. (Lasagna? Chicken? Soup?)
- How many times we get to __choose__. (1-course meal? 3-course meal?)


---
{layout="Investigate"}
# Permutation with Replacement

Let's see this as a function:

@math{\mbox{permute-w-replace}(items, choose) = choose^{items} \\ \\

\mbox{permute-w-replace}(6, 1) = 6^{1} = 6 \\ \\


\mbox{permute-w-replace}(6, 2) = 6^{2} = 36 \\ \\

\mbox{permute-w-replace}(6, 3) = 6^{3} = 216}


---
{layout="Investigate"}
# Permutation with Replacement

How many permutations are there for a 4-course meal chosen from Luigi's 6-item menu?

@math{\mbox{permute-w-replace}(6, 4) = 6^{4} = 1296}

With four courses, it would take more than __3.5 years__ to try them all -- if we ate dinner at Luigi's every night!


---
{layout="Investigate"}
# Permutation with Replacement

- In Pyret, we can raise a 6 to the power of four with the `num-expt` function. 
- For example, `num-expt(6, 4)` will compute @math{6^4}. 
- In the Definitions Area, use the Design Recipe to define `num-permute-w-replace`, which consumes the number of items and the number of choices and produces the number of possible permutations (with replacement).


--- 
{layout="Synthesize"}
#Permutation with Replacement

What are some other examples of permutation? 


<!--
Possible solutions: Password strength, guessing combination locks...
-->

---
{layout="Launch"}
# Permutation without Replacement

After a few months, Luigi realizes that he's losing money. He could either raise his prices, or streamline the cooking process. His daughter observes that there's no way to predict how many ingredients to buy, since some people might want four courses of Soup and others might want four courses of ziti. Without being able to predict the ingredients, Luigi winds up buying too much of one thing and not enough of another - resulting in a lot of wasted food and unhappy customers!

---
{layout="Launch"}
# Permutation without Replacement

Luigi proposes an important change to his "Italian Safari deal": **No item can be ordered twice.**

He also decides to simplify his menu even further, down to just **four different options**.

With no one ordering four of the same thing and far fewer choices to make, it's a lot easier to predict what to buy, so it will waste less food and save Luigi a lot of money.


---
{layout="LaunchC"}
# Permutation without Replacement

Now how long would it take to try every permutation?

Let's start by drawing the tree diagram for 1st place:

@image{images/4-1-course-permute-wo-replacement.png}


---
{layout="LaunchC"}
# Permutation without Replacement

There are *four* possible items we could eat for our first course, so we have 4 possible branches. After we eat that course, it's time to order the second course! How many branches are there for the second course, under each first course choice?

@image{images/4-2-course-permute-wo-replacement.png}

---
{layout="Launch"}
# Permutation without Replacement


We can't order the same thing twice so once we've eaten Pizza for the first course, there are only _three_ possible items left to choose from: Chicken, Ravioli and Soup. 

If we start with Chicken, we can't order Chicken again, but we can choose from Pizza, Ravioli and Soup for our second course. No matter what we choose for our first course, we still have three choices left for our second course. This is called @vocab{permutation} *without replacement*. Now there are only @math{4 \times 3 = 12} permutations, instead of the 16 we'd have with replacement.



---
{layout="LaunchC"}
# Permutation without Replacement


We can visualize our four courses as a four-level tree, with each set of branches getting smaller and smaller until there's only one option left. In the tree diagram below, you can see a _partial_ drawing of all four courses.

@image{images/4-4-course-permute-wo-replacement.png}

<!--
If we start with Chicken, we can order:

- Chicken, Pizza, Ravioli & Soup
- Chicken, Pizza, Soup & Ravioli
- Chicken, Ravioli, Pizza & Soup
- Chicken, Ravioli, Soup & Pizza
- Chicken, Soup, Ravioli & Pizza
- Chicken, Soup, Pizza & Ravioli

That's six different permutatons that start with Chicken, and we have four different other possible meals to start with.

-->

---
{layout="Launch"}
# Permutation without Replacement


We can compute the number of permutations-without- replacement by multiplying the number of choices as they shrink after each course: @math{4 \times 3 \times 2 \times 1 = 24}.

<!--
This lesson assumes that students are familiar with factorial notation (@math{n!}). To teach this lesson _without_ students knowing about factorials, you will need to skip the function notation that follows. This is feasible, but not recommended.

Reminder: @math{0! = 1} @link{https://www.chilimath.com/lessons/intermediate-algebra/zero-factorial/, Click here for an explanation}.
-->

---
{layout="Launch"}
# Permutation without Replacement


Now we could try all the permutations in just under a month!

**Luigi decides this makes it too easy, and now that his kitchen is running smoothly he decides to bring back the original six-item menu.**

In this situation, there might be six items on the menu, but we want to __stop multiplying after the first four items are chosen__.

@math{6 \times 5 \times 4 \times 3 = 360}

---
{layout="Launch"}
# Permutation without Replacement


We can write this by starting with our factorial notation from before (where every number from 6 to 1 is multiplied), and then "undoing" the @math{2 \times 1}. This takes the form of __dividing__:

@math{\frac{6 \times 5 \times 4 \times 3 \times 2 \times 1}{2 \times 1} = \frac{6!}{2!} = 360}

---
{layout="Launch"}
# Permutation without Replacement


With this number of possible combinations, it would take almost a year to try them all! And with less wasted food and a faster kitchen, Luigi has a lot of happy customers and a lot of money in the bank.

We can write this relationship as a function:

@math{\mbox{permute-no-replace}(\mbox{items}, \mbox{choose}) = \frac{\mbox{items}!}{(\mbox{items} - \mbox{choose})!}}


---
{layout="Launch"}
# Permutation without Replacement

For practice, complete @printable-exercise{permutation.adoc}.

In Pyret, we can compute the factorial of 6 with the `factorial` function. For example, `factorial(6)` will compute @math{6 \times 5 \times 4 \times 3 \times 2 \times 1}. In the Definitions Area, use the Design Recipe to define `num-permute-wo-replace`, which consumes the number of items and the number of choices and produces the number of possible permutations (_without_ replacement).



---
{layout="Synthesize"}
# Permutation without Replacement

- What is the difference between permutation with or without replacement?

- What are some real-world examples of each?


---
{layout="Supplemental"}
# Additional Exercises

* @opt-starter-file{permutations-and-combinations} provides students with a chance to view all the permutations and combinations for Luigi's menu.
* @opt-printable-exercise{tree-diagrams2.adoc}
