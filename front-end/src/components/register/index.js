import axios from "axios";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Api from "../../Api";

const Index = () => {

    const navigator = useNavigate();
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [passwordConfirm, setPasswordConfirm] = useState("");
    const [email, setEmail] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

    const handleUsername = (e)=>{setUsername(e.target.value);};
    const handlePassword = (e)=>{setPassword(e.target.value);};
    const handlePasswordConfirm = (e)=>{setPasswordConfirm(e.target.value);};
    const handleEmail= (e)=>{setEmail(e.target.value);};

    const handleVisibility = (e) =>{
        setIsPasswordVisible(!isPasswordVisible);        
    }

    const handleSubmit = async (e) =>{
        if (email === ""){
            alert("이메일을 입력해주세요");
            return;
        }
        if (username === ""){
            alert("유저명을 입력해주세요");
            return;
        }
        if (password === ""){
            alert("패스워드을 입력해주세요");
            return;
        }
        if (password !== passwordConfirm){
            alert("패스워드와 패스워드 확인값이 일치하지 않습니다.");
            return;
        }
        await axios
            .post(Api.register.URL,{
                username, password, email
            })
            .then((res)=>{
                if (res.data.resultCode === "SUCCESS"){
                    alert("회원가입에 성공하였습니다");
                    navigator("/login");
                    return;
                }
                alert("회원가입에 실패하였습니다. - 서버 에러")
                return;
            })
            .catch((err)=>{
                const errCode = err.response.data.resultCode;
                alert(`회원가입에 실패하였습니다. - 에러코드 : ${errCode}`)
                console.log(err);
                return;
            })
            .finally(()=>{
                setIsLoading(false);
            });
    }

    
    return (
        <div>

            <h1>Sign Up Page</h1>
                          
            <label>이메일</label>
            <input id="email" onChange={handleEmail}></input>
            <br/>

            <label>Username</label>
            <input id="username" onChange={handleUsername}></input>
            <br/>

            <label>비밀번호</label>
            <input id="password" onChange={handlePassword} type={isPasswordVisible?"text":"password"}></input>
            <br/>
            
            <label>비밀번호 확인</label>
            <input id="password-confirm" onChange={handlePasswordConfirm} type={isPasswordVisible?"text":"password"}></input>
            <br/>

            <p onMouseOver={handleVisibility} onMouseLeave={handleVisibility}>
                {isPasswordVisible?"비밀번호 안보임":"비밀번호 보임"}
            </p>
            <br/>

            <button type="submit" disabled={isLoading} onClick={handleSubmit}>회원가입</button>
            
         
        </div>
    )
}

export default Index;