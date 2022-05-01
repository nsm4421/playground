import { useState } from "react";
import app from './Firebase'
import { getAuth, createUserWithEmailAndPassword } from "firebase/auth";

// 이메일, 비밀번호를 받아서 회원가입을 처리하는 함수
const SignUpWithEmailAndPassword = ({email, password})=>{
    const auth = getAuth(app);
    createUserWithEmailAndPassword(auth, email, password)
      .then((userCredential) => {
        // 회원가입 성공
        const user = userCredential.user;
        alert('회원가입 성공')
    })
    .catch((error) => {
        // 회원가입 실패
        const errorCode = error.code;
        const errorMessage = error.message;
        alert(`회원가입 실패 | errorMessage:${errorMessage}`)
    });
}


const EmailAndPasswordSignUp = ()=>{

    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")

    return (
        <div>
            
            <h1>이메일과 비밀번호로 인증기능 구현하기</h1>

            <div style={{border:"1px solid"}}>

                <h3>회원가입</h3>

                <p>Email</p>
                <input onChange={(e)=>{setEmail(e.target.value)}} placeholder="Email"></input>
                
                <p>Password</p>
                <input onChange={(e)=>{setPassword(e.target.value)}} placeholder="Password"></input>
            
                <button onClick={()=>{SignUpWithEmailAndPassword({email:email,password:password})}}>회원가입</button>

            </div>    

        </div>
    )
}

export default EmailAndPasswordSignUp;
