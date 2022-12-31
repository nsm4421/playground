import React, { useEffect, useState } from 'react'
import {over} from 'stompjs';
import SockJS from 'sockjs-client';
import './index.css';
import { useNavigate } from 'react-router-dom';

var stompClient =null;
const Index = () => {
    const [privateChats, setPrivateChats] = useState(new Map());     
    const [publicChats, setPublicChats] = useState([]); 
    const [tab,setTab] =useState("CHATROOM");
    const navigator = useNavigate();
    const [userData, setUserData] = useState({
        sender: '',
        receiver: '',
        connected: false,
        message: ''
      });

    const connect =()=>{
        let Sock = new SockJS('http://localhost:8080/ws');
        stompClient = over(Sock);
        stompClient.connect({},onConnected, onError);
    }

    const onConnected = () => {
        setUserData({...userData,"connected": true});
        stompClient.subscribe('/chatroom/public', onMessageReceived);
        stompClient.subscribe('/user/'+userData.sender+'/private', onPrivateMessage);
        userJoin();
    }

    const userJoin=()=>{
          var chatMessage = {
            sender: userData.sender,
            status:"JOIN"
          };
          stompClient.send("/api/v1/chat/message", {}, JSON.stringify(chatMessage));
    }

    const onMessageReceived = (payload)=>{
        var payloadData = JSON.parse(payload.body);
        switch(payloadData.status){
            case "JOIN":
                console.log("JOIN>>>>",payload)
                if(!privateChats.get(payloadData.sender)){
                    privateChats.set(payloadData.sender,[]);
                    setPrivateChats(new Map(privateChats));
                }
                break;
            case "MESSAGE":
                publicChats.push(payloadData);
                setPublicChats([...publicChats]);
                break;
        }
    }
    
    const onPrivateMessage = (payload)=>{
        var payloadData = JSON.parse(payload.body);
        if(privateChats.get(payloadData.sender)){
            privateChats.get(payloadData.sender).push(payloadData);
            setPrivateChats(new Map(privateChats));
        }else{
            let list =[];
            list.push(payloadData);
            privateChats.set(payloadData.sender,list);
            setPrivateChats(new Map(privateChats));
        }
    }

    const onError = (err) => {
        console.log(`Error - ${err}`);   
    }

    const handleMessage =(e)=>{ // 메세지 → 최대 300자 이내
        let v = e.target.value;
        if (v.length>300){
            v = v.slice(v, 300);
        }
        setUserData({...userData,"message": v});
    }

    const sendValue=()=>{
        if (!stompClient){
            return;    
        }
        var chatMessage = {
            sender: userData.sender,
            message: userData.message,
            status:"MESSAGE"
        };
        console.log(chatMessage);
        stompClient.send("/api/v1/chat/message", {}, JSON.stringify(chatMessage));
        setUserData({...userData,"message": ""});
    }

    const sendPrivateValue=()=>{
        if (stompClient) {
          var chatMessage = {
            sender: userData.sender,
            receiver:tab,
            message: userData.message,
            status:"MESSAGE"
          };
          
          if(userData.sender !== tab){
            privateChats.get(tab).push(chatMessage);
            setPrivateChats(new Map(privateChats));
          }
          stompClient.send("/api/v1/chat/private-message", {}, JSON.stringify(chatMessage));
          setUserData({...userData,"message": ""});
        }
    }

    const handleUsername=(e)=>{
        setUserData({...userData, sender:e.target.value});
    }

    const registerUser=(e)=>{
        e.preventDefault();
        connect();
    }

    return (
        <div className="container">
        {userData.connected?
        <div className="chat-box">
            <div className="member-list">
                <ul>
                    <li onClick={()=>{setTab("CHATROOM")}} className={`member ${tab==="CHATROOM" && "active"}`}>Chatroom</li>
                    {[...privateChats.keys()].map((name,index)=>(
                        <li onClick={()=>{setTab(name)}} className={`member ${tab===name && "active"}`} key={index}>{name}</li>
                    ))}
                </ul>
            </div>
            {tab==="CHATROOM" && <div className="chat-content">
                <ul className="chat-messages">
                    {publicChats.map((chat,index)=>(
                        <li className={`message ${chat.sender === userData.sender && "self"}`} key={index}>
                            {chat.sender !== userData.sender && <div className="avatar">{chat.sender}</div>}
                            <div className="message-data">{chat.message}</div>
                            {chat.sender === userData.sender && <div className="avatar self">{chat.sender}</div>}
                        </li>
                    ))}
                </ul>

                <div className="send-message">
                    <input type="text" className="input-message" placeholder="메세지를 입력하세요" value={userData.message} onChange={handleMessage} /> 
                    <button type="button" className="send-button" onClick={sendValue}>send</button>
                </div>
            </div>}
            {tab!=="CHATROOM" && <div className="chat-content">
                <ul className="chat-messages">
                    {[...privateChats.get(tab)].map((chat,index)=>(
                        <li className={`message ${chat.sender === userData.sender && "self"}`} key={index}>
                            {chat.sender !== userData.sender && <div className="avatar">{chat.sender}</div>}
                            <div className="message-data">{chat.message}</div>
                            {chat.sender === userData.sender && <div className="avatar self">{chat.sender}</div>}
                        </li>
                    ))}
                </ul>

                <div className="send-message">
                    <input type="text" className="input-message" placeholder="메세지를 입력하세요" value={userData.message} onChange={handleMessage} /> 
                    <button type="button" className="send-button" onClick={sendPrivateValue}>send</button>
                </div>
            </div>}
        </div>
        :
        <div className="register">
            <input
                id="user-name"
                placeholder="채팅시 사용할 유저명"
                name="userName"
                value={userData.sender}
                onChange={handleUsername}
                margin="normal"
              />
              <button type="button" onClick={registerUser}>
                    입장하기
              </button> 
        </div>}
    </div>
    )
}

export default Index