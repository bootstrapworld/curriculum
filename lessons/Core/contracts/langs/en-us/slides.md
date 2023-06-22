---
{layout="Core Title Slide"}
# Contracts
<!-- 
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Applying Functions

Programming languages have **nouns** and **verbs**. 

Verbs _do things to nouns_. For example, I can "_throw_ a ball", or "_eat_ a sandwich". "Throw" and "Eat" are verbs, and "ball" and "sandwich" are nouns.

In programming, **values are like nouns**. You've learned about _values_ in our programming language, like Numbers (`42`, `-8.3`, etc), Strings (`"hello!"`), and Booleans (`true` and `false`). @ifproglang{pyret}{We already know _some_ verbs, like `+`, and `*` - each of which _does something_ to Numbers.}

---
{layout="Launch"}
# Applying Functions

In programming, our verbs are called @vocab{functions}. A function is like a machine, and it does three things:
- It takes in some values (called @vocab{arguments})
- It _does something_ to those values
- It produces a new value

Let's play with a few functions, to get the hang of it.

---
{layout="Launch"}
# Applying Functions

- Log into @starter-file{editor}
- Open the editor and press "Run", then type @show{(code '(sqrt 16))} into the Interactions Area and hit Enter.
- What part of this expression is the _value_?
- What is the name of this function? @show{(code 'sqrt)}
- How many arguments are we giving to this function?
- What is the type of the argument we are giving to `sqrt`?
- What did @show{(code 'sqrt)} produce?
- What type of data did `sqrt` produce?
<!--
- Log into
- What part of this expression is the _value_?
** _16_
- What is the name of this function? @show{(code 'sqrt)}
- How many arguments are we giving to this function?
** _1_
- What is the type of the argument we are giving to `sqrt`?
** _A Number_
- What did @show{(code 'sqrt)} produce?
** _4_
- What type of data did `sqrt` produce?
** _Number_

**Encourage students to try giving different arguments to `sqrt`. Does it only work with Numbers? Does it only take one Number?**

-->
---
{layout="Launch"}
# Applying Functions

- Type @show{(code '(string-length "rainbow"))} into the Interactions Area and hit Enter:
- What is the name of this function?
- How many arguments does `string-length` expect?
- What type of argument does the function expect?
- What does the expression evaluate to?
- What type of data did `string-length` produce?
<!--
- What is the name of this function?
** _string-length_
- How many arguments does `string-length` expect?
** _1_
- What type of argument does the function expect?
** _String_
- What does the expression evaluate to?
** _7_
- What type of data did `string-length` produce?
** _Number_

**Encourage students to try giving different arguments to `string-length`. Does it only work with Strings? Does it only take one String? What does it do?**

@ifproglang{pyret}{
**This is a terrific opportunity to remind students of function notation, which Pyret mirrors precisely!**

Note that @vocab{arguments} (or "inputs") are the _values_ passed into a function. This is different from @vocab{variables}, which are the placeholders that get _replaced_ with those arguments! Pyret has lots of built-in functions, which we can use to write more interesting programs.
}
-->

---
{layout="Investigate-DN"}
# Applying Functions

With your partner, complete @printable-exercise{pages/applying-functions.adoc} 

When you finish, try changing the expression @show{(code '(triangle 50 "solid" "red"))} to use `"outline"` for the second argument. Then try changing colors and sizes!

---
{layout="Synthesize"}
# Applying Functions

- What are the types of the arguments `triangle` was expecting? 
- How does the output relate to the inputs?
- What kind of value was produced by that expression? 
- Which error messages did you encounter?

<!--
- What are the types of the arguments `triangle` was expecting? _A Number and 2 Strings_
- How does the output relate to the inputs? _The Number determines the size and the Strings determine the style and color._
- What kind of value was produced by that expression? _An Image! New data type!_
- Which error messages did you encounter?
-->

---
{layout="Launch"}
# Contracts

When you typed @show{(code '(triangle 50 "solid" "red"))}
into the editor, you created an example of a new @vocab{data type}, called an _Image_!

The `triangle` function can make lots of different triangles! The size, style and color are all determined by the specific inputs provided in the code, but, if we don't provide the function with a number and two strings to define those parameters, we will get an error message instead of a triangle.

---
{layout="Launch"}
# Contracts

As you can imagine, there are many other functions for making images, each with a different set of arguments. For each of these functions, we need to keep track of three things:

- **Name** - the name of the function, which we type in whenever we want to use it

- **Domain** - the type(s) of data we give to the function

- **Range** - the type of data the function produces

---
{layout="Launch"}
# Contracts

The @vocab{Name}, @vocab{Domain} and @vocab{Range} are used to write a @vocab{Contract}.

Where else have you heard the word "contract"?  How can you connect that meaning to contracts in programming?

<!--
_An actor signs a contract agreeing to perform in a film in exchange for compensation, a contractor makes an agreement with a homeowner to build or repair something in a set amount of time for compensation, or a parent agrees to pizza for dinner in exchange for the child completing their chores. Similarly, a contract in programming is an *agreement* between what the function is given and what it produces._

@vocab{Contracts} tell us a lot about how to use a function. In fact, we can figure out how to use functions we've never seen before, just by looking at the contract! Most of the time, error messages occur when we've accidentally broken a contract.

@vocab{Contracts} don't tell us _specific_ inputs. They tell us the _@vocab{data type}_ of input a function needs. For example, a Contract wouldn’t say that addition requires "3 and 4". Addition works on more than just those two inputs! Instead, it would tells us that addition requires "two Numbers". When we _use_ a Contract, we plug specific numbers or strings into the expression we are coding.

Contracts are general. Expressions are specific.
-->

---
{layout="Launch"}
# Contracts

Let’s take a look at some functions we've seen before:

@image{images/sample-contracts-table.png}

---
{layout="Launch"}
# Contracts

When the input matches what the function consumes, the function produces the output we expect.

---
{layout="Launch"}
# Contracts

Here is an example of another function:

@show{(code '(string-append "sun" "shine"))}

Type it into @starter-file{editor, the editor}. What is its contract? 

<!--
contract: `string-append :: String, String -> String`
-->
---
{layout="Investigate-DN"}
# Contracts

With your partner, complete: 
- @printable-exercise{pages/practicing-contracts.adoc} 
- @printable-exercise{pages/matching-expressions.adoc} 

---
{layout="Synthesize"}
# Contracts

- What is the difference between a value like `17` and a type like `Number`?
- For each expression where a function is given inputs, how many outputs are there? 

---
{layout="Launch"}
# Exploring Image Functions

Suppose we had never seen `star` before. How could we figure out how to use it, using the helpful error messages?
- Type `star` into the Interactions Area and hit "Enter". What did you get back? What does that mean? 
- If it's a function, we know that it will need an open parentheses and at least one input. Try @show{(code '(star 50))}
- What error did we get? What _hint_ does it give us about how to use this function? 
- What happens if I don't give it those things?
- If I give `star` what it needs, what do I get in return?

<!--
The error messages in this environment are _designed_ to be as student-friendly as possible. Encourage students to read these messages aloud to one another, and ask them what they think the error message _means_. By explicitly drawing their attention to errors, you will be setting them up to be more independent in the next activity!
-->

---
{layout="Launch"}
# Exploring Image Functions


- What is the contract for `star`? 
- The contract for `square` also has `Number String String` as the Domain and `Image` as the Range. Does that mean the functions are the same? 

<!--
No! The Domain and Range are the same, but the function name is different... and that's important because the `star` and `square` functions do something very different with those inputs!_
-->

---
{layout="Investigate-DN"}

# Exploring Image Functions

- Take the next 10 minutes to experiment with the image functions listed in @opt-printable-exercise{image-contracts.adoc, the contracts pages}. 

- When you've got working expressions, record the contracts and the code!

You will be adding to these contract pages and referring back to them for the remainder of this Bootstrap class!


---
{layout="Synthesize"}
# Exploring Image Functions

- Does having the same Domain and Range mean that the functions do the same things? 
- A lot of the Domains for shape functions are the same, but some are different. Why did some shape functions need more inputs than others?

---
{layout="Synthesize"}
# Exploring Image Functions

- Was it harder to find contracts for some of the functions than others? Why?
- What error messages did you see? 
- How did you figure out what to do after seeing an error message? 
- Which input determined the size of the Rhombus?  What did the other number determine?

---
{layout="Launch-DN"}
# Contracts Help Us Write Code

Turn to @printable-exercise{pages/using-contracts.adoc} and experiment with the functions in the editor. Optional: @opt-printable-exercise{pages/using-contracts-cont.adoc}.

Once you've discovered how to build a version of each image function that satisfies you, record the example code in your contracts table. 

It may help you to jot down some notes about your discoveries. We will be sharing our findings later.

---
{layout="Investigate"}
# Contracts Help Us Write Code

- What kind of triangle did `triangle` build? 
- Only one of the inputs was a number. What did that number tell the computer? 
- What other numbers did the computer need to already know in order to build the `triangle` function? 
- If we wanted to build an isosceles triangle or a right triangle, what additional information would the computer need to be given?

<!--
- What kind of triangle did `triangle` build?
** _The `triangle` function draws equilateral triangles_
- Only one of the inputs was a number. What did that number tell the computer?
** _The size of the triangle_
- What other numbers did the computer need to already know in order to build the `triangle` function?
** _All equilateral triangles have three 60 degree angles and 3 equal sides_
- If we wanted to build an isosceles triangle or a right triangle, what additional information would the computer need to be given?
** _A right triangle requires the base (Number) and the height (Number). An isosceles triangle requires a leg (Number) and an angle (Number)._
-->

---
{layout="Investigate-DN"}
# Contracts Help Us Write Code

Complete @printable-exercise{pages/triangle-contracts.adoc}.

- Optional: @opt-printable-exercise{pages/triangle-contracts-cont.adoc}
- Optional: @printable-exercise{pages/radial-star.adoc} 
- Optional: @opt-printable-exercise{pages/star-polygon.adoc} 

---
{layout="Synthesize"}
# Contracts Help Us Write Code

- How was it different to code expressions for the shape functions when you started with a contract?
- For some of you, the word `ellipse` was new. How would you describe what an ellipse looks like to someone who'd never seen one before?  
- Why did the contract for `ellipse` require two numbers? What happened when the two numbers were the same?

---
{layout="Synthesize"}
# Contracts Help Us Write Code

Diagnosing and fixing errors is a skill we will continue working on developing.{style="font-size:15pt"}

Some of the errors are @vocab{syntax errors}: a missing comma, an unclosed string, etc.{style="font-size:15pt"} 

All the other errors are @vocab{contract errors}.{style="font-size:15pt"} 

If you see an error and you know the syntax is right, ask yourself these three questions:{style="font-size:15pt"}

- What is the function that is generating that error?{style="font-size:15pt"}
- What is the contract for that function?{style="font-size:15pt"}
- Is the function getting what it needs, according to its Domain?{style="font-size:15pt"}

<!-- Common Misconceptions: Students are _very_ likely to randomly experiment, rather than to actually use the Contracts. You should plan to ask lots of direct questions to make sure students are making this connection, such as:

- How many items are in this function's Domain?
- What is the _name_ of the 1st item in this function's Domain?
- What is the _type_ of the 1st item in this function's Domain?
- What is the _type_ of the Range?
-->

---
{layout="Supplemental"}
# Additional Exercises:

@ifproglang{pyret}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90a1937b6430d836b67e7, Matching Images to Code}
}
@ifproglang{wescheme}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fecf203a29e040d182be6c6?collections=5fbecc2b40d7aa0d844956f0, Matching Images to Code}
}


