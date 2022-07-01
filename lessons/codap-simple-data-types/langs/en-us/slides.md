---
{layout="Core Title Slide"} 
# Simple Data Types 

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="LaunchR"}
# Numbers & Strings 

When programming in this class, you'll be working together using the Driver/Navigator model.{style="font-size:16pt"} 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. {style="font-size:16pt"} 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.{style="font-size:16pt"} 

@image{images/driver-navigator.png, "Driver/Navigator icon", 150, ""}


---
{layout="Launch-DN"}
# Numbers & Strings

- Play around in CODAP, guided by @printable-exercise{codap-experimentation.adoc}.
- What did you Notice? What do you Wonder?

<!--
Debrief with students, then ensure that they all have created a blank column titled `test`. They can do so by selecting the grey plus sign (`+`) in the upper right-hand corner of the Animals Table. *NEED SCREENSHOT*
-->

---
{layout="Investigate"}
# Numbers & Strings

- Complete @printable-exercise{numbers-n-strings.adoc}.
- What did you Notice? What do you Wonder?
- Did you get any error messages? What did you learn from them? 

<!--
In their `test` column, students will experiment with _Numbers_ and _Strings_. In order to complete the worksheet below, students must click on the `test` cell in the header of their Table, and then choose `Edit formula` from the resulting drop-down menu. As they complete each directive, they will re-open `Edit Formula`, delete their previous entry and then input the next entry. *NEED SCREENSHOT*
-->

---
{layout="Synthesize"}
# Numbers & Strings

CODAP knows about many kinds of Numbers, and they behave pretty much the way they do in math. 

- Numbers and Strings evaluate to themselves.
- CODAP converts fractions into decimals automatically.
- Anything in quotes is a String, even something like `"42"`.
- Strings _must_ have quotation marks on both sides.
- Operators work just like they do in math - with a few exceptions. 
- CODAP knows the order of operations.
- Types matter! We can subtract one number from another, but we can't subtract the Number `4` from the String `"hello"`.


<!--Error messages are a way for CODAP to explain what went wrong, and are a helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help.
-->

---
{layout="Investigate"}
# Numbers & Strings

- What did you Notice? 

- What do you Wonder?

- Did you get any error messages? 

- What did you learn from them? 

<!--
Most of the error messages we've just seen were drawing our attention to syntax errors: Missing commas, unclosed strings, etc.

Common Misconceptions: In Pyret, writing decimals as `.5` (without the leading zero) results in a syntax error. Make sure students understand that Pyret needs decimals to start with a zero!}. 
-->


---
{layout="Launch"}
# Booleans 

What's the answer: is 3 greater than 10?

---
{layout="LaunchR"}
# Booleans

Boolean-producing expressions are yes-or-no questions and will always evaluate to either `true` (“yes”) or `false` (“no”).  The ability to separate inputs into two categories is unique and quite useful!{style="font-size:15pt"} 

For example, some roller coasters with loops require passengers to be a minimum height to make sure that riders are safely held in place by the one-size-fits all harnesses. The gatekeeper doesn't care exactly how tall you are, they just check whether you are as tall as the mark on the pole. If you are, you can ride, but they don't let people on the ride who are shorter than the mark because they can't keep them safe. {style="font-size:15pt"}  

@image{images/roller-coaster.png, a}

--- 
{layout="LaunchR"}
# Booleans

Similarly, when you log into your email, the computer asks for your password and checks whether it matches what's on file. If the match is `true` it takes you to your messages, but, if what you enter doesn't match, you get an error message instead.

Brainstorm other scenarios where Booleans are useful in and out of the programming environment.

@image{images/login.png, a}

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
# Expressions

- If @math{x = 2}, what will the expression @math{x + 4} evaluate to? What if @math{x = 20}?
- The values we plug in are the expressions @vocab{arguments}. How many arguments does @math{x + 4} expect?


<!--
Students know about Numbers, Strings, Booleans and Operators -- all of which behave just like they do in math. But what about expressions? Students may remember expressions from algebra: @math{x + 4}.
-->

---
{layout="Launch-DN"}
# Expressions

Complete @printable-exercise{pages/codap-expressions.adoc}.

---
{layout="Investigate"}
# Expressions

- Create a column called `age-next-year` that uses an expression to add one year to each animal’s age.
- Create a column called `rounded-weight` that uses an expression to give the weight of each animal rounded to the nearest whole number.
- Create a column called `old` that uses an expression to indicate which animals are  over 5 years old.

---
{layout="Synthesize"}
# Expressions

- Think about the new columns you created using expression. How did the input of the expression relate to the output?
- What kind of error messages did you encounter, if any?
