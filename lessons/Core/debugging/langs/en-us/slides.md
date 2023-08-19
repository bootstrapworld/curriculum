---
{layout="Core Title Slide"}
# Debugging


---
{layout="Launch"}
# Syntax Errors

People often think that computers can't make mistakes, because they are "just machines". But who builds those machines? Who programs them? _Human beings_ are always behind the scenes: writing code, designing chips, and even training Artificial Intelligences! *And humans make mistakes!*

---
{layout="LaunchC"}
# Syntax Errors

In the 1940s, computers were made from large wires, vacuum tubes, gears and dials. In 1946, the legendary programmer Grace Hopper (pictured) had a problem. She was certain that her code was right, but for some reason it wasn't running correctly.{style="font-size:15pt"}


@image{images/hopper.jpg} 

---
{layout="LaunchC"}
# Syntax Errors

She traced the wires and relays, and eventually found a _moth_ that had gotten stuck and electrocuted! By disrupting the parts of the computer, it was causing the program to run incorrectly, and produce unexpected results! She wrote her findings into her notes, and even included the body of the moth. This moth is the origin of the term "bug" in programming. {style="font-size:13pt"}


@image{images/bug.jpg} 

---
{layout="Launch"}
# Syntax Errors

Knowing how to find and fix bugs is a valuable skill for any programmer, and the kind of logical thinking you gain by fixing errors can help you find mistakes _outside_ of a program as well!

When you Run a program, you expect the computer to do three things: 
- Read the code
- Run the code
- Give you the result you expected

In this lesson, we'll be talking about different kinds of mistakes, which can happen in each of those three phases: syntax errors, contract errors, and logic errors. 

<!--
- @vocab{Syntax Errors} - Invalid code that the computer cannot even _read_, resulting in an error message.   Syntax errors are are often typos, missing characters like a semicolon or parenthesis, or missing keywords like @ifproglang{wescheme}{`define`} @ifproglang{pyret}{`fun` or `end`}.
- @vocab{Contract Errors} - Code that produces a value that breaks a function's Contract, preventing the computer from _running_ the program any further. Like syntax errors, contract errors will also result in an error message.    Contract errors -  For example, @ifproglang{pyret}{`circle("hello", "solid", "red"))`} @ifproglang{wescheme}{`(circle "hello" "solid" "red")`} has no syntax errors. However, the Contract for circle is `circle :: Number, String, String -> Image` so the  the `circle` function is expecting a Number for it's first argument and "hello" is a String! 
- @vocab{Logic Errors} - Logic errors are often the hardest ones to find, because there is no error message! When there's a logic error in the code, the computer reads and runs the code just fine...but the result isn't what the programmer expected!

-->

---
{layout="Investigate"}
# Syntax Errors

Here are a few simple examples of syntax errors - can you find the problem?

- `"hello`
- @ifproglang{pyret}{`1+2`} @ifproglang{wescheme}{`(+ 1 2`}



---
{layout="Investigate-DN"}
# Syntax Errors 

Syntax Errors prevent the computer from _reading_ code.

- In pairs or small groups, complete @printable-exercise{syntax-errors.adoc}. 
- For each piece of code, be sure to discuss as a team before deciding on the mistake.


---
{layout="Synthesize"}
# Syntax Errors

- Which syntax errors were the easiest to find? The hardest?
- Which error messages were the most helpful? Least helpful?
- Which syntax errors do _you_ make the most often?
- What strategies could we use to avoid making them in the first place?
- What strategies could we use to fix them faster?

@teacher{Have students share back their findings. Leave time for discussion! The key here is to have students reflect on how useful it is to _read the error messages_ first, even the few errors that may not be as helpful as the others.}

---
{layout="Launch"}
# Contract Errors 

With no syntax errors, the computer can read our code and try to run it. But a running program can still have problems! Here are a few examples of programs that have perfect syntax, but will generate an error when we try to run them. Can you spot the problem?

@show{(code '(+ 1 "Zari"))}

@show{(code '(triangle "50" "solid" "blue"))}

@show{(code '(or "true" false))}

---
{layout="Investigate-DN"}
# Contract Errors

Contract Errors prevent the computer from _running_ code. A program might be running along just fine, but as soon as a function is given the wrong type of value, the program halts with an error!

- In pairs or small groups, complete @printable-exercise{contract-errors.adoc}. 
- For each piece of code, be sure to discuss as a team before deciding on the mistake.

---
{layout="Synthesize"}
# Contract Errors 

- Which Contract errors were the easiest to find? The hardest?
- Which error messages were the most helpful? Least helpful?
- Which Contract errors do _you_ make the most often?
- What strategies could we use to avoid making them in the first place?
- What strategies could we use to fix them faster?

---
{layout="Launch"}
# Logic Errors

Ho-ming wanted to write a function to produce green triangles, and she went straight to coding the definition:

@show{(code '(define (gt size) (triangle 100 "solid" "green")))}

She clicked "Run" and didn't get any syntax errors, so she was feeling really confident. When she typed @show{(code '(gt 100))} she got a solid green triangle of size 100, and she was thrilled! But when she tried to make triangles of _different_ sizes, her heart broke: all of the triangles were of size 100!

Did she have a syntax error? Why or why not?
Did she have a Contract error? Why or why not?

---
{layout="Launch"}
# Logic Errors

Ho-ming's mistake was that the function `gt` always made triangles of size 100! It took in `size` as a variable, but then didn't use it all. The computer had no trouble reading her code, and she followed the Contract for `triangle`. _As far as the computer is concerned, there's nothing wrong with her code!_

_Logic Errors don't prevent code from running at all!_

Ho-ming's computer had no trouble reading or running her code. The problem is that the code didn't work the way she expected. Another way to think of it is that the bug isn't in the code at all - _it's in the way she was thinking when she wrote it._

---
{layout="Launch"}
# Logic Errors

Logic Errors occur in our brains, not on the computer!

The only way to prevent logic errors - or to fix them when they happen! - is to be disciplined about the way we program. By thinking through a problem in multiple ways, we are less likely to make a mistake. 

What are some other ways Ho-ming could have thought through this function?

<!--
- *She could have written the Contract*, which might have put more emphasis on the input.
- *She could have written a Purpose Statement*, which would have forced her to talk about what happens to that input.
- *She could have written Examples*, which would have helped her see how the input is used. And even if she made the exact same mistake, at least her examples would have generated a warning to alert her to the problem!
-->

---
{layout="Investigate-DN"}
# Logic Errors

The Design Recipe helps us avoid logic errors, by demanding that we think through a problem in multiple ways. Even if _one_ of our steps is wrong, we can check our work by comparing it to the other steps.

- In pairs or small groups, complete @printable-exercise{pages/logic-errors.adoc},  @printable-exercise{pages/logic-errors-2.adoc}, and @printable-exercise{pages/logic-errors-3.adoc}.
- In pairs or small groups, open the @starter-file{bug-hunting}, and see if you can fix all of the syntax errors in the file by completing @printable-exercise{pages/what-kind-of-error.adoc}

---
{layout="Synthesize"}
# Logic Errors

Logic Errors happen in the programmer's mind, _not_ in the code. The best way to help prevent them is to think things through completely!

- Did you find any logic errors that you've made in the past?
- What can you do in your own programming, to minimize the chances of logic errors?

