import { Route, Routes } from 'react-router-dom';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useState } from 'react';
import MyNav from './components/MyNav';
import Home from './components/Home/Home';
import Footer from './components/Home/Footer';
import FeedPage from './components/Feed/FeedPage';
import Register from './components/Register/Register';
import Login from './components/Login/Login';

const App = () => {
    return (
    <div className="App">
      <MyNav/>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/feed" element={<FeedPage/>}/>
        <Route path="/register" element={<Register/>}/>
        <Route path="/login" element={<Login/>}/>
      </Routes>
      <Footer/>
    </div>
  );
}
export default App;
