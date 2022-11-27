import Navbar from './components/nav/index';
import ChatRoom from './components/chat/index';
import SignUp from './components/auth/register';

import { Routes, Route } from 'react-router-dom';

const App = () => {
  return (
    <div className='App'>
      <Navbar/>
      
      <Routes>
        <Route path='/register' element={<SignUp/>}/>
        <Route path='/chats' element={<ChatRoom/>}/>
      </Routes>
     
    </div>
  );
}

export default App;
