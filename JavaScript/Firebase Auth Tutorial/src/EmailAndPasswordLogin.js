import { useState } from "react";
import app from './Firebase'
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";

// 이메일, 비밀번호를 받아서 로그인 여부를 처리하는 함수
const LoginWithEmailAndPassword = ({email, password})=>{
    const auth = getAuth(app);
    return signInWithEmailAndPassword(auth, email, password)
      .then((userCredential) => {
        // 로그인 성공시
        const user = userCredential.user;
        return {status:'success', user:user}
    })
    .catch((error) => {
        // 로그인 실패
        const errorCode = error.code;
        const errorMessage = error.message;
        return {status:'error',  errorCode:errorCode, errorMessage:errorMessage}
      });
}

// 현재 로그인되어 있는 user정보를 콘솔에 찍기
const PrintCurrentUser = ()=>{
    const auth = getAuth(app)
    console.log(auth.currentUser)
}

const EmailAndPasswordLogin = ()=>{

    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")

    return (
        <div>
            
            <h1>이메일과 비밀번호로 로그인 기능 구현하기</h1>

            <div style={{border:"1px solid"}}>

                <h3>로그인</h3>

                <p>Email</p>
                <input onChange={(e)=>{setEmail(e.target.value)}} placeholder="Email"></input>
                
                <p>Password</p>
                <input onChange={(e)=>{setPassword(e.target.value)}} placeholder="Password"></input>

                <button onClick={()=>{
                    LoginWithEmailAndPassword({email:email,password:password})
                    .then((res)=>{
                        if (res.status === 'success'){
                            alert('로그인 성공')
                        } else if (res.status === 'error') {
                            alert(`로그인 실패 | error메세지 : ${res.errorMessage}`)
                        } else {
                            alert('버그.....?')
                        }
                    })
                }}>로그인</button>

                <button onClick={PrintCurrentUser}>콘솔에 현재 로그인된 정보 찍기</button>

            </div>

        </div>
    )
}

export default EmailAndPasswordLogin;
