import react from "@vitejs/plugin-react";
import { viteSingleFile } from "vite-plugin-singlefile"
import resolve from 'vite-plugin-resolve'


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
};
