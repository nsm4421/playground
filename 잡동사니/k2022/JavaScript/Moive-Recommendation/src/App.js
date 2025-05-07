import './App.css';
import MyNav from './components/MyNav';
import Trending from './components/Trending';
import MyBottomNavbar from './components/MyBottomNav';
import Home from './components/Home';
import { useState } from 'react';
import SearchPage from './components/SarchPage';

function App() {
  
  let [tab, setTab] = useState(0);

  return (
    <div className="App">
      <MyNav/>
      
      <MyBottomNavbar tab={tab} setTab={setTab}/>
      
      {
        tab == 0
        ? <Home/>
        : null
      }

    {
        tab == 1
        ?<Trending/> 
        : null
      }

    {
        tab == 2
        ?<SearchPage movie_id={24}/> 
        : null
      }
    </div>
  );
}

export default App;
