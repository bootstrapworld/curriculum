import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import fs from 'fs'
import path from 'path'
import { fileURLToPath } from 'url'

// en-us/ is three levels above self-guided/
const selfGuidedDir = fileURLToPath(new URL('.', import.meta.url))
const enUsDir = path.resolve(selfGuidedDir, '../../..')

// Serve files from the en-us/ distribution tree so that relative links to
// pages/, lib/, etc. work in the dev server (which otherwise only serves
// files from self-guided/ and falls back to index.html for everything else).
function serveFromEnUs() {
  return {
    name: 'serve-from-en-us',
    configureServer(server) {
      server.middlewares.use((req, res, next) => {
        const filePath = path.join(enUsDir, req.url.split('?')[0])
        if (fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
          const ext = path.extname(filePath)
          const contentTypes = {
            '.html': 'text/html',
            '.css':  'text/css',
            '.js':   'application/javascript',
            '.png':  'image/png',
            '.svg':  'image/svg+xml',
            '.jpg':  'image/jpeg',
            '.jpeg': 'image/jpeg',
          }
          res.setHeader('Content-Type', contentTypes[ext] || 'application/octet-stream')
          fs.createReadStream(filePath).pipe(res)
          return
        }
        next()
      })
    }
  }
}

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), serveFromEnUs()],
  server: {
    open: true, // This opens the browser automatically on server start
    fs: { allow: [enUsDir] },
  },
})
