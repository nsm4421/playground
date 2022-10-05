import axios from "axios";
import HomePage from './components/home/index';
import UploadPage from './components/upload/index';
import RegisterPage from './components/register/index';
import LoginPage from './components/login/index';
import PostPage from './components/post/page/index';
import WritePostPage from './components/post/upload/index';
import NavBar from './components/nav/index';
import { Route, Routes } from "react-router-dom";
import { useEffect, useState } from "react";
import Api from "./Api";


const App = () => {

  const [username, setUsername] = useState("");
  
  useEffect(()=> {
    const token = `Bearer ${localStorage.getItem("token")}`;
    axios
      .post(Api.getUsername.URL, {}, {
        headers:{
          Authorization:token
        }
      })
      .then((res)=>{
          if (res.data.resultCode === "SUCCESS"){
              setUsername(res.data.result.username);
          }
          console.log(res);
      })
    }, [])

  return (
    <div className="App">
      <NavBar username={username}/>
      <Routes>
        <Route path="/" element={<HomePage/>} />
        <Route path="/upload" element={<UploadPage/>} />
        <Route path="/register" element={<RegisterPage/>} />
        <Route path="/login" element={<LoginPage/>} />
        <Route path="/post" element={<PostPage/>} />
        <Route path="/post/write" element={<WritePostPage/>} />
      </Routes>    
    </div>
  );
}

export default App;
