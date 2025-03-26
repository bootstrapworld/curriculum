import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig(() => ({
  base: "./lessons/__Authoring",
  plugins: [react()],
  rollupOptions: {
      // https://rollupjs.org/configuration-options/
    },
}));
