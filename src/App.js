import React from 'react';
import './App.css';
import CustomerList from './components/CustomerList.js';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <CustomerList />
      </header>
    </div>
  );
}

export default App;
