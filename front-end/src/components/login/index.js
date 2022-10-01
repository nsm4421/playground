import axios from "axios";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Api from "../../Api";

const Index = () => {

    const navigator = useNavigate();
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

    const handleUsername = (e)=>{setUsername(e.target.value);}
    const handlePassowrd = (e)=>{setPassword(e.target.value);}

    const handleVisibility = (e) =>{
        setIsPasswordVisible(!isPasswordVisible);        
    }

    const handleSubmit = async (e) =>{
        
        e.preventDefault();
        setIsLoading(true);

        if (username === ""){
            alert("유저명을 입력하세요");
            setIsLoading(false);
            return;
        }
        if (password === ""){
            alert("비밀번호를 입력하세요");
            setIsLoading(false);
            return;
        }

        await axios
            .post(Api.login.URL, {username, password})
            .then((res)=>{
                // TODO
                if (res.data.resultCode === "SUCCESS"){
                    alert("로그인에 성공하였습니다.");
                    navigator("/");
                    return;
                }
                alert("로그인에 실패하엿습니다.")
            })
            .catch((err)=>{
                console.log(err);
            })
            .finally(()=>{
                setIsLoading(false);
                return;
            });
    }

    
    return (
        <div>

            <h1>Login Page</h1>
           
                <label>Username</label>
                <input id="username" onChange={handleUsername}></input>
                <br/>

                <label>비밀번호</label>
                <input id="password" type={isPasswordVisible?"text":"password"} onChange={handlePassowrd}></input>
                <br/>
  
                <p onMouseOver={handleVisibility} onMouseLeave={handleVisibility}>
                    {isPasswordVisible?"비밀번호 안보임":"비밀번호 보임"}
                </p>
                <br/>

                <button disabled={isLoading} onClick={handleSubmit}>로그인</button>
        </div>
    )
}

export default Index;