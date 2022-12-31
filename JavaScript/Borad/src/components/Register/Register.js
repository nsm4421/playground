import './Register.css'
import { useEffect, useState } from 'react';
import RegisterBox from './RegisterBox'
import ValidateRegister from './ValidateRegister'
import Button from '../utils/Button'
import HandleRegister from '../../api/HandleRegister';
import { useHistory } from 'react-router-dom';
import { Alert } from '@mui/material';


const Register = ()=>{

    const history = useHistory();
    const NickNameBox = RegisterBox('nickName');
    const PwBox = RegisterBox('password');
    const RePwBox = RegisterBox('rePassword');
    const EmailBox = RegisterBox('email');

    const [userInput, setUserInput] = useState({nickName:"", password:"", rePassword:"", email:""});
    const [msg, setMsg] = useState("");

    const handleUserInput = (newObj)=>{
        setUserInput({...userInput, ...newObj});
    }

    const handleSubmit = ()=>{
        // 사용자 입력 check
        const validation = ValidateRegister(userInput);
        if (!validation.status){
            setMsg(validation.msg)
            return
        }
        HandleRegister({userInput}).then((res)=>{
            if (!res.status){
                setMsg(res.msg);
                return
            } else {
                history.push('/login')
            }
        })
    }

    return(
        <div className='register__container'>
            
            <h2>Sign Up</h2>

            {
                msg
                ? <Alert severity='error' onClick={()=>{setMsg("")}}>{msg}</Alert>
                : null
            }                  
           
            <div style={{marginTop:'10px', marginBottom:'10px'}}>
                <EmailBox userInput={userInput} handleUserInput={handleUserInput}/>
                <NickNameBox userInput={userInput} handleUserInput={handleUserInput}/>
                <PwBox  userInput={userInput} handleUserInput={handleUserInput}/>
                <RePwBox  userInput={userInput} handleUserInput={handleUserInput}/>
            </div>
            <Button onClick={handleSubmit} label={'Register'}/>
       
        </div>
    );
};


export default Register;