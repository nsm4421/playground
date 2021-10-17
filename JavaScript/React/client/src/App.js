import ComboBox from './components/ComboBox';
import CheckBox from './components/CheckBox';
import BasicTable from './components/Table';
import './App.css';


function App() {
  return (
    <div>
      <p>콤보박스</p>
      <ComboBox/>

      <p>체크박스</p>
      <CheckBox/>

      <p>테이블</p>
      <div>
       <BasicTable/>
      </div>
      
    </div>        
      )
    }
export default App;
