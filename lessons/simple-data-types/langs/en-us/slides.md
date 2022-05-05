---

# Simple Data Types

---

# Numbers & Strings 

@image{images/driver-navigator.png, "Driver/Navigator icon", 150, ""}}

{.column}

When programming in this class, you'll be working together using the _Driver/Navigator_ model. 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.

---

# Numbers & Strings

@ifproglang{wescheme}{
Open @link{https://www.wescheme.org, WeScheme} and click "Log In". 

It will ask you to log in with a valid Google account (Gmail, Google Classroom, YouTube, etc.), and then show you the "My Programs" page. This page is empty - you don't have any programs yet! 

Click "Start a New Program".
}

@ifproglang{pyret}{
Open @link{https://code.Pyret.org, code.pyret.org (CPO) } and click "Sign In". 

It will ask you to log in with a valid Google account (Gmail, Google Classroom, YouTube, etc.), and then show you the "Programs" page. This page is empty - you don't have any programs yet! 

Click "Open Editor".
}

---

# Numbers & Strings

@image{images/editor.png, "Our Editing Environment with the Definitions are on the left and the Interactions Area on the right", 300, ""}}

{.column}

This screen is called the @vocab{Editor}, and it looks something like the diagram you see here. There are a few buttons at the top, but most of the screen is taken up by two large boxes: the @vocab{Definitions Area} on the left and the @vocab{Interactions Area} on the right.

The @vocab{Definitions Area} is where programmers define values and functions that they want to keep, while the @vocab{Interactions Area} allows them to experiment with those values and functions. This is like writing function definitions on a blackboard, and having students use those functions to compute answers on scrap paper.

For now, we will only be writing programs in the *Interactions Area* on the right.

---

# Numbers & Strings

Math and programming are languages. They have *values*, like the numbers 1, 2 and 3. And, instead of verbs, they have functions, which are actions we can perform on values (e.g. - “I can square a number”).

Languages also have rules for *syntax*. In English, for example, words don’t have `!` and `?` in the middle. In math and programming numbers don’t have `&` in them.

Languages also have rules for *grammar*. The order of the words matters!

Keeping the importance of *syntax* and *grammar* in mind is helpful when learning to program!.

Complete @printable-exercise{numbers-n-strings.adoc}. Pay special attention to the error messages!

---

# Numbers & Strings

- What did you Notice? What do you Wonder?
- Did you get any error messages? 
- What did you learn from them? 

<!--
Most of the error messages we've just seen were drawing our attention to syntax errors: Missing commas, unclosed strings, etc.

Common Misconceptions: In Pyret, writing decimals as `.5` (without the leading zero) results in a syntax error. Make sure students understand that Pyret needs decimals to start with a zero!}. 
 -->

---

# Numbers & Strings

We have learned that in our programming language:

- Numbers and Strings evaluate to themselves.
- Our Editor is pretty smart, and can automatically switch between showing a rational number as a fraction or a decimal, just by clicking on it!
- Anything in quotes is a String, even something like `"42"`.
- Strings _must_ have quotation marks on both sides.

@ifproglang{pyret}{
- @vocab{Operators} like `+`, `-`, `*`, and `/` need spaces around them.
- In pyret, the @vocab{operators} work just like they do in math.
- Any time there is more than one operator being used, Pyret requires that you use parentheses to define the order of operations.
- Types matter! We can add two Numbers or two Strings to one another, but we can’t add the Number `4` to the String `"hello"`.

Error messages are a way for Pyret to explain what went wrong, and are a really helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help. Have students see the following errors:

- `6 / 0`. In this case, Pyret obeys the same rules as humans, and gives an error.
- `(2 + 2`. An unclosed quotation mark is a problem, and so is an unmatched parentheses.
}

---
# Booleans 

What's the answer: is 3 greater than 10?

---
# Booleans

Boolean-producing expressions are yes-or-no questions and will always evaluate to either `true` (“yes”) or `false` (“no”).  The ability to separate inputs into two categories is unique and quite useful!

For example, some rollercoasters with loops require passengers to be a minimum height to make sure that riders are safely held in place by the one-size-fits all harnesses. The gate keeper doesn't care exactly how tall you are, they just check whether you are as tall as the mark on the pole. If you are, you can ride, but they don't let people on the ride who are shorter than the mark because they can't keep them safe.  
{.column}

@image{images/roller-coaster.png, a}

--- 
# Booleans

Similarly, when you log into your email, the computer asks for your password and checks whether it matches what's on file. If the match is `true` it takes you to your messages, but, if what you enter doesn't match, you get an error message instead.

{.column}

@image{images/login.png, a}

---
# Booleans

Brainstorm other scenarios where Booleans are useful in and out of the programming environment.

---
# Booleans

Complete @printable-exercise{pages/booleans.adoc} with your partner, making predictions about what a variety of Boolean expressions will return and testing them in the editor.

---
# Booleans

What sets Booleans apart from other data types?
