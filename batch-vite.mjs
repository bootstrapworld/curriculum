import react from "@vitejs/plugin-react";
import { defineConfig, build } from 'vite'
import { viteSingleFile } from "vite-plugin-singlefile"
import resolve from 'vite-plugin-resolve'
import quizzes from "./vite.json" with {type: "json"};

// for debugging: just one quiz
//const oneQuiz = ["distribution/en-us/lessons/__sample-lesson/assessments/sample-quiz/index.html"]

// create the JSON objects for each of our quizzes
const buildConfigs = quizzes.map( quiz => ({
  plugins: [
    react(), 
    viteSingleFile(),
    resolve({
      '@bootstrapworld/quiz' : `
        const { QuizView } = require('@bootstrapworld/quiz')
        export { QuizView }
      `
      })
  ],
  build: {
    root: "distribution",
    emptyOutDir: false,
    rollupOptions: {
      input: quiz,
    }
  }
}));

//console.log(JSON.stringify(buildConfigs, null, 2))

// wait until all of the builds are complete
await Promise.all(buildConfigs.map( async c => await build(c)));
