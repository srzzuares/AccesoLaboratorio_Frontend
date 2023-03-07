import { useState } from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom'
import './App.css'
import { Auth } from './views/Auth'
import NavAdmin from './components/NavbarAdmin'

function App() {

  return (
    <>
      <Auth/>
    </>
  )
}

export default App
