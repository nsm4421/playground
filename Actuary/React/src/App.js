import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css'
import MyNav from './components/MyNav';
import AddCoverage from './components/AddCoverage';


function App() {
  return (
    <div className="App">
  
      <MyNav/>

      <AddCoverage port={4000} address="AddCoverage"/>


    </div>
  );
}


export default App;
