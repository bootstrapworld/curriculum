---
{layout="Math Title Slide"}
# Problem Decomposition

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->
---
{layout="LaunchR"}
# Problem Decomposition 

__Sally runs a lemonade stand, which charges $1.75/glass. It costs her $0.30/glass to buy sugar, ice and lemons.__

* What do you Notice? 
* What do you Wonder?

@image{images/LemonadeStand.png}

<!--
- Every glass sold brings in $1.75 in *revenue*
- Every glass sold brings in some amount of *profit*: it costs a certain amount to make, but it brings in another amount in revenue
- The total cost of the bike will be depend on the tax rate.
- In order to figure out how many lemonade sales it will take to pay for the bike, we'd need to to divide the cost (with tax) by the profit per glass.
-->

---
{layout="Investigate"}
# Problem Decomposition 

Complete @printable-exercise{pages/revenue-and-cost.adoc}. 

*Note: The information you need to write the `cost` function is provided in the word problem!*

- What is the difference between _revenue_ and _profit_?

- How could Sally _increase_ her profits?

- What is the _relationship_ between profit, cost, and revenue?

<!--
What is the difference between revenue and profit? Revenue is the total amount of money that comes in, profit is the remaining money after cost has been subtracted.

How could Sally increase her profits? By decreasing her costs, raising her prices (which increases revenue), by selling more lemonade.

What is the relationship between profit, cost, and revenue? Profit = Revenue - Cost
-->

---
{layout="Investigate-DN"}
# Problem Decomposition 

- Complete @printable-exercise{pages/profit.adoc}.
- When you've completed all three Design Recipes, open @starter-file{sallys-lemonade} and save a copy to remix.
- Type the examples and definitions for all three functions and click Run. Do all your tests pass?

*Your teacher may also ask you to complete @opt-printable-exercise{sallys-bike.adoc}*

<!--
While students are working, walk the room and gauge student understanding.  There is more than one correct way to write the `profit` function!  Encourage discussion between students and push students to develop their thinking on the advantages and disadvantages of each correct solution.

As students finish, or for homework, you may also want them to figure out how many cups of lemonade sally would have to sell in order to buy her bike using @opt-printable-exercise{sallys-bike.adoc}.
-->

---
{layout="Synthesize"}
# Problem Decomposition 

Turn to @printable-exercise{pages/profit-discussion.adoc} and take a few minutes to reflect on the four function definitions presented.

---
{layout="Synthesize"}
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
Which of these four `profit` definitions do you think is "best", and why?
<!--
`profit` can be _decomposed_ into a simpler function that uses the `cost` and `revenue` functions.
-->

---
{layout="Synthesize"}
# Problem Decomposition 

Suppose the cost of lemons goes up. Which solution(s) would need to be changed?

What if Sally charges $2/glass? Which solution(s) would need to be changed?

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



---
{layout="Synthesize"}
# Problem Decomposition 

`profit` can be _decomposed_ into a simpler function that uses `cost` and `revenue`.

Decomposing a problem allows us to solve it in smaller pieces, which are also __easier to test__!

These pieces are __reusable__, resulting in writing __less code__, and __less duplicate code__.

Duplicate code means more places to make mistakes, especially when that code needs to be changed.

---
{layout="LaunchR"}
# Top-Down vs. Bottom-Up 

@show{(coe '(... (revenue g) (cost g)))}

_Top-Down and Bottom-Up design are two different strategies for problem decomposition._

**Bottom-Up:** start with the small, easy relationships like `revenue` and `cost` first. How are they connected with the outer circle? You'll get there eventually, but __we can leave it blank for now (`...`)__. In the Lemonade Stand, you defined `cost` and `revenue` first, and then put them together in `profit`. _This is the same approach as building your Circle of Evaluation inside-out!_

---
{layout="LaunchR"}
# Top-Down vs. Bottom-Up 

@show{(coe '(- ...revenue... ...cost...))}

_Top-Down and Bottom-Up design are two different strategies for problem decomposition._

**Top-Down:** start with the "big picture" and then worry about the details later. We could have started with `profit` as @show{(code '(- revenue cost))}, and __fill in the details of `revenue` and `cost` later (thus the `...`)__. _This is the same approach as building your Circle of Evaluation outside-in!_

---
{layout="Investigate"}
# Top-Down vs. Bottom-Up 

__Jamal's trip requires him to drive 20mi to the airport, fly 2300mi, and then take a bus 6mi to his hotel. His average speed driving to the airport is 40mph, the average speed of an airplane is 575mph, and the average speed of his bus is 15mph.__ _Aside from time waiting for the plane or bus, how long is Jamal in transit?_

This can be decomposed via Top-Down or Bottom-Up design. What functions would you define to solve this and in what order? Work it out on @printable-exercise{topdown-bottomup-discussion.adoc}.

---
{layout="Synthesize"}
# Top-Down vs. Bottom-Up 

* Whose strategy was Top-Down? How do you know?
* Do you have questions about either of these strategies?
* Which strategy to do you prefer? Why?

