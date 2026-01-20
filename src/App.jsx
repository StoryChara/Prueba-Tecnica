import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import './App.css';

import Navbar from './routes/Navbar';
import Footer from './routes/Footer';

import Home from './routes/Home'

function App() {
     return (
          <div className="App">
               <Navbar />
               
               <Home />

               <Footer />
          </div>
     );
}

export default App;