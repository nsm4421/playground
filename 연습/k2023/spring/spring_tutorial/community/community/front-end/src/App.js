import { Routes, Route } from 'react-router-dom';
import ModifyArticle from './pages/modifyArticle';
import ShowArticle from './pages/showArticles';
import WriteArticle from './pages/writeArticle';
import Nav from './components/nav';
import Register from './pages/register';
import { Container } from '@mui/system';
import Login from './pages/login';
import KakaoLogin from './pages/kakaoLogin';

export default function App() {

  return (
    <Container className="App">
        <Nav/>
        <Routes>
            <Route path='/register' element={<Register/>}/>
            <Route path='/login' element={<Login/>}/>
            <Route path='/oauth2/kakao' element={<KakaoLogin/>}/>
            <Route exact path='/article/write' element={<WriteArticle/>}/>
            <Route exact path='/article/modify/:id' element={<ModifyArticle/>}/>
            <Route exact path='/article' element={<ShowArticle/>}/>
        </Routes>
    </Container>
  );
}