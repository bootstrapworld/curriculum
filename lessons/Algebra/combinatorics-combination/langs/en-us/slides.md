@slidebreak
{layout="Math Title Slide"}
# Combinations

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="Launch"}
# Combinations

With his new set of rules, Luigi's Family Restaurant is more popular than ever! But with a full house every night, the cooks are busy and the kitchen gets backed up. Customers start complaining about slow service, and Luigi is once again in trouble.

@slidebreak
{layout="LaunchR"}
# Combinations

The cooks point out that it's easy to add twice as much ravioli to the same pot - but it's hard to make two _separate_ pots of ravioli. If people could choose their four courses in advance, the chefs could just make a few huge batches of each item and divide them up on people's plates!

@image{images/ravioli.jpg}

@slidebreak
{layout="Launch"}
# Combinations

Luigi decides to change the rules again, to help his kitchen staff. There are still six items on the menu, customers can still choose any four they want, and they still can't choose the same item twice...but **order no longer matters**. Instead of a four-course meal, diners get a "combination platter" with all four items on the plate.

How is this situation similar to the permutation questions?

How is it different?

@slidebreak
{layout="InvestigateC"}
# Combinations

When order _doesn't_ matter, all the possible options are called @vocab{combinations} (think of Luigi's "combination platter!").

Since there's no replacement, let's start by using our formula for permutation-without-replacement to compute all the possible permutations. We have six items to choose from and are selecting four of them:

@math{\mbox{permute-wo-replace}(6, 4) = \frac{6!}{(6 - 4)!} = \frac{6!}{2!} = 360}

@slidebreak
{layout="InvestigateC"}
# Combinations

@math{\mbox{permute-wo-replace}(6, 4) = \frac{6!}{(6 - 4)!} = \frac{6!}{2!} = 360}

Many platters are going to be the same _combination_: Lasagna, Soup, Ziti and Chicken might have lots of @vocab{permutations}, but all of them are just a @vocab{combination} of the same four items! 

If we knew that every combination would have a duplicate, we'd divide the number of platters by 2. If we knew each one would have a triplicate, we'd divide by 3.


@slidebreak
{layout="InvestigateC"}
# Combinations

How do we compute the number of duplicates in a four-course platter?

We already know how to do this! This is the same question as "How many permutations are there for the same four courses?"

Using our formula for "permutation without replacement", we get 24 duplicates:

@math{\mbox{permute-wo-replace}(4, 4) = \frac{4!}{(4-4)!} = 4! = 24}

@slidebreak
{layout="InvestigateC"}
# Combinations

Now, we need to divide 'the number of permutations (without replacement) for choosing 4 courses out of six items" by "the number of duplicate permutations in any four-course platter".

@math{combinations(6, 4) = \frac{6!}{(6 - 4)!} \div 4! = 360 \div 24 = 15}


@slidebreak
{layout="InvestigateC"}
# Combinations

We can rewrite this using our functions from earlier:

@math{combinations(items, choose) = \frac{\mbox{permute-wo-replace}(items, choose)}{\mbox{permute-wo-replace}(choose, choose)}}


@slidebreak
{layout="InvestigateC"}
# Combinations


In this situation, we have 6 possible choices and we get to choose 4 times:

@math{combinations(6, 4) = \frac{\mbox{permute-wo-replace}(6, 4)}{\mbox{permute-wo-replace}(4, 4)}}

@slidebreak
{layout="Investigate"}
# Combinations

Complete @printable-exercise{combination.adoc} and @printable-exercise{combination-or-permutation.adoc}.

@slidebreak
{layout="Synthesize"}
# Combinations

- What is the difference between @vocab{combination} and @vocab{permutation}?

- What are some real-world examples of combinations?

@slidebreak
{layout="Supplemental"}
# Combinations

@opt-starter-file{permutations-and-combinations} provides students with a chance to view all the permutations and combinations for Luigi's menu.
