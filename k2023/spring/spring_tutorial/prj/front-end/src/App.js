import { Routes, Route, useLocation } from 'react-router-dom';
import Nav from './components/nav/Nav';
import PostList from './components/post/PostList';
import WritePost from './components/post/WritePost';
import Register from './components/auth/Register';
import Login from './components/auth/Login';
import Home from './components/Home';
import MyPage from './components/my-page/MyPage';
import { useEffect } from 'react';
import { useRecoilState } from 'recoil';
import { userState } from './recoil/user';
import ModifyPost from './components/my-page/post/ModifyPost';

const App = () => {

  const [user, setUser] = useRecoilState(userState);
  const location = useLocation();
  useEffect(()=>{
    switch (location.pathname){
      // 로그아웃 처리
      case "/logout":
        localStorage.removeItem("token");
        setUser(userState);
        window.location.href="/";
      }
    }, [location.pathname]);

  return (
    <div className="App">
      <Nav/>
      <Routes>
        <Route path="/" element={<Home/>}></Route>
        <Route path="/mypage" element={<MyPage/>}></Route>
        <Route path="/register" element={<Register/>}></Route>
        <Route path="/login" element={<Login/>}></Route>
        <Route path="/post" element={<PostList/>}></Route>
        <Route path="/post/write" element={<WritePost/>}></Route>
        <Route path="/post/modify/:pid" element={<ModifyPost/>}></Route>
      </Routes>
    </div>
  );
}

export default App;
