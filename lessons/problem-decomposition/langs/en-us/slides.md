---

# Problem Decomposition

---
# Problem Decomposition 

@image{images/LemonadeStand.png, "Lemonade Stand Ideas including: charge $1.75, ask mom about cups, new bike = $198, how much lemonade? sugar? lemons? powdered drink mix?"}

{.column}

* What do you Notice? 
* What do you Wonder?
* One example of a _relationship_ we can find in this situation is that every glass sold incurs *costs*... Sally will need lemons, sugar, powdered drink mix, cups, and water.
* What other relationships can you find here?

<!--
- Every glass sold brings in $1.75 in *revenue*
- Every glass sold brings in some amount of *profit*: it costs a certain amount to make, but it brings in another amount in revenue
- The total cost of the bike will be depend on the tax rate.
- In order to figure out how many lemonade sales it will take to pay for the bike, we'd need to to divide the cost (with tax) by the profit per glass.
-->

---
# Problem Decomposition 

Complete @printable-exercise{pages/revenue-and-cost.adoc}. 

*Note: The information you need to write the cost function is provided in the Design Recipe word problem!*

---
# Problem Decomposition 

- What is the difference between _revenue_ and _profit_?

- How could Sally _increase_ her profits?

- What is the _relationship_ between profit, cost, and revenue?

---
# Problem Decomposition 

- Complete @printable-exercise{pages/profit.adoc}, using the Design Recipe.
- When you've completed all three Design Recipes, open @starter-file{sallys-lemonade} and save a copy for you to remix.
- Type the examples and definitions for all three functions and click Run. Do all your tests pass?

*Your teacher may also ask you to complete @opt-printable-exercise{sallys-bike.adoc}*

<!--
While students are working, walk the room and gauge student understanding.  There is more than one correct way to write the `profit` function!  Encourage discussion between students and push students to develop their thinking on the advantages and disadvantages of each correct solution.

As students finish, or for homework, you may also want them to figure out how many cups of lemonade sally would have to sell in order to buy her bike using @opt-printable-exercise{sallys-bike.adoc}.
-->

---
# Problem Decomposition 

Turn to @printable-exercise{pages/profit-discussion.adoc} and take a few minutes to reflect on the four function definitions presented.

---
# Problem Decomposition 

@ifproglang{wescheme}{
```
(define (profit g) (- (* 1.75 g) (* 0.30 g)))
(define (profit g) (* (- 1.75 0.30) g))
(define (profit g) (* 1.45 g))
(define (profit g) (- (revenue g) (cost g)))
```
}
@ifproglang{pyret}{
```
fun profit(g): (1.75 * g) - (0.30 * g) end
fun profit(g): (1.75 - 0.30) * g end
fun profit(g): 1.45 * g end
fun profit(g): revenue(g) - cost(g) end
```
}

- Which of these four `profit` definitions do you think is "best", and why?
- Did anyone have additional ideas for how to define a `profit` function?
- If lemons get more expensive, which definitions of `profit` need to be changed?
- If Sally raises her prices, which definitions of `profit` need to be changed?
- Which definition of `profit` is the most flexible? Why?

<!--
`profit` can be _decomposed_ into a simpler function that uses the `cost` and `revenue` functions.
-->

---
# Problem Decomposition 

Decomposing a problem allows us to solve it in smaller pieces.

**Big Ideas**

1. Smaller pieces are _easier to think about_, and to test!
1. These pieces can also be _re-used_! Like lego pieces, smaller functions can be used to build all kinds of things.
1. Re-using code means _less code_ overall. Less code means fewer places to make mistakes.
1. Re-using code means _less duplicate code_. When code needs to be changed, that change only needs to made in one place, instead of in multiple places.

---
# Top-Down vs. Bottom-Up 

_Top-Down_ and _Bottom-Up_ design are two different strategies for problem decomposition.

---
# Top-Down vs. Bottom-Up 

@image{images/top-down-coe.png,a}

{.column}

*Top-Down:* start with the "big picture" and then worry about the details later. We could have started with `profit`, and made a to-do list of the smaller pieces we’d build later. _This is the same approach as building your Circle of Evaluation outside-in!_

---
# Top-Down vs. Bottom-Up 

@image{images/bottom-up-coe.png,a}

{.column}

*Bottom-Up:* start with the small, easy relationships first and then build our way to the larger relationships. In the Lemonade Stand, you defined `cost` and `revenue` first, and then put them together in `profit`. _This is the same approach as building your Circle of Evaluation inside-out!_


---
# Top-Down vs. Bottom-Up 

Consider the following situation:

__Jamal's trip requires him to drive 20mi to the airport, fly 2300mi, and then take a bus 6mi to his hotel. His average speed driving to the airport is 40mph, the average speed of an airplane is 575mph, and the average speed of his bus is 15mph.__

_Aside from time waiting for the plane or bus, how long is Jamal in transit?_

Take a moment to think: What would your first step be if you were trying to figure out how long Jamal would be transit? What circles would you draw or functions would you define to solve this? Would you work top-down or bottom-up?

Then turn to @printable-exercise{topdown-bottomup-discussion.adoc}.

---
# Top-Down vs. Bottom-Up 

* Whose strategy was top-down? How do you know?
* Do you have questions about either of these strategies?
* Which strategy to do you prefer? Why?

