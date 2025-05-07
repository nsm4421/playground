import { useEffect, useState } from 'react';
import './App.css';
import BottomNav from './components/BottmNav';
import SignUpForm from './components/SignUpForm';
import WriteArticle from './components/WriteArticle';
import Header from './components/Header';
import Postings from './components/Postings';
import GetPostings from './components/API/GetPostings';

function App() {

  let [tab, setTab] = useState(0)  
  const [postings, setPostings] = useState({});

  // Posting 정보 가져오기
  useEffect(()=>{
   GetPostings().then(
      resJson => {
        setPostings({...resJson})
  })},[tab===0])

  return (
    <div className="App">

      <Header/>
   
      <BottomNav tab={tab} setTab={setTab}/>
      
      {
        tab === 0?<Postings postings={postings}/>:null
      }
      {
        tab === 1?<WriteArticle setTab={setTab}/>:null
      }
      {
        tab === 2?<SignUpForm/>:null
      }
      {
        tab === 3?null:null
      }


    </div>
  );
}

export default App;
