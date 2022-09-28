import axios from "axios";
import HomePage from './components/home/index'
import UploadPage from './components/upload/index'
import { Route, Routes } from "react-router-dom";

const App = () => {

  return (
    <div className="App">
      <Routes>
        <Route path="/" element={<HomePage/>} />
        <Route path="/upload" element={<UploadPage />} />
      </Routes>    
    </div>
  );
}

export default App;
