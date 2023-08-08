---
{layout="Math Title Slide"}
# Order of Operations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="Launch"}
# Order of Operations

If you were to write instructions for getting ready for school, it would matter very much which instruction came first: putting on your socks, putting on your shoes, etc. 

Sometimes we need multiple expressions in mathematics, and the order matters there, too!

---
{layout="LaunchR"}
# Order of Operations

Mathematicians didn’t always agree on the order of operations, but at some point it became important to develop rules to help them work together.

@image{images/pemdas.png, 300}

---
{layout="Launch"}
# Order of Operations

__@math{6 \div 2(1 + 2)}__{style="font-size:46pt"}

Instead of using a rule for computing answers, let's start by diagramming the math itself!

---
{layout="LaunchR"}
# Order of Operations

*Circles of Evaluation* allow us to draw the structure of mathematics. The rules are simple:{style="font-size:15pt"}

__Rule #1:__ Every Circle must have one - and only one! - function written at the top.

__Rule #2:__ The inputs to the function are written left-to-right, in the middle of the Circle.

__Rule #3:__ Circles can contain other circles. 

@show{(coe '(/ 6 3))}

<!--
In this example, the function is division and the inputs are 6 and 3 (in that order!.
Math teachers: you may be used to calling division an *operator*, but operators are
all just functions that we write a little differently! 
-->
---
{layout="LaunchC"}
# Order of Operations

What if we want to use multiple functions?  

What is the Circle of Evaluation for @smath{(/ 6 (+ 1 2))}?

---
{layout="LaunchC"}
# Order of Operations

Circles can contain other Circles. We basically replace the `3` from our earlier Circle of Evaluation with _another_ Circle, which adds 1 and 2!{style="font-size:15pt"}

@show{(coe '(/ 6 (+ 1 2)))}

---
{layout="Launch"}
# Order of Operations

What would the Circle of Evaluation for @math{5 \times 6} look like?

---
{layout="LaunchC"}
# Order of Operations

What would the Circle of Evaluation for @math{5 \times 6} look like?

@show{(coe '(* 5 6))}

---
{layout="LaunchC"}
# Order of Operations

How about the Circle of Evaluation for:

 @math{(10 - 5) \times 6}

---
{layout="LaunchC"}
# Order of Operations

How about the Circle of Evaluation for @math{(10 - 5) \times 6}?

@show{(coe '(* (- 10 5) 6))}

---
{layout="InvestigateC"}
# Order of Operations

Turn to  @printable-exercise{pages/translate-arithmetic-to-coe-and-code-1-intro-w-parenth.adoc} and draw Circles of Evaluation for each of the expressions. 

Ignore the code column for now! We will come back to it later.

---
{layout="Investigate"}
# Order of Operations

For more practice with this, turn to:
- @printable-exercise{pages/complete-coe-from-arith.adoc}
- @printable-exercise{pages/match-arith-coe.adoc}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc980e05de8ae2e71174aeb?collections=5fbecc2b40d7aa0d844956f0, Matching Circles of Evaluation to Expressions}

---
{layout="Launch"}
# From Circles of Evaluation to Code

When converting a Circle of Evaluation to code, it's useful to imagine a spider crawling through the circle from the left and exiting on the right. 

The first thing the spider does is cross over a curved line - an open parenthesis - then visit the function @ifproglang{pyret}{ or operation} at the top. 

After that, she crawls from left to right, visiting each of the inputs. Finally, she has to leave the circle by crossing another curved line (a close parenthesis).

---
{layout="InvestigateC"}
# From Circles of Evaluation to Code

@image{images/coe-set1.png}


---
{layout="Investigate"}
# From Circles of Evaluation to Code

Arithmetic expressions involving more than one operation will end up with more than one circle,  @ifproglang{wescheme}{and more than one pair of parentheses.}@ifproglang{pyret}{and the code requires parentheses to clarify the order in which the operations should be completed - whether or not there are parentheses in the original expression.}

---
{layout="InvestigateC"}
# From Circles of Evaluation to Code


What would the code look like for this circle?

@show{(coe '(* 2 (+ 3 8)))}

<!-- 
advance to next slide to reveal the answer
@show{(code '(* 2 (+ 3 8)))}
-->

---
{layout="InvestigateC"}
# From Circles of Evaluation to Code

@image{images/coe-set2.png}

---
{layout="InvestigateC"}
# From Circles of Evaluation to Code

What would the code look like for this circle?

@show{(coe '(/ 6 (+ 1 2)))}

<!-- 
@show{(code '(/ 6 (+ 1 2)))}
-->


---
{layout="InvestigateC"}
# From Circles of Evaluation to Code

What would the code look like for this circle?

@show{(coe '(* (- 10 5) 6))}

<!-- 
@show{(code '(* (- 10 5) 6))}
-->

---
{layout="Investigate"}
# From Circles of Evaluation to Code

Scaffolded practice: 

- @printable-exercise{pages/complete-code-from-coe.adoc} 
- @printable-exercise{pages/match-coe-to-code.adoc}

---
{layout="Investigate"}
# From Circles of Evaluation to Code

Now that we know how to translate Circles of Evaluation into Code, turn back to @printable-exercise{pages/translate-arithmetic-to-coe-and-code-1-intro-w-parenth.adoc}.

Once you confirm that your code is correct, continue on to @printable-exercise{pages/translate-arithmetic-to-coe-and-code-2-outro.adoc}

Challenge:  @printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge.adoc}

---
{layout="Synthesize"}
# From Circles of Evaluation to Code

What did you learn from Circles of Evaluation?

@ifproglang{pyret}{
As in math, in Pyret there are some cases where the outermost parentheses can be removed:

- @math{(1 + 2)} can be safely written as @math{1 + 2}, and the same goes for the Pyret code
- @math{(1 * 2) * 3)} can be safely written as @math{1 * 2 * 3}, and the same goes for the Pyret code

It is always better to at least start with the parentheses before taking them out. **It is never wrong to include them!**
}

---
{layout="Launch-DN"}
# Testing out your Code

- Open @starter-file{editor} and click run.
- For now, we'll work in the Interactions Area on the right.
- Type @show{(code '(+ (* 8 2) (/ 6 3)))} 
- Notice how the editor __highlights pairs of parentheses__!
- Hit Enter (or Return) to evaluate this expression. What happens?
- Test each line of code you wrote by typing them into the Interactions Area. Use the error messages to edit your code to get it working.

---
{layout="InvestigateC-DN"}
# Testing out your Code

Look at the two Circles of Evaluation below. One of them is familiar, but the other is very different!{style="font-size:15pt"}

- What's different about the Circle on the right?{style="font-size:15pt"}
- Can you figure out the Name for the function in the second Circle?{style="font-size:15pt"}
- What do you think this expression will evaluate to?{style="font-size:15pt"}
- Convert this Circle to code and try it out!{style="font-size:15pt"}

@image{images/coe-pair.png}

<!--
Possible responses: 
- _We've never seen the function `text` before_
- _We've never seen words used in a Circle of Evaluation before_
- _We've never seen a function take in three inputs_
- _We've never seen a function take in a mix of Numbers and words_
-->

@ifproglang{pyret}{
---
{layout="InvestigateC-DN"}
# Testing out your Code

@image{images/coe-pair.png}

There's more than just operators like addition and subtraction! Math also has _functions_, and so does Pyret! In math, the name of the function comes first, and Pyret is no different.

When converting a Circle of Evaluation that has a function, the spider starts at the **top** and visits the function, then visits the inputs from left-to-right. The `text` Circle would be: 

@show{(code  '(text "Good work!" 50 "red"))}
}

---
{layout="InvestigateC-DN"}
# Testing out your Code

Here is another circle to explore.{style="font-size:16pt"}

- What do you think this expression will evaluate to? {style="font-size:16pt"}
- Convert this Circle to code and try it out!{style="font-size:16pt"}

@show{(coe '(string-length "fun!"))}

---
{layout="Supplemental"}
# Additional Practice

@optional If you're digging into Order or Operations and want more practice with Circles of Evaluation before introducing code, we have lots of practice pages! {style="font-size:16pt"}

* @opt-printable-exercise{pages/matching-coe-exp.adoc, A printable set of cards for physically matching expressions with Circles of Evaluation}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/arith-to-coe.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/arith-to-coe2.adoc}{style="font-size:16pt"}
* @opt-printable-exercise{pages/arith-to-coe3.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/coe-to-arith.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/coe-to-arith2.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/evaluate-coe.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/evaluate-coe2.adoc}{style="font-size:16pt"} 

---
{layout="Supplemental"}
# Additional Practice

@optional More practice connecting Circles of Evaluation to Code {style="font-size:16pt"}

* @opt-printable-exercise{pages/coe-to-code.adoc} {style="font-size:16pt"}
* @opt-printable-exercise{pages/coe-to-code2.adoc} {style="font-size:16pt"}

More 3-column practice connecting Arithmetic Expressions with Circles of Evaluation and Code: {style="font-size:16pt"} 

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-3.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-4.adoc}{style="font-size:16pt"}

---
{layout="Supplemental"}
# Additional Practice

More 3-column practice with negatives:{style="font-size:16pt"} 

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-5.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-6.adoc}{style="font-size:16pt"} 

More 3-column practice with square roots:{style="font-size:16pt"}

* @opt-printable-exercise{pages/translate-coe-to-code-w-sqrts.adoc}{style="font-size:16pt"} 

3-column challenge problems with brackets and exponents:{style="font-size:16pt"} 

* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-2.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-3.adoc}{style="font-size:16pt"} 
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-4.adoc}{style="font-size:16pt"} 
