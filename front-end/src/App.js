import axios from "axios";
import HomePage from './components/home/index';
import UploadPage from './components/upload/index';
import RegisterPage from './components/register/index';
import LoginPage from './components/login/index';
import PostPage from './components/post/page/index';
import WritePostPage from './components/post/upload/index';
import { Route, Routes } from "react-router-dom";

const App = () => {

  return (
    <div className="App">
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
