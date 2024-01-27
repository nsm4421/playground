import './App.css';
import Navbar from './components/Navbar';
import Pagination from './components/Pagination';
import SearchBar from './components/SearchBar';
import OffCanvasLeft from './components/OffCanvas';

import { useState } from 'react'

function App() {

  let [login, changeLogin] = useState(false);

  return (
    <div className="App">
      
      <h1 className="site-header">보험계리사준비하기</h1>
      <Navbar></Navbar>

      {
        login
        ?null
        :<OffCanvasLeft name={'Login'}/>
      }

      <Pagination numRecord={100}/>


    </div>
  );
}

export default App;
