---
{layout="DS Title Slide"} 
# Exploring CODAP 

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Numbers & Strings 

When programming in this class, you'll be working together using the Driver/Navigator model.{style="font-size:16pt"} 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. {style="font-size:16pt"} 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.{style="font-size:16pt"} 

@image{images/driver-navigator.png, 150}


---
{layout="Launch-DN"}
# Numbers & Strings

- Open the @starter-file{animals} in CODAP.
- Play around in our new platform! Record your observations on @printable-exercise{codap-exploration.adoc}.
- What did you Notice? What do you Wonder?

---
{layout="LaunchC}
# Numbers & Strings

Did you create a blank column titled `test`? To do so, select the grey plus sign (`+`) in the upper right-hand corner of the Animals Table. 

@image{images/grey-plus-sign.png}

---
{layout="LaunchC"}
# Numbers & Strings

In the next activity, you will click on the `test` cell in the header of your table, and then choose `Edit formula` from the resulting drop-down menu.

@image{images/edit-formula.png}

---
{layout="LaunchC"}
# Numbers & Strings

As you complete each directive, you will re-open `Edit Formula` (below), delete your previous entry and then input the next entry.

@image{images/edit-formula-box.png}

---
{layout="Investigate"}
# Numbers & Strings

- Complete @printable-exercise{numbers-n-strings.adoc}.
- What did you Notice? What do you Wonder?
- Did you get any error messages? What did you learn from them? 

<!-- 
- What did you Notice? What do you Wonder _The Synthesize section (below) outlines several of CODAP's features that students likely observed._
- Did you get any error messages? What did you learn from them? _Most of the error messages we've just seen were drawing our attention to @vocab{syntax errors}: Missing commas, unclosed strings, etc._
-->

---
{layout="Synthesize"}
# Numbers & Strings

CODAP knows about many kinds of Numbers, and they behave pretty much the way they do in math. 

- Numbers and Strings evaluate to themselves.
- CODAP converts fractions into decimals automatically.
- Anything in quotes is a String, with one exception: CODAP will convert strings containing only numbers (e.g. “42” but not “42 hello”) into number values.
- Strings _must_ have quotation marks on both sides.


<!--Error messages are a way for CODAP to explain what went wrong, and are a helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help.
-->

---
{layout="Synthesize"}
# Numbers & Strings

CODAP knows about many kinds of Numbers, and they behave pretty much the way they do in math. 

- Strings _must_ have quotation marks on both sides.
- Operators work just like they do in math - with a few exceptions. 
- CODAP knows the order of operations.
- Types matter! We can subtract one number from another, but we can't subtract the Number `4` from the String `"hello"`.

---
{layout="Launch"}
# Booleans 

What's the answer: is 3 greater than 10?

---
{layout="LaunchR"}
# Booleans

Boolean-producing expressions are yes-or-no questions and will always evaluate to either `true` (“yes”) or `false` (“no”).  The ability to separate inputs into two categories is unique and quite useful!{style="font-size:15pt"} 

For example, some roller coasters with loops require passengers to be a minimum height to make sure that riders are safely held in place by the one-size-fits all harnesses. The gatekeeper doesn't care exactly how tall you are, they just check whether you are as tall as the mark on the pole. If you are, you can ride, but they don't let people on the ride who are shorter than the mark because they can't keep them safe. {style="font-size:15pt"}  

@image{images/roller-coaster.png}

--- 
{layout="LaunchR"}
# Booleans

Similarly, when you log into your email, the computer asks for your password and checks whether it matches what's on file. If the match is `true` it takes you to your messages, but, if what you enter doesn't match, you get an error message instead.

Brainstorm other scenarios where Booleans are useful in and out of the programming environment.

@image{images/login.png}

---
{layout="Investigate-DN"}
# Booleans

Complete @printable-exercise{pages/booleans.adoc} with your partner, making predictions about what a variety of Boolean expressions will return and testing them in the editor.

---
{layout="Synthesize"}
# Booleans

What sets Booleans apart from other data types?


---
{layout="Launch"}
# Expressions and Functions

- Turn to @printable-exercise{pages/codap-apply-functions.adoc}.
- Let's complete the first table together, with pencil and paper.
- You complete the second table on your own.

---
{layout="Launch-DN"}
# Expressions and Functions

 By using CODAP, we can evaluate expressions much more quickly and efficiently. Rather than evaluating in our heads, we will provide CODAP with a formula so that CODAP can do the math!

- With your partner, open the @starter-file{animals} and use it to finish questions 1 and 2 on @printable-exercise{pages/codap-apply-functions.adoc}.
- Note that attribute names that are more than one word need to be entered inside of tick marks.

---
{layout="Launch-DN"}
# Expressions and Functions

CODAP also allows us to insert _functions_ into the formula box! *Arguments* (or "inputs") are the values passed into the function. CODAP has lots of @link{https://codap.concord.org/help/functions, built-in functions} that we can use to play with our dataset.

- With your partner, complete @printable-exercise{pages/codap-apply-functions.adoc}.
- What did you learn about the two functions `sqrt` and `stringLength`?

---
{layout="Synthesize"}
# Expressions

- Think about the new columns you created. How did the inputs relate to the outputs?
- Did you encounter any new functions that intrigued you?
- What kind of error messages did you encounter, if any?
