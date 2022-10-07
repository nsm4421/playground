import axios from "axios";
import HomePage from './components/home/index';
import RegisterPage from './components/auth/register/index';
import LoginPage from './components/auth/login/index';
import PostPage from './components/post/page/index';
import WritePostPage from './components/post/upload/index';
import NavBar from './components/nav/index';
import { Route, Routes } from "react-router-dom";

const App = () => {

  return (
    <div className="App">
      <NavBar/>
      <Routes>
        <Route path="/" element={<HomePage/>} />
        <Route path="/register" element={<RegisterPage/>} />
        <Route path="/login" element={<LoginPage/>} />
        <Route path="/post" element={<PostPage/>} />
        <Route path="/post/write" element={<WritePostPage/>} />
      </Routes>    
    </div>
  );
}

export default App;
