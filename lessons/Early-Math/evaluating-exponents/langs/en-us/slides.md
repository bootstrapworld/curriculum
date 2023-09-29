@slidebreak
{layout="Math Title Slide"}
# Evaluating Exponents

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="Launch"}
# Expressions with Exponents 

Look at this expression: @math{2^3}

One way of reading this expression is "two raised to the power of three." 

Do you know any other ways of translating this expression into words?

<!--
** _Two to the third power; two to the third; two cubed_
-->

@slidebreak
{layout="LaunchR"}
# Expressions with Exponents 

What does it mean to _cube_ a number?

We multiply it by itself three times! In other words, we literally compute the volume of a cube with a side length of that number.

@math{2^3 = 2 \times 2 \times 2 = 8}

@image{images/cube.png}


@slidebreak
{layout="Launch"}
# Expressions with Exponents 


- The number on the left in an expression like @math{2^3} is called the @vocab{base}. That number is multiplied by itself when we apply the exponent.

- The smaller, raised number after the base is called the @vocab{exponent}; it indicates how many times to multiply the base.

- "Cubing" is the same as "raising to the third power", and "squaring" is the same as raising to the second power.

- There is no special terminology for any other exponents.

@slidebreak
{layout="Launch"}
# Expressions with Exponents 

We can represent expressions with exponents as Circles of Evaluation.

The function we use to do so is called `expt`; when we use `expt`, the first value is the _base_, and the second value is the exponent.

@slidebreak
{layout="LaunchC"}
# Expressions with Exponents 

Take a look at the two @vocab{equivalent} Circles of Evaluation, below. One is written in exponent notation, and the other is written in expanded notation.

Exponents are valuable because they act as a shorthand.

@image{images/coes1.png}

@slidebreak
{layout="LaunchC"}
# Expressions with Exponents 

Now, turn to @printable-exercise{pages/exponents-intro.adoc}, where you will practice translating verbal exponent expressions into exponent notation, expanded notation, and Circles of Evaluation.

@image{images/basics.png}

@slidebreak
{layout="LaunchR"}
# Expressions with Exponents 

- When you're done, consider the Circle of Evaluation (right) that Jayla drew to represent the expanded form of @math{2^4}.
- Jayla's Circle is different from the solution provided for the first problem on the worksheet. Is her response correct? Why or why not?

@show{(coe '(* (* 2 2) (* 2 2)))}

<!--
** _Yes, students may group the bases in a variety of ways, as per the @vocab{Associative Property} of Multiplication!_
-->


@slidebreak
{layout="Launch"}
# Expressions with Exponents 

Angela says the Circles of Evaluation below are equivalent because of the @vocab{Commutative Property}. Do you agree with Angela?

@image{images/coes2.png}

<!--
** _Angela is incorrect. The first expression evaluates to 25, while the second expression evaluates to 32. We cannot switch the order of the exponent and the base, as we could when adding or multiplying values._
-->

@slidebreak
{layout="Launch"}
# Expressions with Exponents 


Are these two Circles of Evaluation equivalent? Why or why not?

@image{images/coes3.png}

<!--
** _No; multiplying the base by the exponent is a common student error which produces a different result than multiplying the base by the base._
-->


@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

How would you translate each of these Circles of Evaluation into words? Why are their translations different?

@image{images/coes4.png}

<!--
** _The Circle of Evaluation on the left is "nine multiplied by three squared," while the Circle of Evaluation on the right is "find the product of nine and three, then square it." Their translations differ because the Circles of Evaluation are organized differently._
-->


@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

"nine multiplied by three squared" versus "find the product of nine and three, then square it."

@image{images/coes4.png}

@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

How would you translate each of these Circles of Evaluation into mathematical expressions?

@image{images/coes4.png}

<!--
** The Circle of Evaluation on the left is @math{9 \times 3^2} while the Circle of Evaluation on the right is @math{(9 \times 3)^2}.

Students will likely suggest @math{9 \times (3^2)} as a translation for the Circle of Evaluation on the right. This response is correct - but it is valuable for students to recognize that expressions with exponents are often written _without_ the parentheses. That said, the base and the exponent should always be placed within a Circle.
-->

@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

@math{9 \times 3^2} versus @math{(9 \times 3)^2} 

@image{images/coes4.png}

@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

In an expression with no grouping symbols, we evaluate the exponent before the other operations.


@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

- Try the @printable-exercise{pages/matching-expressions-to-circles.adoc} to practice matching Circles of Evaluation with their corresponding mathematical expressions.
- Translate between Circles of Evaluation, mathematical expressions, and words on @printable-exercise{pages/translating-exponent-expressions.adoc}

@slidebreak
{layout="Investigate"}
# Expressions with Exponents 

In @printable-exercise{pages/wodb.adoc}, examine each Circle of Evaluation to determine which expressions in the set are equivalent. The first problem is below.

@image{images/wodb.png}

@slidebreak
{layout="Synthesize"}
# Expressions with Exponents 

Is @math{2 + (6^2)} equivalent to @math{2 + 6^2} ?

Is @math{2 + 6^2} equivalent to @math{(2 + 6)^2} ? 

Justify your responses.

<!--
Q1: _Yes, these expressions are equivalent. Applying an exponent is a function separate from addition, regardless of whether we put it in parentheses or not._

Q2: _No, these expressions are not equivalent. For the first expression, we apply the exponent and then multiply. For the second expression, we multiply and then apply the exponent._
-->


@slidebreak
{layout="LaunchC"}
# Algebraic Expressions with Exponents

Ms. Brenneman asked her class to draw Circles of Evaluation to represent @math{4m^2}. Four students produced four different Circles of Evaluation! Which one matches the expression? If you’re not sure, are there any that you can rule out right away?{style="font-size:24pt"}

@image{images/four-students.png}

<!--
** _Sample response: Jayla's Circle of Evaluation is correct. I know that Keke's response is incorrect because we cannot change the order of the base and the exponent. Joe's Circle of Evaluation doesn't work because he added rather than finding a product. Aaron squared @math{4m}, rather than just squaring @math{m}._
-->

@slidebreak
{layout="Launch"}
# Algebraic Expressions with Exponents

When we _evaluate_ an @vocab{algebraic expression}, we substitute in a given value for the variable and then simplify the expression to a single number. 

@slidebreak
{layout="LaunchC"}
# Algebraic Expressions with Exponents

Let's evaluate the Circles of Evaluation made by Keke, Jayla, Joe, and Aaron using @math{m = 5}.

Do any of the expressions produce the same outcome? Why or why not?

@image{images/four-students.png}

<!--
** _Each Circle of Evaluation has a different result because they all have different structures; one Circle of Evaluation even uses addition rather than multiplication. Jayla's evaluates to 100; Keke's evaluates to 132; Joe's evaluates to 29; and Aaron's evaluates to 400._
-->

@slidebreak
{layout="Investigate"}
# Algebraic Expressions with Exponents

- Turn to @printable-exercise{pages/exponents-variables-table.adoc}. Draw a Circle of Evaluation to represent each expression that is provided in the left-hand column. The first one is done for you.
- Once you have completely filled in the Circle of Evaluation column, move to the Evaluate column, where you will evaluate each expression by substituting in the given value.

@slidebreak
{layout="Synthesize"}
# Algebraic Expressions with Exponents

- Jayla says that she likes to imagine an "invisible parentheses" enclosing every base and exponent. What is she describing? Do you find this helpful?
- What was your strategy for evaluating expressions with variables and exponents?
