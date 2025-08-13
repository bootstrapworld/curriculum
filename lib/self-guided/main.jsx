// import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import { SelfGuided } from './SelfGuided.jsx'

// No <StrictMode> around following to avoid double render

createRoot(document.getElementById('root')).render(
  <>
    <SelfGuided />
  </>
)
