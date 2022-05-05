---

# Defining Values

---
# What's in Common? 

Take a look at the expressions below:

@ifproglang{wescheme}{

```
(star 50 "solid" "green")
(scale 3 (star 50 "solid" "green"))
(scale .5 (star 50 "solid" "green"))
(rotate 45 (star 50 "solid" "green"))
(rotate 45 (scale 3 (star 50 "solid" "green")))
```

- What code do they all have in common?
}

@ifproglang{pyret}{
```
star(50, "solid", "green")
scale(3, star(50, "solid", "green"))
scale(0.5, star(50, "solid", "green"))
rotate(45, star(50, "solid", "green"))
rotate(45, scale(3, star(50, "solid", "green")))
```

- What code do they all have in common?
}

- What would happen if you were asked to change the color of all the stars to gold?

---
# What's in Common? 

Duplicate code is almost always bad!

There are lots of potential problems with duplicate code:

- *Readability:* The more code there is, the harder it can be to read.
- *Performance:* Why re-evaluate the same code a dozen times, when we can evaluate it _once_ and use the result as many times as we need?
- *Maintainability:* Suppose we needed to change the size of the stars in the examples above. We would have to make sure every line is changed, which leaves a lot of room for error.

---
# What's in Common? 

Since we're using that star over and over again, wouldn't it be nice if we could define a "nickname" for that code, and then use the nickname over and over in place of the expression? And then, if we wanted to change something about all of the stars, we would only have to make the change once, in the definition.

---
# What's in Common? 

You already know how to do this in math:


@math{x = 4} _defines_ the nickname @math{x} to be the value 4.

@ifproglang{wescheme}{WeScheme uses the word "define" to make this even clearer!
We can type ``(define x (4))`` to define ``x`` to be the value 4.
}

@ifproglang{pyret}{
	Pyret is no different! We type ``x = 4`` to define ``x`` to be the value 4.
}

---
# What's in Common? 

Once we've defined `x` to be the value 4 and clicked "run", anytime we use `x`, the computer will remember that it is _defined_ as 4.  We can _use_ that definition to get an answer. For example, @math{x + 2} will evaluate to 6.

Of course, the whole point of defining a value is so that it sticks around and can be used later! That's why programmers put their definitions on the _left-hand side_, known as the @vocab{Definitions Area}.

---
# What's in Common? 

- Open the @starter-file{defining-values} and complete the notice and wonder exercise on @printable-exercise{pages/defining-values-explore.adoc} with your partner.
- Complete the remaining questions and add some definitions of your own in the definitions area. Be sure to click *Run* again before you try testing them out.

---
# What's in Common? 

- *What data types can we define values for?*

- What values did you decide to define? When might they be useful?

---
# Using Defined Values

Now that we know _how_ to define values, we've got two more things to consider:

* When it would be _useful_ to define them
* How to _use_ them once we have

---
# Using Defined Values

Open to @printable-exercise{chinese-flag.adoc}

<!--
It will direct them to open the @starter-file{flags-china} once they complete the first half of the questions on the page.
-->

---
# Using Defined Values

- Open the editor and type @show{(code '(radial-star 30 20 50 "solid" "yellow"))} into the interactions area and click run.
- Work in the Definitions area to define a value `sun` to be the image @show{(code '(radial-star 30 20 50 "solid" "yellow"))}.

---
# Using Defined Values

- Turn to @printable-exercise{pages/coe-why-define-values.adoc}.
- The first row of the table has been completed for you. 

- Could I get a volunteer to explain what they see happening in that first row?

- Complete the page and test your code in the editor.

---
# Using Defined Values

Why is defining values useful?

---
# Additional Exercises:

* @printable-exercise{pages/writing-code-using-defined-values.adoc}
@ifproglang{wescheme}{
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5ff46882e3b4660c751f707e?collections=5fbecc2b40d7aa0d844956f0, Matching Code to Images using overlay & put-image}
}
@ifproglang{pyret}{
* @opt-online-exercise{https://teacher.desmos.com/activitybuilder/custom/5fc90f1289c78e0d2a5bccfc, Matching Code to Images using overlay & put-image}
}