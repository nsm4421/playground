import './App.css';
import Movie from './Movie';

function App() {

  return (
    <div className="App">
      
      <h1>영화 평점</h1>    

      <Movie id={0}></Movie>
      <Movie id={1}></Movie>
      <Movie id={2}></Movie>
      <Movie id={3}></Movie>
    
    </div>
  );
}

export default App;
