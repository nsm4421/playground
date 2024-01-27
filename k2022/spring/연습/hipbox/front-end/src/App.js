import axios from "axios";
import HomePage from './components/home/index';
import RegisterPage from './components/auth/register/index';
import LoginPage from './components/auth/login/index';
import PostPage from './components/post/page/index';
import WritePostPage from './components/post/upload/index';
import NavBar from './components/nav/index';
import { Route, Routes } from "react-router-dom";
import ChatPage from "./components/chatting/index";
import { useEffect, useState } from "react";
import Api from "./utils/Api";

const App = () => {

  const [username, setUsername] = useState("");

  return (
    <div className="App">
      <NavBar username={username} setUsername={setUsername}/>
      <Routes>
        <Route path="/" element={<HomePage/>} />
        <Route path="/register" element={<RegisterPage username={username}/>} />
        <Route path="/login" element={<LoginPage username={username}/>} />
        <Route path="/post" element={<PostPage/>} />
        <Route path="/post/write" element={<WritePostPage/>} />
        <Route path="/chat" element={<ChatPage username={username}/>} />
      </Routes>    
    </div>
  );
}

export default App;
