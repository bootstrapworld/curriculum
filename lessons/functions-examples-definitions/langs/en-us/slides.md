---

# Functions: Contracts, Examples & Definitions

---
{layout="Launch"}
# Three Representations of a Function

Open the @starter-file{bc}. You'll see the Contract, some Examples and the Function Definition for `gt`.

What do you notice? What do you wonder?

---
{layout="Launch"}
# Three Representations of a Function

- Every function has a contract.
@image{images/gt-contract.png, "a"}

- We can write examples illustrating how a function should work to help us identify the pattern.

@ifproglang{Pyret}{
@image{images/examples-pyret.png, "gt Examples", 400}}

@ifproglang{WeScheme}{
@image{images/examples-wescheme.png, "gt Examples", 400}}

- Function definitions replace whatever changes in the examples with a variable describing what changes.

@ifproglang{pyret}{@image{images/gt-fun-pyret.png, "gt Function Definition", 400}}
@ifproglang{wescheme}{@image{images/gt-fun-wescheme.png, "gt Function Definition", 500}}

---
{layout="Launch"}
# Three Representations of a Function

If we use the correct syntax, we can include all three of these function representations in our @ifproglang{pyret}{Pyret} @ifproglang{wescheme}{WeScheme} files. Let's take a look!

* Click *Run*.
@ifproglang{pyret}{
* What message do you get back? 
* What do you think that message means?
}
* Change
@ifproglang{pyret}{`gt(10) is triangle(10, "solid", "green")` to `gt(15) is triangle(15, "solid", "green")`}
@ifproglang{wescheme}{`(EXAMPLE (gt 10) (triangle 10 "solid" "green"))` to `(EXAMPLE (gt 10) (triangle 15 "solid" "green"))`}
* Click run. What happens?

---
{layout="Launch"}
# Three Representations of a Function

Examples not only help us to identify the pattern to define a function, they also let us double check that the functions we define do what we intend for them to do!

<!--
OPTIONAL: If students feel confident with the Circles of Evaluation but less confident about typing examples, use @opt-printable-exercise{MappingExamplesWithCoE.adoc} to make the connection explicit.
-->

---
{layout="Investigate"}
# Three Representations of a Function

Complete:

- @printable-exercise{match-examples-contracts.adoc}
- @printable-exercise{match-examples-definitions.adoc}
- @printable-exercise{create-contracts-examples.adoc}

And/or these desmos card sort activities:

@ifproglang{wescheme}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/60aa50b7012000080d4136a0, Matching Examples & Contracts}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/607b618988b17d447fe159e8?collections=5fece3d3e755260caa22904c, Matching Examples & Function Definitions}
}

@ifproglang{pyret}{
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc9328d18307e2e492ca0d8, Matching Examples & Contracts}
- @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc536c0e2f06d0cd3992c68, Matching Examples & Function Definitions}
}


<!--
There are many more materials for students to work with in the Additional Practice section at the end of the lesson!
-->

---
{layout="Synthesize"}
# Three Representations of a Function

- What strategies did you use to match the @vocab{examples} with the @vocab{contracts}?
- What strategies did you use to match the @vocab{examples} with the @vocab{function definitions}?

---
{layout="Launch"}
# Defining bc and Other Functions

Turn to @printable-exercise{pages/contracts-examples-definitions.adoc}

* On the top half of the page you will see the contract, examples, and function definition for `gt`. 
* Circle what is changing and label it with the word `size`. 
* Using `gt` as a model, complete the contract, examples and function definition for `bc`.  
* Then type the Contract, Examples and Definition into the Definitions Area. 
* Click “Run”, and make sure all of the examples pass!

---
{layout="Investigate"}
# Defining bc and Other Functions

Complete @printable-exercise{pages/contracts-examples-definitions-stars.adoc} and @printable-exercise{pages/contracts-examples-definitions-name.adoc}.

<!--
As students work, walk around the room and make sure that they are circling what changes in the examples and labeling it with a variable name that reflects what it represents.
-->

---
{layout="Synthesize"}
# Defining bc and Other Functions

- How were each of the representations helpful?
- Why is it important to write examples in our code?

---
# Additional Exercises

- @opt-printable-exercise{pages/examples-same-contracts1.adoc}
- @opt-printable-exercise{pages/examples-same-contracts2.adoc}
- @opt-printable-exercise{pages/match-contracts-examples1.adoc}
- @opt-printable-exercise{pages/match-contracts-examples2.adoc}

