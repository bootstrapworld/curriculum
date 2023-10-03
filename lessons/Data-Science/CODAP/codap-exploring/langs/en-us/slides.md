@slidebreak
{layout="DS Title Slide"}  
# Exploring CODAP 

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="InvestigateR"}
# Exploring CODAP

When programming in this class, you'll be working together using the Driver/Navigator model.{style="font-size:16pt"} 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. {style="font-size:16pt"} 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.{style="font-size:16pt"} 

@image{images/driver-navigator.png, 150}


<!--
This model of pair programming is extremely useful for teasing apart the "thinking" step from the "typing" one. Students - especially those who are new to text-based programming or typing itself - can struggle to put their thoughts into the programming environment. This model allows them to focus on _communicating their ideas_, but letting the Driver focus on the coding. Likewise, the Driver has a chance to focus on syntax and programming. Finally, the requirement that ideas are translated through another person's hands is an excellent scaffold for getting students talking about their thinking and about code.

@link{https://en.wikipedia.org/wiki/Pair_programming, You can read more about the Driver/Navigator model here...}
-->

@slidebreak
{layout="Investigate-DN"}
# Exploring CODAP

- Open the @starter-file{animals} in CODAP.
- Explore this data - and CODAP! - by following the instructions and recording your observations on @printable-exercise{codap-exploration.adoc}.
- What did you Notice? What do you Wonder?
- Did you encounter any difficulties?

<!--
Possible challenges: the grey plus sign does not appear unless a table or table row is selected; the button that minimizes doesn't appear unless the table's title is selected; and, the same button that minimizes also expands.
-->
@slidebreak

{layout="Synthesize"}
# Exploring CODAP

- Was there anything about CODAP was exciting to you?
- Was there anything about CODAP that was frustrating for you?
- Did you make any discoveries about CODAP that you think others should know about?


@slidebreak
{layout="Launch"}
# Strings and Numbers

The folks at the shelter need help completing a variety of tasks using CODAP! To do this, they need to learn how CODAP handles the kinds of data in the animals data set (numbers, words, and more...).


@slidebreak
{layout="Investigate-DN"}
# Strings and Numbers


- Complete @printable-exercise{strings.adoc}.
- What is a string? Why might it be important to understand what a string is?
- Did you get any error messages? What did you learn from them?

<!--
** A string is the data type for any sequence of characters between quotation marks. It is important to understand what a string is so that we can use them correctly and interpret error messages relating to string use.
** _Most of the error messages we've just seen were drawing our attention to @vocab{syntax errors}: missing commas, unclosed strings, etc._
-->

@slidebreak
{layout="Investigate"}
# Strings and Numbers

As an employee of the shelter, you want each of these animals to be adopted! You wonder if visitors to the shelter might prefer to receive each animal’s weight in kilograms, or maybe rounded to the nearest whole number.


@slidebreak
{layout="Investigate"}
# Strings and Numbers

- Complete @printable-exercise{numbers.adoc}.
- Did anything surprise you about how numbers behave in CODAP?
- What is an @vocab{argument}?

<!--
** _The arguments are the inputs to a function._
-->

@slidebreak
{layout="Investigate"}
# Strings and Numbers

So far, you have discovered two basic data types:
- @vocab{Number} - a data type representing real numbers
- @vocab{String} - a data type for any sequence of characters between quotation marks


@slidebreak
{layout="Synthesize"}
# Strings and Numbers


- Numbers and Strings evaluate to themselves.
- CODAP converts fractions into decimals automatically.
- Anything in quotes is a String, with one exception: CODAP will convert strings containing only Numbers (e.g. “42” but not “42 hello”) into Number values.
- Strings _must_ have quotation marks on both sides.
- Operators work just like they do in math - with a few exceptions. The `+`, for instance, will join together two strings, or a Number and a String.
- CODAP follows the standard order of operations.


@slidebreak
{layout="Synthesize"}
# Strings and Numbers


- Think about the new columns you created. How did the inputs relate to the outputs?
- Did you encounter any new functions that intrigued you?
- What kind of error messages did you encounter, if any?


<!--
Error messages are a way for CODAP to explain what went wrong, and are a helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help.
-->
