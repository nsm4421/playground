import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css'
import MyNav from './components/MyNav';
import AddCoverage from './components/AddCoverage';
import ShowCoverage from './components/ShowCoverage';
import { Route } from 'react-router-dom';

function App() {
  return (
    <div className="App">
  
      <MyNav/>

      <Route path="/Qx">
      </Route>

      <Route path="/AddCoverage">
        <AddCoverage port={4000} address="AddCoverage"/>
      </Route>
    
      <Route path="/ShowCoverage">
        <ShowCoverage port={4000} address="ShowCoverage"/>
      </Route>
    



    </div>
  );
}


export default App;
