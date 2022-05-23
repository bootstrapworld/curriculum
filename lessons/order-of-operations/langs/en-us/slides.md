---
{layout="Math Title Slide"}

# Order of Operations

---
{layout="Launch"}
# Order of Operations

If you were to write instructions for getting ready for school, it would matter very much which instruction came first: putting on your socks, putting on your shoes, etc. 

Sometimes we need multiple expressions in mathematics, and the order matters there, too!

---
{layout="LaunchR"}
# Order of Operations

Mathematicians didn’t always agree on the order of operations, but at some point it became important to develop rules to help them work together.

@image{images/pemdas.png, "pmedas pyramid", 300, ""}

---
{layout="Launch"}
# Order of Operations

@math{6 \div 2(1 + 2)}{font-size:36pt}

Instead of using a rule for computing answers, let's start by diagramming the math itself!

---
{layout="LaunchR"}
# Order of Operations

*Circles of Evaluation* allow us to draw the structure of mathematics. The rules are simple:{style="font-size:15pt"}

__Rule #1:__ Every Circle must have one - and only one! - operator written at the top.

__Rule #2:__ The inputs to the function are written left-to-right, in the middle of the Circle.

__Rule #3:__ Circles can contain other circles. 

@image{images/coe1.png, "circle of evaluation for 6 / 3"}

---
{layout="Launch"}
# Order of Operations

What if we want to use multiple functions?  

How would we draw the Circle of Evaluation for @smath{(/ 6 (+ 1 2))}?

---
{layout="Launch"}
# Order of Operations

Circles can contain other Circles. We basically replace the `3` from our earlier Circle of Evaluation with _another_ Circle, which adds 1 and 2!{style="font-size:15pt"}

@image{images/coe2.png, a}{width="200"}	

---
{layout="Launch"}
# Order of Operations

What would the Circle of Evaluation for @math{5 \times 6} look like?

---
{layout="Launch"}
# Order of Operations

What would the Circle of Evaluation for @math{5 \times 6} look like?

@image{images/coe3.png, a}

---
{layout="Launch"}
# Order of Operations

How about the Circle of Evaluation for @math{(10 - 5) \times 6}?

---
{layout="Launch"}
# Order of Operations

How about the Circle of Evaluation for @math{(10 - 5) \times 6}?

@image{images/coe4.png, a}{width="250"}	

---
{layout="InvestigateC"}
# Order of Operations

Turn to  @printable-exercise{pages/translate-arithmetic-to-coe-and-code-1-intro-w-parenth.adoc} in the student workbook and draw Circles of Evaluation for each of the expressions. 

Ignore the code column for now! We will come back to it later.

---
{layout="Investigate"}
# Order of Operations

For more practice with this, turn to:
- @printable-exercise{pages/complete-coe-from-arith.adoc}
- @printable-exercise{pages/match-arith-coe.adoc}
- @online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc980e05de8ae2e71174aeb?collections=5fbecc2b40d7aa0d844956f0, Matching Circles of Evaluation to Expressions}.

---
{layout="Investigate"}
# From Circles of Evaluation to Code

As in math, in Pyret there are some cases where the outermost parentheses can be removed:

- @math{(1 + 2)} can be safely written as @math{1 + 2}, and the same goes for the Pyret code
- @math{(1 * 2) * 3)} can be safely written as @math{1 * 2 * 3}, and the same goes for the Pyret code

It is always better to at least start with the parentheses before taking them out. **It is never wrong to include them!**

---
{layout="Investigate"}
# From Circles of Evaluation to Code

@image{images/coe-set1.png, a}{width="700"}


---
{layout="Investigate"}
# From Circles of Evaluation to Code

@image{images/coe-set2.png, a}{width="700"}

---
{layout="Investigate"}
# From Circles of Evaluation to Code

What would the code look like for this circle?

@image{images/coe7.png, a}{width="175"}			


<!-- 3 + 8
-->

---
{layout="Investigate"}
# From Circles of Evaluation to Code


What would the code look like for this circle?

 @image{images/coe8.png, a}{width="200"}	

<!-- 2 * ( 3 + 8 )
-->

---
{layout="Investigate"}
# From Circles of Evaluation to Code

What would the code look like for this circle?

@image{images/coe9.png, a}{width="200"}			

<!-- 6 + (1 + 2) 
-->


---
{layout="Investigate"}
# From Circles of Evaluation to Code

What would the code look like for this circle?

@image{images/coe10.png, a}{width="200"}		

<!-- (10 - 5) * 6
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

---
{layout="Launch-DN"}
# Testing out your Code

- Open @ifproglang{wescheme}{@link{https://www.wescheme.org, WeScheme}}@ifproglang{pyret}{@link{https://code.pyret.org, pyret} } and click run.
- For now, we'll work in the interactions area on the right.
- Type @show{(code '(+ (* 8 2) (/ 6 3)))} 
- Notice how the editor highlights pairs of parentheses.
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

@image{images/coe-pair.png, a}

<!--
	Possible responses: We’ve never seen the function text before. We’ve never seen words used in a Circle of Evaluation before. We’ve never seen a function take in three inputs. We’ve never seen a function take in a mix of Numbers and words.
-->

---
{layout="Investigate-DN"}
# Testing out your Code

Here is another circle to explore.{style="font-size:16pt"}

- What do you think this expression will evaluate to? {style="font-size:16pt"}
- Convert this Circle to code and try it out!{style="font-size:16pt"}

@image{images/coe13.png, a}{width="150"}


---
{layout="Supplemental"}
# Additional Practice

If you are digging into Order or Operations and are looking for more practice with Circles of Evaluation before introducing code, we have lots of options!

* @opt-printable-exercise{pages/matching-coe-exp.adoc, A printable set of cards for physically matching expressions with Circles of Evaluation}
* @opt-printable-exercise{pages/arith-to-coe.adoc}
* @opt-printable-exercise{pages/arith-to-coe2.adoc}
* @opt-printable-exercise{pages/arith-to-coe3.adoc}

---
{layout="Supplemental"}
# Additional Practice

* @opt-printable-exercise{pages/coe-to-arith.adoc}
* @opt-printable-exercise{pages/coe-to-arith2.adoc}
* @opt-printable-exercise{pages/evaluate-coe.adoc}
* @opt-printable-exercise{pages/evaluate-coe2.adoc}

---
{layout="Supplemental"}
# Additional Practice

More practice connecting Circles of Evaluation to Code

* @opt-printable-exercise{pages/coe-to-code.adoc}
* @opt-printable-exercise{pages/coe-to-code2.adoc}

More 3-column practice connecting Arithmetic Expressions with Circles of Evaluation and Code:

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-3.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-4.adoc}

---
{layout="Supplemental"}
# Additional Practice

More 3-column practice with negatives:

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-5.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-6.adoc}

More 3-column practice with square roots:

* @opt-printable-exercise{pages/translate-coe-to-code-w-sqrts.adoc}

---
{layout="Supplemental"}
# Additional Practice

3-column challenge problems with brackets and exponents:

* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-2.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-3.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-4.adoc}




