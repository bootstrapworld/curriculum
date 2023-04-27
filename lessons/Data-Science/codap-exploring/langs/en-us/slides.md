---
{layout="DS Title Slide"} 
# Exploring CODAP 

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Strings & Numbers 

When programming in this class, you'll be working together using the Driver/Navigator model.{style="font-size:16pt"} 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. {style="font-size:16pt"} 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.{style="font-size:16pt"} 

@image{images/driver-navigator.png, 150}


---
{layout="Launch-DN"}
# Strings & Numbers

- Open the @starter-file{animals} in CODAP.
- Explore this data - and CODAP! - by following the instructions and recording your observations on @printable-exercise{codap-exploration.adoc}.
- What did you Notice? What do you Wonder?
- Did you encounter any difficulties?

<!--
Possible challenges: the grey plus sign does not appear unless a table or table row is selected; the button that minimizes doesn't appear unless the table's title is selected; and, the same button that minimizes also expands.
-->

---
{layout="Launch"}
# Strings & Numbers

We are going to explore two basic data types: 

- @vocab{Numbers} - a data type representing real numbers

- @vocab{Strings} - a data type for any sequence of characters between quotation marks.


---
{layout="Investigate-DN"}
# Strings & Numbers

- Turn to @printable-exercise{strings-n-numbers.adoc}.
- Open the @starter-file{strings-n-numbers}.

---
{layout="Investigate2"}
# Strings & Numbers


Start with Table A. One by one, working from left to right, follow the directives at the top of each column. *In order to follow the directives, you must first click the column name, and then choose "Edit Formula" from the drop-down menu that appears. You will be typing into the "Edit Formula" box.*{style="font-size:14pt"}


@image{images/drop-down.png}
@image{images/type-your-name.png}


<!--
** _The Synthesize section (to follow) outlines several of CODAP's features that students likely observed._
** _Most of the error messages we've just seen were drawing our attention to @vocab{syntax errors}: missing commas, unclosed strings, etc._
-->

---
{layout="Investigate"}
# Strings & Numbers

- What did you Notice? What do you Wonder?
- Did you get any error messages? What did you learn from them? 

<!-- 
- What did you Notice? What do you Wonder _The Synthesize section (below) outlines several of CODAP's features that students likely observed._
- Did you get any error messages? What did you learn from them? _Most of the error messages we've just seen were drawing our attention to @vocab{syntax errors}: Missing commas, unclosed strings, etc._
-->

---
{layout="Synthesize"}
# Strings & Numbers

CODAP knows about many kinds of Numbers (like Integers, Reals, etc), and they behave pretty much the way they do in math. Discuss what students have learned:

- Numbers and Strings evaluate to themselves.
- CODAP converts fractions into decimals automatically.
- Anything in quotes is a String, with one exception: CODAP will convert strings containing only Numbers (e.g. “42” but not “42 hello”) into Number values.


<!--Error messages are a way for CODAP to explain what went wrong, and are a helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help.
-->

---
{layout="Synthesize"}
# Strings & Numbers

CODAP knows about many kinds of Numbers, and they behave pretty much the way they do in math. 

- Strings _must_ have quotation marks on both sides.
- Operators work just like they do in math - with a few exceptions. The `+`, for instance, will join together two strings, or a Number and a String.
- CODAP follows the standard order of operations.


---
{layout="Launch"}
# Booleans 

What's the answer: is 3 greater than 10?

---
{layout="LaunchR"}
# Booleans

Boolean-producing expressions are yes-or-no questions and will always evaluate to either `true` (“yes”) or `false` (“no”).  The ability to separate inputs into two categories is unique and quite useful!{style="font-size:15pt"} 

For example, some roller coasters with loops require passengers to be a minimum height to make sure that riders are safely held in place by the one-size-fits all harnesses. The gatekeeper doesn't care exactly how tall you are, they just check whether you are as tall as the mark on the pole. If you are, you can ride, but they don't let people on the ride who are shorter than the mark because they can't keep them safe. {style="font-size:15pt"}  

@image{images/at-least-this-tall-to-ride.jpeg}

--- 
{layout="LaunchR"}
# Booleans

Similarly, when you log into your email, the computer asks for your password and checks whether it matches what's on file. If the match is `true` it takes you to your messages, but, if what you enter doesn't match, you get an error message instead.

Brainstorm other scenarios where Booleans are useful in and out of the programming environment.

@image{images/login.png}

---
{layout="Investigate-DN"}
# Booleans


- Turn to @printable-exercise{pages/booleans.adoc}.
- Write down your predictions before testing them in CODAP. When you're ready, test the Boolean expression in @starter-file{boolean}. 
- You will work from left to right, clicking on the column name, and then choosing "Edit Formula" from the drop-down menu that appears. You will type each Boolean into the "Edit Formula" box.


---
{layout="Synthesize"}
# Booleans

What sets Booleans apart from other data types?


---
{layout="Launch"}
# Expressions and Functions

You know about Numbers, Strings, Booleans and Operators, all of which behave like they do in math. 

But what about expressions? 

You may remember expressions from algebra: @math{x + 1}.

- Turn to @printable-exercise{pages/codap-apply-functions.adoc}.
- Complete the table, calculating pounds doubled.

---
{layout="Investigate"}
# Expressions and Functions

By using CODAP, we can evaluate expressions much more quickly and efficiently than we might with paper and pencil. Rather than evaluating in our heads, we will provide CODAP with a formula so that CODAP can do the math!



---
{layout="Investigate-DN"}
# Expressions and Functions

- With your partner, open the @starter-file{animals} and use it to finish questions 1 and 2 on @printable-exercise{pages/codap-apply-functions.adoc}.
- For question 3, consider other scenarios where it would be useful to enter an expression or function as the formula for an attribute.

---
{layout="Investigate"}
# Expressions and Functions

CODAP also allows us to insert _functions_ into the formula box! *Arguments* (or "inputs") are the values passed into the function. CODAP has lots of @link{https://codap.concord.org/help/functions, built-in functions} that we can use to play with our dataset.


---
{layout="Investigate-DN"}
# Expressions and Functions

- With your partner, complete @printable-exercise{pages/codap-apply-functions.adoc}.
- What did you learn about the function `sqrt`?

---
{layout="Synthesize"}
# Expressions

- Think about the new columns you created. How did the inputs relate to the outputs?
- Did you encounter any new functions that intrigued you?
- What kind of error messages did you encounter, if any?
