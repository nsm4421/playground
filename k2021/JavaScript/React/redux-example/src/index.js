import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

import {Provider} from 'react-redux'
import { combineReducers, createStore } from 'redux';

let initState = [{id:0, movie : '타이타닉', star : 5},
                {id:1, movie : '라스트갓파더', star : 1},
                {id:2, movie : '부산행', star : 4},
                {id:3, movie : '어쩌다로맨스', star : 4}];

function reducer(state=initState, action){
  
  if (action.type == '+'){
    let newState = [...state];
    newState[action.id].star ++;
    return newState;

  } else if (action.type == '-'){
    let newState = [...state];
    newState[action.id].star --;
    return newState;
  }  
    else {
    return state;
  }
}

let initState2 = [false, false, false, false];

function reducer2(state=initState2, action){

  if (action.type == 'changed'){
    let newState = [...state];
    newState[action.id] = true;
    return newState;
  }  else {
    return state
  }
}

let store = createStore(combineReducers({reducer, reducer2}));

ReactDOM.render(
  <React.StrictMode>
    <Provider store = {store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
