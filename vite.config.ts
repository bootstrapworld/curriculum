import react from "@vitejs/plugin-react";
import { glob } from 'glob';
import { fileURLToPath } from 'node:url';
import { viteSingleFile } from "vite-plugin-singlefile"
import resolve from 'vite-plugin-resolve'


// use glob to find all quiz directories
const getQuizLocations = () =>
  glob.sync('distribution/**/assessments/*/index.html')
    .map(file => fileURLToPath(new URL(file,  import.meta.url)));

const quizLocations = getQuizLocations();
console.log('INPUTS ARE\n', quizLocations)

export default {
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
    modulePreload: { polyfill: false },
    rollupOptions: {
      external: [],
      input: quizLocations[0],
      output: {
  //      manualChunks: (filename) => 'x',
        dir: ".",
      }
    }
  },
};
