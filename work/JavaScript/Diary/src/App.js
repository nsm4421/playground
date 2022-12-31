import './App.css';
import { useEffect, useState } from 'react';
import MyAppBar from './components/MyAppBar';
import Home from './components/Home';
import Diary from './components/Diary';
import Setting from './components/Setting';
import Pictures from './components/Pictures';
import GetDiaries from './api/GetDiary';

function App() {

  const [tab, setTab] = useState(0);
  const [diaryList, setDiaryList] = useState({});

  const loadData = ()=>{
    GetDiaries().then((res)=>{
      setDiaryList({...res})
    })
  }

  useEffect(()=>{
    loadData()
  }, [])

  const components = [
    <Home setTab={setTab} diaryList={diaryList} setDiaryList={setDiaryList} loadData={loadData}/>, 
    <Diary setTab={setTab} diaryList={diaryList} setDiaryList={setDiaryList}/>,
    <Pictures/>, 
    <Setting/>,
  ]

  return (
    <div className="App" height='100%'>
      <MyAppBar tab={tab} setTab={setTab} diaryList={diaryList} setDiaryList={setDiaryList} loadData={loadData}/>
      
      {
        components[tab]
      }

    </div>
  );
}

export default App;

