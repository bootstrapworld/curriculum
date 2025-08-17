@slidebreak
{layout="Core Title Slide"}
# Simple Data Types

<!--
To learn more about how to use PearDeck, and how to view the embedded links on these slides without going into present mode visit https://help.peardeck.com/en
-->

@slidebreak
{layout="LaunchR"}
# Strings & Numbers

When programming in this class, you'll be working together using the Driver/Navigator model.{style="font-size:16pt"} 

Each group can only have one "Driver" - their hands are on the keyboard, and their job is to manage the typing, clicking, shortcuts, etc. {style="font-size:16pt"} 

If you're not a Driver, you're a "Navigator" - your job is to tell the Driver where to go, what to type, etc. A good Driver types only what the Navigator tells them to, and a good Navigator makes sure to give clear and precise instructions.{style="font-size:16pt"} 

@image{images/driver-navigator.png, 150}


@slidebreak
{layout="Launch"}
# Strings & Numbers

Open @starter-file{editor} and click "Log In", then start a new program.

@slidebreak
{layout="LaunchR"}
# Strings & Numbers

The @vocab{Editor} looks something like the diagram you see here. There are a few buttons at the top, but most of the screen is taken up by two large boxes: the @vocab{Definitions Area} on the left and the @vocab{Interactions Area} on the right.{style="font-size:17pt"} 

The @vocab{Definitions Area} is where programmers define values and functions that they want to keep, while the @vocab{Interactions Area} allows them to experiment with those values and functions.{style="font-size:16pt"}  

For now, we will only be writing programs in the *Interactions Area*.{style="font-size:16pt"} 

@image{images/editor.png}

@slidebreak
{layout="Investigate"}
# Strings & Numbers

Math and programming are languages. **Instead of nouns, they have _values_**, like the numbers 1, 2 and 3. **Instead of verbs, they have _functions_**, which are actions we can perform on values (e.g. “I can square a number”).{style="font-size:16pt"}

Languages also have rules for *syntax*. In English, for example, words don’t have `!` and `?` in the middle. In math and programming numbers don’t have `&` in them.{style="font-size:16pt"} 

Languages also have rules for *grammar*. The order of the words matters!{style="font-size:16pt"} 

Keeping the importance of *syntax* and *grammar* in mind is helpful when learning to program!{style="font-size:16pt"} 

@slidebreak
{layout="Investigate-DN"}
# Strings & Numbers

Complete @printable-exercise{strings-n-numbers.adoc}. 

Pay special attention to the error messages!

@slidebreak
{layout="Investigate"}
# Strings & Numbers

- What did you Notice? 

- What do you Wonder?

- Did you get any error messages? 

- What did you learn from them? 

<!--
Most of the error messages we've just seen were drawing our attention to syntax errors: Missing commas, unclosed strings, etc.

Common Misconceptions: In Pyret, writing decimals as `.5` (without the leading zero) results in a syntax error. Make sure students understand that Pyret needs decimals to start with a zero!}. 
-->

@slidebreak
{layout="Synthesize"}
# Strings & Numbers

- Numbers and Strings evaluate to themselves.{style="font-size:17pt"} 
- Our Editor is pretty smart. When we click on a rational number, it switches between showing a fraction and decimal.{style="font-size:17pt"} 
- Anything in quotes is a String, even something like `"42"`.{style="font-size:17pt"} 
- Strings _must_ have quotation marks on both sides.{style="font-size:17pt"} 

@ifproglang{pyret}{
@slidebreak
{layout="Synthesize"}
# Strings & Numbers

- @vocab{Operators} like `+`, `-`, `*`, and `/` need spaces around them.{style="font-size:17pt"} 
- In Pyret, the @vocab{operators} work just like they do in math.{style="font-size:17pt"} 
- When there is more than one operator being used, Pyret requires that you use parentheses to define the order of operations.{style="font-size:17pt"} 
- Types matter! We can add two Numbers or two Strings to one another, but we can’t add the Number `4` to the String `"hello"`.{style="font-size:17pt"} 


@slidebreak
{layout="Synthesize"}
# Strings & Numbers

Error messages are a way for Pyret to explain what went wrong, and are a really helpful way of finding mistakes. Emphasize how useful they can be, and why students should read those messages out loud before asking for help. Have students see the following errors:

- `6 / 0`. In this case, Pyret obeys the same rules as humans, and gives an error.
- `(2 + 2`. An unclosed quotation mark is a problem, and so is an unmatched parentheses.

}
@slidebreak
{layout="Launch"}
# Booleans 

What's the answer: is 3 greater than 10?

@slidebreak
{layout="LaunchR"}
# Booleans

Boolean-producing expressions are yes-or-no questions and will always evaluate to either `true` (“yes”) or `false` (“no”).  The ability to separate inputs into two categories is unique and quite useful!{style="font-size:15pt"} 

For example, some roller coasters with loops require passengers to be a minimum height to make sure that riders are safely held in place by the one-size-fits all harnesses. The gatekeeper doesn't care exactly how tall you are, they just check whether you are as tall as the mark on the pole. If you are, you can ride, but they don't let people on the ride who are shorter than the mark because they can't keep them safe. {style="font-size:15pt"}  

@image{images/at-least-this-tall-to-ride.jpeg}

@slidebreak
{layout="LaunchR"}
# Booleans

Similarly, when you log into your email, the computer asks for your password and checks whether it matches what's on file. If the match is `true` it takes you to your messages, but, if what you enter doesn't match, you get an error message instead.

Brainstorm other scenarios where Booleans are useful in and out of the programming environment.

@image{images/login.png}

@slidebreak
{layout="Investigate-DN"}
# Booleans

Complete @printable-exercise{pages/booleans.adoc} with your partner, making predictions about what a variety of Boolean expressions will return and testing them in the editor.

@slidebreak
{layout="Synthesize"}
# Booleans

What sets Booleans apart from other data types?
