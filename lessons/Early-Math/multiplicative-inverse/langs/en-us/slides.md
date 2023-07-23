---
{layout="Math Title Slide"}
# The Multiplicative Inverse Property
<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# The Multiplicative Inverse Property
 
We know that the Commutative and Associative Properties apply to multiplication...but not division. But what if there was a way to _rewrite_ division as multiplication? Then we could apply the Commutative and Associative Properties to division expressions, too! Let’s explore this idea.



---
{layout="Launch"}
# The Multiplicative Inverse Property

Let's play a game. 

I'm going to write a number in the left-hand column. You are going to tell me what value I should _add_ to that number, to get a sum of zero. I'll record your response in the right-hand column.

@image{images/table.png}

---
{layout="Launch"}
# The Multiplicative Inverse Property

- The first number is @math{\frac{1}{2}}. What do I need to multiply @math{\frac{1}{2}} to get 1?
- The next number is @math{\frac{1}{3}}. What do I need to multiply @math{\frac{1}{3}} to get 1?
- How about @math{\frac{1}{100}}?
- How about @math{10}?
- Can someone offer me another pair of numbers - a fraction and a whole number - that multiply together to produce 1?

<!--
** _Allow a variety of students to share. Record responses on the table._
-->

---
{layout="Launch"}
# The Multiplicative Inverse Property

These number pairs all represent @vocab{reciprocals}. The reciprocal of a real number @math{n} is @math{\frac{1}{n}}. These number pairs are also illustrative of the @vocab{Multiplicative Inverse Property}: when we multiply them together, we always end up with a product of @math{1}.


---
{layout="Launch"}
# The Multiplicative Inverse Property

The @vocab{Multiplicative Inverse Property} tells us that multiplying a number by its @vocab{reciprocal} always produces one.

Every number, except zero, has a multiplicative inverse.


---
{layout="Investigate"}
# The Multiplicative Inverse Property

- Turn to @printable-exercise{multiplicative-inverse.adoc}.
- In the first section, practice finding reciprocals and write them in the space provided.
- Then, fill in the missing number to complete the equations. Some equations use mathematical notation and some use Circles of Evaluation.

---
{layout="Synthesize"}
# The Multiplicative Inverse Property

- Can you think of a way to visually represent that a number multiplied by its reciprocal produces one?
- How would you explain the Multiplicative Inverse Property to another student?


---
{layout="Launch"}
# Multiplication and Division: Inverse Operations{style="font-size:24pt"}

Now that we understand what a reciprocal is, we are ready to think about how we can put it to use... perhaps it can make some computations simpler?

- Complete @printable-exercise{discover-inverse.adoc}.
- When you're finished, complete @printable-exercise{discover-inverse-cont.adoc}.
- What did you observe about the multiplicative inverse and its value when doing mental computation?

---
{layout="Launch"}
# Multiplication and Division: Inverse Operations{style="font-size:24pt"}

Two main ideas emerged during the previous exploration:

- Dividing by @math{x} produces the same result as multiplying by its reciprocal, @math{\frac{1}{x}}.
- Dividing by @math{\frac{1}{x}} produces the same result as multiplying by its reciprocal, @math{x}.

<!--
In other words, when students see multiplication or division by a unit fraction (a fraction with a numerator of @math{1}), there is likely a path forward using mental computation only.
-->


---
{layout="Investigate"}
# Multiplication and Division: Inverse Operations{style="font-size:24pt"}

- Complete @printable-exercise{wodb.adoc}.
- Which problems were the most challenging? Which ones felt simple?
- What strategies did you use to determine equivalence?

---
{layout="Synthesize"}
# Multiplication and Division: Inverse Operations{style="font-size:24pt"}

- Claire and Soraya want to write an equivalent expression for @math{45 \div 9}. Claire studies the expression and announces that, because it involves division, the Commutative Property cannot be applied. Is she correct?
- Soraya grabs a pencil and writes the following: @math{45 \times \frac{1}{9}}. She says, "There! I fixed it. Now we can apply the Commutative Property." Explain what Soraya did. Is she correct?

<!--
** _Sample response: Instead of dividing by 9, sorry is multiplying by the reciprocal. Yes, Soraya has written an equivalent expression and can apply the Commutative Property - but the computation will not be any simpler._
-->

---
{layout="Launch"}
# Is the Order of Operations Universal?


- Consider this expression: @math{100 \times 20 \div 5}
- Rewrite the expression - either by adding parentheses or drawing a Circle of Evaluation - to show your process for solving.
- What do we get when we simplify the expression to a single value?
- How did you arrive at your answer?

<!--
Invite students to share their responses. If your students have spent any time at all studying the order of operations, they will notice both multiplication and division in the expression. From there, they will likely conclude that they must work from left to right to arrive at a correct result. 
-->

---
{layout="Launch"}
# Is the Order of Operations Universal?

The solving strategy that most students used can be represented like this:

@show{(coe '(/ (* 100 20) 5))}



---
{layout="Launch"}
# Is the Order of Operations Universal?


But does this strategy work? Do we get the same result?

@show{(coe '(* 100 (/ 20 5)))}

<!-- 
yes, both circles produce the same result!
-->


---
{layout="Investigate"}
# Is the Order of Operations Universal?

In Kenya, students are actually taught that, when confronted with an expression like @math{100 \times 20 \div 5}, they must divide first... and then multiply! But does it actually work, _every_ time? Let’s investigate.


---
{layout="InvestigateR"}
# Is the Order of Operations Universal?

- Turn to @printable-exercise{divide-first-or-left-to-right.adoc}.
- There, you will test out the "Kenya algorithm" on several different expressions to see if dividing and then multiplying produces the correct result every time.
- What do you Notice? What do you Wonder?

@image{images/kenya-flag.png}

---
{layout="Investigate"}
# Is the Order of Operations Universal?

- Why are we able to change the groupings for an expression like @math{100 \times 20 \div 5} ... but _not_ for an expression like @math{100 \div 20 \div 5}?
- Describe why the "Kenya algorithm" works. (Hint: Think about the @vocab{Multiplicative Inverse Property}!)

<!--
** _We can rewrite any division expression as multiplication by the reciprocal. Once we transform a division expression into a multiplication expression, we can apply the Commutative and Associative Properties freely!_

Encourage students to think deeply about why this algorithm works – and if you’d like, invite them to consider and discuss why students all across the country are typically taught just one algorithm when, typically, there are an abundance to choose from!

-->


---
{layout="Investigate"}
# Is the Order of Operations Universal?


Scan each expression to determine the simplest solving strategy, then compute mentally.

@math{114 \times 17 \div 17}

@math{15 \times 3 \div 15}

@math{2 \times 16 \times \frac{1}{27} \times 27}



---
{layout="Synthesize"}
# Is the Order of Operations Universal?

- How did it feel to scan the problem, choose your strategy, and then solve mentally?
- Did you like this new approach - or do you prefer solving from left to right?
- Knowledge of inverse operations creates _more_ opportunities to apply the @vocab{Commutative Property} and the @vocab{Associative Property}? Explain why this is the case.


---
{layout="Synthesize"}
# Is the Order of Operations Universal?

- Do you think the Order of Operations is universal? Why or why not?
- Can you think of any other examples - they can be math-related or not! - of when you thought there was just one way to do something... and then learned that you were wrong?

<!--
- Do you think the Order of Operations is universal? Why or why not?
_Yes, there is a basic agreed upon order across countries, but numerous differences exist within tiers and how they are described._
-->