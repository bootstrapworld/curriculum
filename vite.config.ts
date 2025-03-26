import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig(() => ({
  root: "lessons/__Authoring/__sample-lesson/langs/en-us/sample-quiz/",
  plugins: [react()],
}));
