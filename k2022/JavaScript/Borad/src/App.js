import './App.css';
import Nav from './components/Nav/Nav';
import { useEffect, useState } from 'react';
import Register from './components/Register/Register';
import Login from './components/Register/Login';
import React from "react";
import PostingPage from './Pages/Posting/Posting';

import WrittingPage from './Pages/Writting/Writting';
import { Route } from 'react-router-dom';

const App = () => {

  // store
  const [logined, setLogined] = useState(false);
  
  useEffect(()=>{
    const userString = localStorage.getItem('karma-user');
    if (userString){
      setLogined(false);
      return
    } else {
      const user = JSON.parse(userString);
      if (user){
        setLogined(true);
      } else {
        setLogined(false);
      };   
    }
  }, []);

  return (
    <div className="App">

        <Nav logined={logined}/>  
        <Route exact path="/login"><Login/></Route>
        <Route exact path="/register"><Register/></Route>
        <Route exact path="/"><PostingPage/></Route>
        <Route exact path="/writting"><WrittingPage/></Route>


    </div>
  );
}

export default App;
