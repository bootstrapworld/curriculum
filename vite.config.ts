import react from "@vitejs/plugin-react";
import { glob } from 'glob';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { nodeResolve } from '@rollup/plugin-node-resolve';


// use glob to find all quiz directories
function getQuizLocations() {
  const paths = glob.sync('lessons/**/*/assessments/*/index.html');
  const entries = paths.map(file => {
      const inputFile = fileURLToPath(new URL(file,  import.meta.url));
      // remove the index.html, and take the last 5 ancestor dirs
      let outputAncestors = file
        .substring(0, file.lastIndexOf('/'))
        .split('/')
        .slice(-5);
      // remove the langs/en-us ancestors
      outputAncestors.splice(1,2);
      // append the result to distribution/langs/en-us
      let outputPath = "distribution/langs/en-us/lessons/" + outputAncestors.join('/');
      outputPath = fileURLToPath(new URL(outputPath, import.meta.url));
      return inputFile;
    })
  return entries;
}
const quizLocations = getQuizLocations();
const quizInputs = {}

quizLocations.forEach(file => {
  const ancestors = file.split('/').slice(-6);
  ancestors.splice(1, 3);
  ancestors.splice(-1);
  const entryName = ancestors.join('@');
  quizInputs[entryName] = file;
})

console.log('INPUTS ARE\n', quizInputs)

export default {
  plugins: [react(), nodeResolve()],
  build: {
    rollupOptions: {
      external: ['@bootstrapworld/quiz', 'react-dom'],
      preserveModulesRoot: true,
      input: quizInputs[0],
    }
  },
};
