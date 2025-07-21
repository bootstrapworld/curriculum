export const hocBookBits =
  [
    // page 1
    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
text("Hello!", 200, "purple")
        ` ,
      editorContents: `
use context starter2024
text("Hello!", 200, "purple")
        `
    },
      lessonText: `

        <h1>1. Welcome to Bootstrap's Hour of Code!</h1>

          We're going to use Pyret to write programs that make images.
          <p/>
          On the right, you should see an embedded version of our Pyret Editor, which works like a chat program...
          <p/>
          <!----   <ol> = "Ordered List" (numbered list items) ---->
          <ul>
            <li> The code we've written appears in the blue bubble.</li>
            <li> The <tt>text</tt> function takes in 3 inputs: <i>a message, a size, and a color</i>.
          </li>
            <li> The Editor automatically runs each line of code you submit and responds with the result.</li>
            <li> If there's an error, the Editor will get stuck until you fix it.</li>
          </ul>
          <p/>
          <ol>
            <li>Try <b>clicking on the code</b> and editing the message.</li>
            <li>Then hit "Enter" or click the <b>Update responses</b> button in the top left to re-run the code.</li>
          </ol>
          <p/>
          You can also always click 🔄, to reset the editor to where it was the first time you saw any card.
          `
    },

    // page 2
    { editorCode: {
      definitionsAtLastRun: `use context starter2024`,
      editorContents: `use context starter2024`,
    },
      lessonText: `
          <h1>2. Coding Images</h1>
          What do you think the following code will do?
          <p/>
          <tt>star(50, "solid", "blue")</tt>
          <p/>
          <ol>
            <li> <input type="button" value="Make a prediction, then click here" onclick='addToEditor(\`
      star(50, "solid", "blue")
      \`, 0)' /> to add it to the editor and see the result!
            </li>
            <p/>
          <li>You can also click on the code on the right to change it!
           <p/>
             Try changing the 50 to another number. Then hit "Enter" or click the <b>Update responses</b> button to re-run the code. What happens?</li>
            <p/>
            <li>Try changing the color.</li>
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
star(50, "outline", "fuchsia")
`,
      editorContents: `
use context starter2024
star(50, "outline", "fuchsia")
`,
    },
      lessonText: `
        <h1>3. More Shape Functions!</h1>
          There are lots of other functions that will produce an image... and some of them take the same arguments as <tt>star</tt>:  <i> a Number and two Strings.</i>
          <p/> Here are a few for you to try!

          <ol>
            <li>Can you write the code to make a solid, green <tt>circle</tt> with a radius of 26?</li>
            <p/>
            <li>Can you make an outlined, red <tt>triangle</tt> of size 45?</li>
            <p/>
            <li>Can you make two different purple <tt>square</tt>s with side-lengths of 104?</li>
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
star(50, "solid", "blue")
rectangle(50, "solid", "blue")
`,
      editorContents: `
use context starter2024
star(50, "solid", "blue")
rectangle(50, "solid", "blue")
`,
    },
      lessonText: `
          <h1>4. What about Errors?!</h1>
          There are also image-producing functions that need more arguments than <tt>star</tt>, <tt>circle</tt>, <tt>triangle</tt>, or <tt>square</tt>.
          <p/>
          The error message we see here tells us that <tt>rectangle</tt> needs 4 arguments, but was only given 3.
          <p/>
          <ul>
          <li><i>Think about it:</i> What might be missing?</li>
          <p/>
            <li><i>Try it:</i>Take 1 minute to see if you can figure out how to change the code to successfully build a <tt>rectangle</tt> before advancing to the next slide.
            </li>
          </ul>
          <p/>
          <b>Note: The Editor needs you to fix the code that generated the error and will not be able to run new lines of code until you do!</b>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
rectangle(50, 100, "solid", "orange")
`,
      editorContents: `
use context starter2024
rectangle(50, 100, "solid", "orange")
`,
    },
      lessonText: `
          <h1>5. What Makes Rectangles Different?</h1>
          <p/>
          Why does <tt>rectangle</tt> need two numbers, while square only needed one?
           <p/>
          <ul>
            <li> <i>Think about it:</i> What do you think will happen if you switch the order of the numbers and hit "Enter".</li>
             <p/>
            <li><i>Try it:</i> Make a prediction, <input type="button" value=" then click here to switch 100 and 50" onclick='addToEditor(\`rectangle(100, 50, "solid", "orange")\`)' /> to test it out!</li>
          </ul>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
`,
      editorContents: `
use context starter2024
`,
    },
      lessonText: `
          <h1>6. More Images</h1>

          Let's explore some more functions that require the same arguments as <tt>rectangle</tt>: <i>two Numbers and two Strings</i>.
          <p/>
           <ol>
         <li> <b>Take a moment to imagine an ellipse in your mind.</b> </li>
          <ul>
            <li> Either write the code to generate an <tt>ellipse</tt> on your own or <input type="button" value="Click here to see the code for an ellipse" onclick='addToEditor(\`ellipse(100, 50, "solid", "orange")\`)' /> in the Editor.</li>

            <li> How would you explain what an ellipse is to someone else?</li>
           </ul>
            <p/><li>Can you make a tall ellipse?</li>
            <p/><li>Can you make an ellipse that looks like a circle?</li>
            <p/>

            <li><b>Experiment with <tt>right-triangle</tt>.</b></li>
            <p/>
            <ul>
            <li>Why does <tt>right-triangle</tt> need two numbers, while <tt>triangle</tt> only needed one?</li>
          </ul>
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
nose = isosceles-triangle(100, 340, "solid", "orange")
`,
      editorContents: `
use context starter2024
nose = isosceles-triangle(100, 340, "solid", "orange")
`,
    },
      lessonText: `
          <h1>7. Defining Functions</h1>

          Sometimes it is useful to define functions so that we can reuse them without having to write out all of the code.
          <p/>
          Here we have defined a nose.
          <p/>
          <ol>
            <li>What do you think will happen if you type <tt>nose</tt> in a new line of code and hit "Enter"?  Test it out.</li>
            <li>What do you think will happen if you change the color of the nose and click the <b>Update responses</b> button to re-run the code?  Test it out.</li>
            <li>Define <tt>mouth</tt> to be another shape of your choosing.</li>
            </ol>
            `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
head = circle(6, "outline", "darkgray")
torso = circle(8, "outline", "darkgray")
base = circle(10, "outline", "darkgray")
`,
      editorContents: `
use context starter2024
head = circle(6, "outline", "darkgray")
torso = circle(8, "outline", "darkgray")
base = circle(10, "outline", "darkgray")
`,
    },
      lessonText: `
          <h1>8. Composing Functions</h1>
          <ol>
            <p/>
          <b>Defining functions simplifies the process of combining them.</b>
          <p/>
            <li>What do you think this next line of code will do?</li>
          <p/>
          <tt>body = above(torso, base)</tt>
          <p/>
           Make a prediction, then <input type="button" value="click here to see what the body looks like" onclick='addToEditor(\`body = above(torso, base)\`)' /> in the editor!
          <p/>
            <li>YOUR TURN: Can you write the code to place the head above the body?</li>
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
brim = rectangle(70, 15, "solid", "black")
`,
      editorContents: `
use context starter2024
brim = rectangle(70, 15, "solid", "black")
`,
    },
      lessonText: `
          <h1>9. Composing a Top Hat</h1>

          <ol>
            <li>Define  <tt>top</tt> to be a solid black rectangle that is 50 x 30.</li>
            <p/>
            <li>Define <tt>top-hat</tt> to put the <tt>brim</tt> below the <tt>top</tt>.</li>
            <p/>
            <li>Can you make the same image using <tt>above</tt>?</li>
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
eye-white = circle(30, "solid", "lightgray")
pupil = circle(10, "solid", "black")
`,
      editorContents: `
use context starter2024
eye-white = circle(30, "solid", "lightgray")
pupil = circle(10, "solid", "black")
`,
    },
      lessonText: `

          <h1>10. Overlaying Images</h1>
          Just as we can place an image <tt>above</tt> or <tt>below</tt> another image, we can also <tt>overlay</tt> an image on top of another image.
          <p/>
          <ol>
            <li>What do you think this next line of code will do?</li>
              <p/>
              <tt>overlay(pupil, eye-white)</tt>
              <p/>
               <input type="button" value="Make a prediction, then click here" onclick='addToEditor(\`overlay(pupil, eye-white)\`)' /> to add it to the editor and see the result!
            <li>Where on the eye-white does the pupil get placed?</li>
            <li>What do you think we'd see if we typed <tt>overlay(eye-white, pupil)</tt> instead?</li>
              </p>
               <input type="button" value="Make a prediction, then click here" onclick='addToEditor(\`overlay(eye-white, pupil)\`)' /> to add it to the editor and see the result! What happened?!
          </ol>
          `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
eye-white = circle(30, "outline", "black")
pupil = circle(10, "solid", "black")
`,
      editorContents: `
use context starter2024
eye-white = circle(30, "outline", "black")
pupil = circle(10, "solid", "black")
`,
    },
      lessonText: `
          <h1>11. Placing Images Using Coordinates</h1>

          Sometimes we want <b>to place the top image somewhere other than on the center</b> of the bottom image.
          <p/>
          This requires a function called <tt>translate</tt>, which takes in two Images and two Numbers.
          <p/>
            <ul>
              <li>The first Number is the x-coordinate.</li>
              <li>The second Number is the y-coordinate.</li>
              <li>The bottom left corner of the bottom image is (0,0).</li>
           </ul>
           <p/>

             <i>Think about it:</i> What image do you think the expression <tt>translate(pupil, 10, 30, eye-white)</tt> will generate? Make a prediction!
             <p/>
             <i>Try it out:</i><input type="button" value="Click here" onclick='addToEditor(\`translate(pupil, 10, 30, eye-white)\`)' /> to add it to the editor and test it out!
             `
    },

    { editorCode: {
      definitionsAtLastRun: `
use context starter2024
eye-white = circle(30, "outline", "black")
pupil = circle(10, "solid", "black")
translate(pupil, 10, 30, eye-white)
`,
      editorContents: `
use context starter2024
eye-white = circle(30, "outline", "black")
pupil = circle(10, "solid", "black")
translate(pupil, 10, 30, eye-white)
`,
    },
      lessonText: `
          <h1>12. Making Googley Eyes</h1>
          <ol>
              <li>Use <tt>translate</tt> to place the <tt>pupil</tt> on the center of the <tt>eye-white</tt>.</li>
              <p/>
              <li>Use <tt>translate</tt> to place the <tt>pupil</tt> on the bottom of the <tt>eye-white</tt>.</li>
              <p/>
              <li>Use <tt>translate</tt> to place the <tt>pupil</tt> on the <tt>eye-white</tt> wherever you think it makes the best looking googley eye!</li>
            </ol>
            `
    },

    { videoConfig: "videos/eye.mov",
      lessonText: `
          <h1>13. Full Pyret</h1>

            So far we have been working in the Parley version of Pyret. More complex programs get written with the same exact code, but in a different view.
              <p/>On the right is a video of our classic Pyret editor in action.
              <ul>
                <li>The Definitions Area on the left side contains much of the code we've written today.</li>
                <li>In Parley, code was evaluated as you typed it.</li>
                <li>In classic Pyret, code from the Definitions area is only evaluated when you click "Run". </li>
                <li>On the right side we have the Interactions Area, where a user is evaluating <tt>eye</tt> and <tt>googley-eye</tt>.</li>
                <li>Anytime we make a change to the code in the Definitions area, we need to click "Run" again. Doing so will clear all of the code from the Interactions area.</li>
              </ul>
              <p/>

            If you'd like to watch the video again, click on the screen.

<p/>
             <input type="button" value="Click here to open Pyret in a new window" onclick="window.open('https://code.pyret.org/editor#share=1bJJzrW_XM1gQzg1oghlW98HSIsA9WWt0&v=31c9aaf', '_blank')"/> when you're ready to play around with this file in the classic Pyret editor.
             `
    },

    { imageConfig: "images/snowmanpuzzle2.png",
      lessonText: `
          <h1>14. Your Task</h1>

          Now that you're
          <ul>
            <li>familiar with Pyret</li>
            <li>know how to define image-producing functions</li>
            <li>know how to compose more complex images with them using coordinates</li>
          </ul>
          <p/>
          you're ready to solve a puzzle!
          <p/>
          When you open the file linked below and click "Run", you will see a jumbled collection of objects that need to be placed to compose a winter wonderland scene.
          <p/>
          The pieces have been defined behind the scenes so you won't be able to change them... but you don't have to use them all and, once you have successfully created an image that will make sense to other viewers, you can use what you've learned to improve upon it by defining any additional values you like!
          <p/>
         <input type="button" value="Click here to open the Winter Wonderland Puzzle" onclick="window.open('https://code.pyret.org/editor#share=1Lgax_uAdFxUJzyGKPbx2BESj9BNkTK3i&v=1904b2c', '_blank')"/>  in a new Pyret window and click "Run" to load the initial image.</a>
       `
    },
  ]
