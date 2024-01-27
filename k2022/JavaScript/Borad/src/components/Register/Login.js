import './Register.css'
import { useState } from 'react';
import RegisterBox from './RegisterBox'
import Button from '../utils/Button';
import HandleLogin from '../../api/HandleLogin';
import { useHistory } from 'react-router-dom';
import { Alert } from '@mui/material';
import UserStore from '../../store/UserStore'

const Login = ()=>{

    const history = useHistory();
    const EmailBox = RegisterBox('email');
    const PwBox = RegisterBox('password');
    
    const [userInput, setUserInput] = useState({email:"", password:""});
    const [errMsg, setErrMsg] = useState("");

    const handleUserInput = (newObj)=>{
        setUserInput({...userInput, ...newObj});
    }

    const handleSubmit = async ()=>{
        return await HandleLogin({userInput}).then((res)=>{
            if (res.status){                            // 로그인 성공시
                history.push('/')
            } else {
                console.log(`errCode:${res.errCode} errMsg:${res.errMsg}`)
                setErrMsg(res.errMsg);
            }
        })
    }

    return(
        <div className='register__container'>

            <h2>Login</h2>

            {
                errMsg
                ? <Alert severity='error' onClick={()=>{setErrMsg("")}}>{errMsg}</Alert>
                : null
            }           
           
            <div>
                <EmailBox userInput={userInput} handleUserInput={handleUserInput}/>
                <PwBox  userInput={userInput} handleUserInput={handleUserInput}/>
            </div>
            <Button onClick={handleSubmit} label={'Submit'}/>
        </div>
    );
};


export default Login;