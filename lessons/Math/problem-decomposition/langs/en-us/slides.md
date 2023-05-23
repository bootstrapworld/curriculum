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

- Define functions for `revenue` and `cost` on @printable-exercise{pages/revenue-and-cost.adoc}. __Note: The information you need to write the `cost` function is provided in the Design Recipe word problem!__
- Once you've defined the functions, open @starter-file{sallys-lemonade}.
- Enter your code for `revenue` (including all examples and definitions) below the first prompt. Enter your code for `cost` below the second prompt. Click "Run" and make sure your tests pass.

---
{layout="Investigate"}
# Problem Decomposition 

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

- Complete @printable-exercise{pages/profit.adoc}, using the Design Recipe. (There are multiple correct solutions!)
- Add your code for `profit` in @starter-file{sallys-lemonade} below the third prompt; be sure to type all examples and definitions. Click "Run". Do all your tests pass?
- Optional: complete @opt-printable-exercise{sallys-bike.adoc}

@teacher{While students are working, walk the room and gauge student understanding.  There is more than one way to write the `profit` function!  Encourage discussion between students and push them to develop their thinking on the advantages and disadvantages of each correct solution.}

---
{layout="Synthesize"}
# Problem Decomposition 

This activity started with a situation, and you modeled that situation with functions. One part of the model was _profit_, which can be written several ways. 

Turn to @printable-exercise{pages/profit-discussion.adoc} and reflect on the four function definitions presented. 

---
{layout="Synthesize"}
# Problem Decomposition 

@show{(code '(define (profit g) (- (* 1.75 g) (* 0.30 g))))}

@show{(code '(define (profit g) (* (- 1.75 0.30) g)))}

@show{(code '(define (profit g) (* 1.45 g)))}

@show{(code '(define (profit g) (- (revenue g) (cost g))))}


Which of these four `profit` definitions do you think is "best", and why?
<!--
`profit` can be _decomposed_ into a simpler function that uses the `cost` and `revenue` functions.
-->

---
{layout="Synthesize"}
# Problem Decomposition 

Suppose the cost of lemons goes up. Which solution(s) would need to be changed?

What if Sally charges $2/glass? Which solution(s) would need to be changed?


@show{(code '(define (profit g) (- (* 1.75 g) (* 0.30 g))))}

@show{(code '(define (profit g) (* (- 1.75 0.30) g)))}

@show{(code '(define (profit g) (* 1.45 g)))}

@show{(code '(define (profit g) (- (revenue g) (cost g))))}

---
{layout="Synthesize"}
# Problem Decomposition 

`profit` can be _decomposed_ into a simpler function that uses `cost` and `revenue`.

So what's the big deal?

1. Smaller pieces are _easier to think about_, and to test!{style="font-size:15pt"}
2. These pieces can also be _re-used_! Like lego pieces, smaller functions can be used to build all kinds of things.{style="font-size:15pt"}
3. Re-using code means _less code_ overall. Less code means fewer places to make mistakes.{style="font-size:15pt"}
4. Re-using code means _less duplicate code_. When code needs to be changed, that change only needs to made in one place, instead of in multiple places.{style="font-size:15pt"}

---
{layout="LaunchR"}
# Top-Down vs. Bottom-Up 

@show{(coe '(... (revenue g) (cost g)))}

_Top-Down and Bottom-Up design are two different strategies for problem decomposition._

**Bottom-Up:** start with the small, easy relationships like `revenue` and `cost` first. How are they connected with the outer circle? You'll get there eventually, but __we can leave it blank for now (`...`)__. In the Lemonade Stand, you defined `cost` and `revenue` first, and then put them together in `profit`. _This is the same approach as building your Circle of Evaluation inside-out!_{style="font-size:17pt"}

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

Take a moment to think: What would your first step be if you were trying to figure out how long Jamal would be transit? What circles would you draw or functions would you define to solve this? Would you work top-down or bottom-up?

Then turn to @printable-exercise{topdown-bottomup-discussion.adoc}.

---
{layout="Synthesize"}
# Top-Down vs. Bottom-Up 

* Whose strategy was Top-Down? How do you know?
* Do you have questions about either of these strategies?
* Which strategy to do you prefer? Why?

@teacher{Make sure that students see _both_ strategies, and have them discuss which they prefer and why.}
