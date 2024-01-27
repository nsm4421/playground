import React, {useState} from 'react';
import './App.css';

function App() {

  // State
  let [titles, func_title] = useState(['카르마', '질리언', '트위치', '베이가']);
  let [positions, func_position] = useState(['서폿', '미드', '원딜', '미드']);
  let [likes, func_like] = useState([0,0,0,0]);
  let [showModal, func_modal] = useState([false, false, false, false]);
  let [userInput, func_userInput] = useState('');

  let skillSets = {
    '카르마' : {'Q' : '내면의 열정', 'W' : '굳은 결의', 'E' : '고무', 'R' : '만트라'}, 
    '베이가' : {'Q' : '사악한 일격', 'W' : '암흑 물질', E : '사건의 지평선', 'R' : '태초의 폭발'},
    '트위치' : {'Q' : '매복', W : '독약 병', E : '오염', 'R' : '만트라'}, 
    '질리언' : {'Q' : '시한폭탄', 'W' : '되감기', 'E' : '시간 왜곡', 'R' : '시간역행'}    
  }

  // 좋아요 숫자 늘려주는 함수
  function increaseLike(idx){
    var newArray = [...likes];
    newArray[idx]++;
    func_like(newArray)
  }

  // Modal 렌더링 여부 변경
  function changeModal(idx){
    var show = [...showModal];
    show[idx] = !show[idx];
    func_modal(show);
  }

  // Post 컴퍼넌트
  function Post(idx){
    if ((userInput == '') | (userInput == positions[idx])){
      return (  
        <div> 
        <h3 onClick={()=>{changeModal(idx)}}>{titles[idx]}</h3>
        <span onClick={ ()=>{increaseLike(idx)} }>👍  {likes[idx]}</span>
        <p>{positions[idx]}</p>
        <p></p>
        {
          showModal[idx]            
          ? <Modal skills = {skillSets[titles[idx]]}/>
          : null
        }       
        <hr/>
      </div>
      );   
    }      
 }

  return (
    <div className="App">
      
      
      <div className="nav">
        <p>검색하고자 하는 Position 입력 ☛☛☛☛☛☛☛☛☛☛☛☛☛☛ </p>
        <input onChange = {(e)=>{func_userInput(e.target.value)}}/>
      </div>

    
    {[0,1,2,3].map(Post)}
ㅇ

    </div>
  );
}


function Modal(props){
  return (
    <div>
      <div className="modal">

        <h4>skillSets</h4>
        <p>Q : {props['skills']['Q']}</p>
        <p>W : {props['skills']['W']}</p>
        <p>E : {props['skills']['E']}</p>
        <p>R : {props['skills']['R']}</p>
      </div>
    </div>
  )
}


export default App;
