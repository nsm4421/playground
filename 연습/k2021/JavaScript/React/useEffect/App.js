import './App.css';
import {useState, useEffect} from 'react';

function App() {

  let [showMsg, changeShowMsg] = useState(true);
  let [userInput, changeUserInput] = useState('');

  useEffect(()=>{
    
    let timer = setTimeout(()=>{
      changeShowMsg(false);
    }, 2000)
    return ()=>{
      clearTimeout(timer)
      console.log('2초 경과')
    }
  },[showMsg])


  return (
    <div>     
      {
        showMsg
        ? <h1> 2초 후 메세지 사라지는 메세지 </h1>
        : null
      }

      <input onChange = {(event)=>{changeUserInput(event.target.value)}}/>

    </div>
  );
}

export default App;
