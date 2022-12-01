import Navbar from './components/nav/index';
import SignUp from './components/auth/register';

import { Routes, Route } from 'react-router-dom';
import Login from './components/auth/login';

const App = () => {
  return (
    <div className='App'>
      <Navbar/>
      
      <Routes>
        <Route path='/register' element={<SignUp/>}/>
        <Route path='/login' element={<Login/>}/>
      </Routes>
     
    </div>
  );
}

export default App;
