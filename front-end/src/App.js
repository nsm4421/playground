import Navbar from './components/nav/index';
import SignUp from './components/auth/register';

import { Routes, Route } from 'react-router-dom';

const App = () => {
  return (
    <div className='App'>
      <Navbar/>
      
      <Routes>
        <Route path='/register' element={<SignUp/>}/>
      </Routes>
     
    </div>
  );
}

export default App;
