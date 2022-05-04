---

# Contracts 

---
# Applying Functions

You may remember functions from algebra: @math{f(x) = x + 4}.

- What is the name of this function?
- The expression @math{f(2)} applies the function @math{f} to the number 2. What will it evaluate to? 
- What will the expression @math{f(3)} evaluate to? 
- The values to which we apply a function are called its @vocab{arguments}. How many arguments does @math{f} expect? 

---
# Applying Functions

@vocab{Arguments} (or "inputs") are the values passed into a function. This is different from @vocab{variables}, which are the placeholders that get _replaced_ with input values! Pyret has lots of built-in functions, which we can use to write more interesting programs.

Log into
@ifproglang{pyret}{@link{https://code.pyret.org, "code.pyret.org (CPO)"}}
@ifproglang{wescheme}{@link{https://wescheme.org, WeScheme}}, open the editor and press "Run" to load the image library. 

Then type @show{(code '(sqrt 16))} into the interactions area and hit Enter.

- What is the name of this function? 
- How many arguments does the function expect? 
- What type of argument does the function expect? 
- Does the @show{(code 'sqrt)} function produce a Number? String? Boolean? 
- What did the expression evaluate to?

---
# Applying Functions

Type @show{(code '(string-length "rainbow"))} into the interactions area and hit Enter:

- What is the name of this function? _string-length_
- How many arguments does `string-length` expect? _1_
- What type of argument does the function expect? _String_
- What does the expression evaluate to? _7_
- Does the `string-length` function produce a Number? String? Boolean? _Number_

---
# Applying Functions

Complete @printable-exercise{pages/applying-functions.adoc} 

When you finish, try changing the expression @show{(code '(triangle 50 "solid" "red"))} to use `"outline"` for the second argument. Then try changing colors and sizes!

---
# Applying Functions

- What are the types of the arguments `triangle` was expecting? _A Number and 2 Strings_
- How does the output relate to the inputs? _The Number determines the size and the Strings determine the style and color._
- What kind of value was produced by that expression? _An Image! New data type!_
- Which error messages did you encounter?

---
# Contracts

When you typed @show{(code '(triangle 50 "solid" "red"))}
into the editor, you created an example of a new @vocab{data type}, called an _Image_!

The `triangle` function can make lots of different triangles! The size, style and color are all determined by the specific inputs provided in the code, but, if we don't provide the function with a number and two strings to define those parameters, we will get an error message instead of a triangle.

---
# Contracts

As you can imagine, there are many other functions for making images, each with a different set of arguments. For each of these functions, we need to keep track of three things:

. *Name* -- the name of the function, which we type in whenever we want to use it
. *Domain* -- the type(s) of data we give to the function
. *Range* -- the type of data the function produces

---
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
# Contracts

Let’s take a look at the Name, Domain, and Range of the functions we've seen before:

@table{5}
| **Name** 				|	| **Domain**				|		| **Range**
@ifproglang{wescheme}{
|`;` `+`				| :	| `Number, Number` 			|	->	| `Number`
|`;` `-` 				| :	| `Number, Number` 			|	->	| `Number`
|`;` `/`				| : | `Number, Number`			|	->	| `Number`
|`;` `*`				| : | `Number, Number`			|	->	| `Number`
|`;` `sqr`				| :	| `Number`  				|	->	| `Number`
|`;` `sqrt`				| :	| `Number` 					|	->	| `Number`
|`;` `<`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `>`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `<=`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `>=`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `==`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `<>`				| : | `Number, Number`			|	->	| `Boolean`
|`;` `string-equal?`	| : | `String, String`			|	->	| `Boolean`
|`;` `string-contains?`	| : | `String, String`			|	->	| `Boolean`
|`;` `string-length`	| :	| `String` 					|	->	| `Number`
|`;` `triangle`			| : | `Number, String, String`	|	->	| `Image`
}
@ifproglang{pyret}{
|`#` `num-sqr`			| ::| `Number`  				|	->	| `Number`
|`#` `num-sqrt`			| ::| `Number` 					|	->	| `Number`
|`#` `string-contains`	| ::| `String, String`			|	->	| `Boolean`
|`#` `string-length`	| ::| `String`					|	->	| `Number`
|`#` `triangle`			| ::| `Number, String, String`	|	->	| `Image`
}

---
# Contracts

When the input matches what the function consumes, the function produces the output we expect.

---
# Contracts

Here is an example of another function. @show{(code '(string-append "sun" "shine"))}

Type it into the editor. What is its contract? `string-append {two-colons} String, String -> String`

---
# Contracts

Complete pages @printable-exercise{pages/practicing-contracts.adoc} and @printable-exercise{pages/matching-expressions.adoc} to get some practice working with Contracts.

---
# Contracts

- What is the difference between a value like `17` and a type like `Number`?
- For each expression where a function is given inputs, how many outputs are there? 

---
# Exploring Image Functions

Suppose we had never seen `star` before. How could we figure out how to use it, using the helpful error messages?

- Type `star` into the Interactions Area and hit "Enter". What did you get back? What does that mean? 
- If it's a function, we know that it will need an open parentheses and at least one input. Try @show{(code '(star 50))}
- What error did we get? What _hint_ does it give us about how to use this function? 
- What happens if I don't give it those things?
- If I give `star` what it needs, what do I get in return?
- What is the contract for star? 
- The contract for `square` also has `Number String String` as the Domain and `Image` as the Range. Does that mean the functions are the same? 

<!--
The error messages in this environment are _designed_ to be as student-friendly as possible. Encourage students to read these messages aloud to one another, and ask them what they think the error message _means_. By explicitly drawing their attention to errors, you will be setting them up to be more independent in the next activity!
-->

---
# Exploring Image Functions

- At the back of your workbook, you'll find pages with space to write down a contract and example or other notes for every function you see in this course.  The first few have been completed for you. You will be adding to these contract pages and referring back to them for the remainder of this Bootstrap class!
- Take the next 10 minutes to experiment with the image functions listed in the contracts pages.
- When you've got working expressions, record the contracts and the code!

(If you don't have a workbook, you can use these @opt-printable-exercise{image-contracts.adoc, contracts pages})

---
# Exploring Image Functions

- `square` and `star` have the same Domain _(Number, String, String)_ and Range _(Image)_. Did you find any other shape functions with the same Domain and Range? 
- Does having the same Domain and Range mean that the functions do the same things? 
- A lot of the Domains for shape functions are the same, but some are different. Why did some shape functions need more inputs than others?
- Was it harder to find contracts for some of the functions than others? Why?
- What error messages did you see? 
- How did you figure out what to do after seeing an error message? 
- Which input determined the size of the Rhombus?  What did the other number determine?

---
# Contracts Help Us Write Code

Turn to @printable-exercise{pages/using-contracts.adoc} and @opt-printable-exercise{pages/using-contracts-cont.adoc} and experiment with the functions in the editor.

Once you've discovered how to build a version of each image function that satisfies you, record the example code in your contracts table. S

It may help you to jot down some notes about your discoveries. We will be sharing our findings later.

---
# Contracts Help Us Write Code

- What kind of triangle did `triangle` build? 
- Only one of the inputs was a number. What did that number tell the computer? 
- What other numbers did the computer need to already know in order to build the `triangle` function? 
- If we wanted to build an isosceles triangle or a right triangle, what additional information would the computer need to be given?

---
# Contracts Help Us Write Code

Turn to @printable-exercise{pages/triangle-contracts.adoc} and use the contracts that are provided to write example expressions.

If you are ready to dig into @show{(code 'triangle-sas)}, you can also have students work through @opt-printable-exercise{pages/triangle-contracts-cont.adoc}.

---
# Contracts Help Us Write Code

Sometimes it's helpful to have a contract that tells us more information about the arguments, like what the 3 numbers in a contract stand for. This will not be a focal point of our work, but to get a taste of it, turn to @printable-exercise{pages/radial-star.adoc} and use the contract to help you match the images to the corresponding expressions. 

For more practice with detailed contracts you can turn to  @opt-printable-exercise{pages/star-polygon.adoc} to work with `star-polygon`. 

Both of these functions can generate a wide range of interesting shapes!

---
# Contracts Help Us Write Code

- How was it different to code expressions for the shape functions when you started with a contract?
- For some of you, the word `ellipse` was new. How would you describe what an ellipse looks like to someone who'd never seen one before?  
- Why did the contract for `ellipse` require two numbers? What happened when the two numbers were the same?

---
# Contracts Help Us Write Code

How to diagnose and fix errors is a skill we will continue working on developing. Some of the errors are @vocab{syntax errors}: a missing comma, an unclosed string, etc. 

All the other errors are @vocab{contract errors}. 

If you see an error and you know the syntax is right, ask yourself these three questions:

- What is the function that is generating that error?
- What is the contract for that function?
- Is the function getting what it needs, according to its Domain?

<!-- Common Misconceptions: Students are _very_ likely to randomly experiment, rather than to actually use the Contracts. You should plan to ask lots of direct questions to make sure students are making this connection, such as:

- How many items are in this function's Domain?
- What is the _name_ of the 1st item in this function's Domain?
- What is the _type_ of the 1st item in this function's Domain?
- What is the _type_ of the Range?
-->

---
# Additional Exercises:

@ifproglang{pyret}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90a1937b6430d836b67e7, Matching Images to Code}
}
@ifproglang{wescheme}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fecf203a29e040d182be6c6?collections=5fbecc2b40d7aa0d844956f0, Matching Images to Code}
}


