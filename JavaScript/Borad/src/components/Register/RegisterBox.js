import './Register.css'
import { useEffect } from 'react';
import InputBox from '../utils/InputBox'

// User ID 입력 박스
const NickNameBox = ({userInput, handleUserInput})=>{

    // // 닉네임 입력이 10칸이 넘어가는 경우 -> Alert창
    // useEffect(()=>{
    //     if (userInput.nickName.length>15){
    //         handleUserInput({nickName : userInput.nickName.slice(0, 15)})
    //         alert("number of letter within 5~15")
    //     }    
    // }, [userInput.nickName])    

    return (
        <InputBox label={'Nick Name'} objKey={'nickName'} userInput={userInput}
            helperText = {'Combinate alphabet, number and special symbols / number of letter within 5~15'}
            handleUserInput={handleUserInput}
        />
    )
}

// 비밀번호 입력 Box
const PwBox = ({userInput, handleUserInput})=>{
    
    // useEffect(()=>{
    //     if (userInput.password.length>15){
    //         handleUserInput({password : userInput.password.slice(0, 15)})
    //         alert("number of letter within 5~15")
    //     }  
    // }, [userInput.password])

    return (
        <InputBox label={'Password'} objKey={'password'} userInput={userInput}
            helperText = {'Combinate alphabet, number and special symbols / number of letter within 5~15'}
            handleUserInput={handleUserInput} inputType={'password'}
        />
    )
}

// 비밀번호 확인 Box
const RePwBox = ({userInput, handleUserInput})=>{
    
    // useEffect(()=>{
    //     if (userInput.password.length>15){
    //         handleUserInput({rePassword : userInput.rePassword.slice(0, 15)})
    //         alert("number of letter within 5~15")
    //     }  
    // }, [userInput.rePassword])

    return (
        <InputBox label={'Confirm'} objKey={'rePassword'} userInput={userInput}
            helperText = {'Press password again'}
            handleUserInput={handleUserInput} inputType={'password'}
        />
    )
}

// 이메일 주소 Box
const EmailBox = ({userInput, handleUserInput})=>{

    return (
        <InputBox label={'Email'} objKey={'email'} userInput={userInput}
            helperText = {'Email address for login'}
            handleUserInput={handleUserInput} inputType={'email'}
        />  
    )
}

const RegisterBox = (type)=>{
    switch (type){
        case 'nickName':
            return NickNameBox
        case 'password':
            return PwBox
        case 'rePassword':
            return RePwBox
        case 'email':
            return EmailBox
        default:
            return null
    }
};

export default RegisterBox;