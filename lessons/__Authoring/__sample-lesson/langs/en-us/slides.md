@slidebreak

# A Zorder of Zoperations II

@scrub{Flannery's sample slide file form Order of Operations. Modified so it goes through.}

@slidebreak

# Order of Operations

If you were to write instructions for getting ready for school, it would matter very much which instruction came first: putting on your socks, putting on your shoes, etc. 

Sometimes we need multiple expressions in mathematics, and the order matters there, too!

@show{(contract "gt" '("Number") "Number")}

@slidebreak
{Layout="Launch"}
# Order of Operations

Using curly braces immediately after a parsed expression (like a paragraph, a heading, or even just a formatted snippet) allows you to specify a custom style using a limited subset of CSS. This is handy if you have a LOT of text, and need to make it smaller to prevent it from overflowing.{style="font-size:8pt; color:green;"}

And the next paragraph goes back to normal!

@image{images/pemdas.png, 300}

@slidebreak

# Order of Operations

@math{6 \div 2(1 + 2)}

Instead of using a rule for computing answers, let's start by diagramming the math itself!

@slidebreak

# Order of Operations

*Circles of Evaluation* allow us to draw the structure of mathematics. The rules are simple:

1) Every Circle must have one - and only one! - function, written at the top.

That means that Numbers (e.g. - @math{3}, @math{-29}, @math{77.01}...) are still written by themselves. It's only when we want to _do something_ like add, subtract, etc. that we need to draw a Circle.

2) The inputs to the function are written left-to-right, in the middle of the Circle.

If we want to draw the Circle of Evaluation for @math{(/ 6 3)}, the division function (`/`) is written at the top, with the `6` on the left and the `3` on the right.

@show{(coe '(/ 6 3))}


@slidebreak
# Order of Operations

What if we want to use multiple functions?  How would we draw the Circle of Evaluation for @smath{(/ 6 (+ 1 2))}?
 
@slidebreak

# Order of Operations

Circles can contain other Circles

We basically replace the `3` from our earlier Circle of Evaluation with _another_ Circle, which adds 1 and 2!

@show{(coe '(/ 6 (+ 1 2)))}

@slidebreak

# Order of Operations

What would the Circle of Evaluation for @math{5 \times 6} look like?

@show{(coe '(* 5 6))}



How about the Circle of Evaluation for @math{(10 - 5) \times 6}?

@show{(coe '(* (- 10 5) 6))}

This is a link

@link{https://docs.google.com/presentation/d/1eLe5LmYNfVBN_6Yw6K41UIpLTO1GOfy2295HrbjlKhk/, Lesson Slides}

@slidebreak

# Order of Operations

Turn to  @printable-exercise{pages/translate-arithmetic-to-coe-and-code-1-intro-w-parenth.adoc} in the student workbook and draw Circles of Evaluation for each of the expressions. (Ignore the code column for now! We will come back to it later.)

@slidebreak
# Order of Operaations

For more practice with this, turn to:
@printable-exercise{pages/complete-coe-from-arith.adoc}, @printable-exercise{pages/match-arith-coe.adoc}
@online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc980e05de8ae2e71174aeb?collections=5fbecc2b40d7aa0d844956f0, Matching Circles of Evaluation to Expressions}.

@slidebreak
# From Circles of Evaluation to Code

When converting a Circle of Evaluation to code, it's useful to imagine a spider crawling through the circle from the left and exiting on the right. 

- The first thing the spider does is cross over a curved line (an open parenthesis!), then visit the operation @ifproglang{wescheme}{- also called the _function_ -} at the top. 
- After that, she crawls from left to right, visiting each of the inputs @ifproglang{wescheme}{to the function}. 
- Finally, she has to leave the circle by crossing another curved line (a close parenthesis).

@slidebreak
# From Circles of Evaluation to Code

Now that we know how to translate Circles of Evaluation into Code, turn back to @printable-exercise{pages/translate-arithmetic-to-coe-and-code-1-intro-w-parenth.adoc}.

Once you confirm that your code is correct, continue on to @printable-exercise{pages/translate-arithmetic-to-coe-and-code-2-outro.adoc}

Challenge:  @printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge.adoc}

@slidebreak
# Testing out your Code

- Open @starter-file{editor} and click run.
- For now, we are only going to be working in the Interactions Area on the right hand side of your screen.
- Type @show{(code '(+ (* 8 2) (/ 6 3)))} into the Interactions Area.
- Notice how the editor highlights pairs of parentheses to help you confirm that you have closed each pair.
- Hit Enter (or Return) to evaluate this expression. What happens?
- Take a few minutes to go back and test each line of code you wrote on the pages you've completed by typing them into the Interactions Area. Use the error messages to help you identify any missing characters and edit your code to get it working.

@slidebreak
# Testing out your Code

@scrub{Here are two Circles of Evaluation.}

@show{(coe `(* 10 -4))}
@show{(coe `(text "Good work!" 50 "red"))}

One of them is familiar, but the other is very different from what you've been working with. 

- What's different about the Circle on the right?
- Can you figure out the Name for the function in the second Circle?
- What do you think this expression will evaluate to?
- Convert this Circle to code and try it out!

@slidebreak
# Testing out your Code

Here is another circle to explore.
@show{(coe '(string-length "fun!"))}

- What do you think this expression will evaluate to?
- Convert this Circle to code and try it out!

@slidebreak
# Additional Practice

If you are digging into Order or Operations and are looking for more practice with Circles of Evaluation before introducing code, we have lots of options!

* @opt-printable-exercise{pages/matching-coe-exp.adoc, A printable set of cards for physically matching expressions with Circles of Evaluation}
* @opt-printable-exercise{pages/arith-to-coe.adoc}
* @opt-printable-exercise{pages/arith-to-coe2.adoc}
* @opt-printable-exercise{pages/arith-to-coe3.adoc}
* @opt-printable-exercise{pages/coe-to-arith.adoc}
* @opt-printable-exercise{pages/coe-to-arith2.adoc}
* @opt-printable-exercise{pages/evaluate-coe.adoc}
* @opt-printable-exercise{pages/evaluate-coe2.adoc}

More practice connecting Circles of Evaluation to Code

* @opt-printable-exercise{pages/coe-to-code.adoc}
* @opt-printable-exercise{pages/coe-to-code2.adoc}

More 3-column practice connecting Arithmetic Expressions with Circles of Evaluation and Code:

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-3.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-4.adoc}

More 3-column practice with negatives:

* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-5.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-coe-and-code-w-neg-6.adoc}

More 3-column practice with square roots:

* @opt-printable-exercise{pages/translate-coe-to-code-w-sqrts.adoc}

3-column challenge problems with brackets and exponents:

* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-2.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-3.adoc}
* @opt-printable-exercise{pages/translate-arithmetic-to-circles-and-code-challenge-4.adoc}





