---
{layout="Math Title Slide"}
# Combinations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Combinations

With his new set of rules, Luigi's Family Restaurant is more popular than ever! But with a full house every night, the cooks are busy and the kitchen gets backed up. Customers start complaining about slow service, and Luigi is once again in trouble.

---
{layout="LaunchR"}
# Combinations

The cooks point out that it's easy to add twice as much ravioli to the same pot - but it's hard to make two _separate_ pots of ravioli. If people could choose their four courses in advance, the chefs could just make a few huge batches of each item and divide them up on people's plates!

@image{images/ravioli.jpg}

---
{layout="Launch"}
# Combinations

Luigi decides to change the rules again, to help his kitchen staff. There are still six items on the menu, customers can still choose any four they want, and they still can't choose the same item twice...but **order no longer matters**. Instead of a four-course meal, diners get a "combination platter" with all four items on the plate.

How is this situation similar to the permutation questions?

How is it different?

---
{layout="Investigate"}
# Combinations

When order _doesn't_ matter, all the possible options are called @vocab{combinations} (think of Luigi's "combination platter!").

Since there's no replacement, let's start by using our formula for permutation-without-replacement to compute all the possible permutations. We have six items to choose from and are selecting four of them:

@math{permute\mbox{-}no\mbox{-}replace(6, 4) = \frac{6!}{(6 - 4)!} = \frac{6!}{2!} = 360}

---
{layout="Investigate"}
# Combinations

@math{permute\mbox{-}no\mbox{-}replace(6, 4) = \frac{6!}{(6 - 4)!} = \frac{6!}{2!} = 360}

In this situation, the order __doesn't matter__, so some of these platters are going to be the same combination: Lasagna, Soup, Ziti and Chicken is a different @vocab{permutation} from Lasagna, Soup, Chicken, Ziti, but it's the same @vocab{combination}! 

If we knew that every combination would have a duplicate, we'd divide the number of platters by two. If we knew each one would have a triplicate, we'd divide by three.


---
{layout="Investigate"}
# Combinations

How do we compute the number of duplicates in a four-course platter?

We already know how to do this! This is the same question as "How many permutations are there for the same four courses?"

Using our formula for permutation without replacement we get:
@math{permute\mbox{-}no\mbox{-}replace(4, 4) = \frac{4!}{(4-4)!} = 4! = 24} duplicates!

---
{layout="Investigate"}
# Combinations

Now, we need to divide 'the number of permutations (without replacement) for choosing 4 courses out of six items" by "the number of duplicate permutations in any four-course platter".

@math{combinations(6, 4) = \frac{6!}{(6 - 4)!} \div 4! = 360 \div 24 = 15}


---
{layout="Investigate"}
# Combinations

We can rewrite this using our functions from earlier:

@math{combinations(items, choose) = \frac{permute\mbox{-}no\mbox{-}replace(items, choose)}{permute\mbox{-}no\mbox{-}replace(choose, choose)}}


---
{layout="Investigate"}
# Combinations


In this situation, we have 6 possible choices and we get to choose 4 times:

@math{combinations(6, 4) = \frac{permute\mbox{-}no\mbox{-}replace(6, 4)}{permute\mbox{-}no\mbox{-}replace(4, 4)}}

---
{layout="Investigate"}
# Combinations

Complete the @printable-exercise{combination.adoc} and @printable-exercise{combination-or-permutation.adoc} worksheets.

---
{layout="Synthesize"}
# Combinations

- What is the difference between @vocab{combination} and @vocab{permutation}?

- What are some real-world examples of combinations?

---
{layout="Supplemental"}
# Combinations

@opt-starter-file{permutations-and-combinations} provides students with a chance to view all the permutations and combinations for Luigi's menu.