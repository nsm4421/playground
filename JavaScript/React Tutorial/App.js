import './App.css';

import { Route } from 'react-router-dom';
import AppShell from './components/AppShell';
import Home from './components/Home';
import Texts from './components/Text';
import Result from './components/Result';
import Detail from './components/Detail';

function App() {
  return (
    <div className="App">

        <AppShell/>
        <div>
            <Route exact path="/" component={Home}/>
            <Route exact path="/texts" component={Texts}/>
            <Route exact path="/result" component={Result}/> 
            <Route exact path="/detail/:_id" component={Detail}/> 
        </div>


    </div>
  );
}

export default App;
