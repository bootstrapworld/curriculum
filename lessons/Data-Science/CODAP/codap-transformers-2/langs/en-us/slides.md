---
{layout="DS Title Slide"} 
# More Transformers: Transform Attribute and Build Attribute

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

---
{layout="Launch"}
# Transforming Columns

We've already explored the `Filter` Transformer, which walks through a dataset, applying the @vocab{Boolean} expression that we give it to each row - and then creating a modified copy of our original dataset.

Suppose we want to _transform_ our table in a different way! Let's say we want to convert `Pounds` to `Kilograms` or `Weeks` to `Days`. The `Transform Attribute` Transformer makes that possible!


---
{layout="Investigate"}
# Transforming Columns

Like the `Filter` Transformer, the `Transform Attribute` Transformer walks through the table - but what the expression produces for each row becomes the value in a new column. We name that column when we create our `Transform Attribute` Transformer.

---
{layout="Investigate"}
# Transforming Columns

You may have noticed that when we create and save Transformers, we give them sensible names such as `filter-is-cat` or `filter-is-fixed`. The first part of the name comes from the type of Transformer, and the second part describes what the Transformer does.

In this lesson, we will transform and build columns to create _new attributes_. These new attributes need sensible names, too! If we transform our `Weeks` attribute to days (multiplying by 7), the new attribute name should be `Days`.  If we build a new attribute showing the animals’ weight in kilos, the new attribute should be called `Kilos`.


---
{layout="Investigate-DN"}
# Transforming Columns

Complete @printable-exercise{pages/codap-transform.adoc} in the @starter-file{animals} to explore how to create and apply a `Transform Attribute` Transformer.

@image{images/transform-ui-annotated.png}

---
{layout="Synthesize"}
# Transforming Columns

- A dataset from Europe might list everything in metric (centimeters, kilograms, etc), so we use `Transform Attribute` to convert to imperial units (inches, pounds, etc).
- A dataset about schools might include columns for how many students are in the school and how many of those students identify as multi-racial. But when comparing schools of different sizes, what we really want is a column showing what _percentage_ of students identify as multi-racial. We could use `Transform Attribute` to compute that for every row in the table.


---
{layout="Launch"}
# Building Columns

So far, we've used Transformers to _filter_ and to _transform an attribute_. The other Transformer we are exploring today is called `Build Attribute`.



---
{layout="Investigate-DN"}
# Building Columns

@image{images/build-ui-annotated.png}

- Complete @printable-exercise{pages/codap-build.adoc} in the @starter-file{animals}.
- Optional: Complete @opt-printable-exercise{pages/what-table-do-we-get.adoc}


<!--
	Now that students have some familiarity with creating and defining Transformers, invite them to explore `Build Attribute` to see if they can determine what it does. (It creates an additional column in the dataset, rather than _transforming_ the existing column.)
-->

---
{layout="Synthesize"}
# Building Columns

- Can you think of any other situations where you would want to use these Transformers?
- How is `Build Attribute` similar to `Transform Attribute`? How are they different?
- When might it make more sense to _build_ an attribute, rather than to _transform_ it?

<!--
- Can you think of any other situations where you would want to use these Transformers?
- How is `Build Attribute` similar to `Transform Attribute`? How are they different?
** _``Build Attribute`` creates an additional column, using the expression that we provide. `Transform Attribute` converts an existing column, using the expression that we provide._
- When might it make more sense to _build_ an attribute, rather than to _transform_ it?
** _We would build rather than transform if we want to do comparisons across columns, or need to preserve the original column for any reason (e.g., we want measurements in metric and standard units.)_
-->

---
{layout="Synthesize"}
# Building Columns

Being able to create and define a Transformer is a _huge_ upgrade in our ability to analyze data! But as a wise person once said, "with great power comes great responsibility"! Dropping all the dogs from our dataset might be a cute exercise in this class, but suppose we want to drop certain populations from a national census? Even a small programming error could erase millions of people, impact funding for things like roads and schools, etc.
