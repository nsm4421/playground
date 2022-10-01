import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Api from "../../Api";
import Validate from "./Validate";

const Index = () => {

    const navigator = useNavigate();
    const [isLoading, setIsLoading] = useState(false);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

    const handleVisibility = (e) =>{
        setIsPasswordVisible(!isPasswordVisible);        
    }

    const handleSubmit = async (e) =>{

        const email = document.getElementById("email").textContent;
        const username = document.getElementById("username").textContent;
        const password = document.getElementById("password").textContent;
        const passwordConfirm = document.getElementById("password-confirm").textContent;
        await Validate("email", email);
        await Validate("username", username);
        await Validate("password", {password, passwordConfirm});

        setIsLoading(true);
        e.preventDefault();
        let xhr = new XMLHttpRequest();
        xhr.open(Api.register.METHOD, Api.register.URL); 
        xhr.onload = (e) => { 
        if(e.target.response.resultCode){
            alert("회원가입에 성공하였습니다.");
            navigator("/login");
        } else {
            alert("회원가입에 실패하였습니다.");
            console.log(e.target.response);
        }
        }; 
        const formData = new FormData(document.getElementById("sign-up-form")); 
        xhr.send(formData);
        setIsLoading(false);
    }

    
    return (
        <div>

            <h1>Sign Up Page</h1>

            <form id="sign-up-form" encType="multipart/form-data" onSubmit={handleSubmit}>
                
                <label>이메일</label>
                <input id="email" name="email"></input>
                <br/>

                <label>Username</label>
                <input id="username" name="username"></input>
                <br/>

                <label>비밀번호</label>
                <input id="password" name="password" type={isPasswordVisible?"text":"password"}></input>
                <br/>
                
                <label>비밀번호 확인</label>
                <input id="password-confirm" name="password-confirm" type={isPasswordVisible?"text":"password"}></input>
                <br/>

                <p onMouseOver={handleVisibility} onMouseLeave={handleVisibility}>
                    {isPasswordVisible?"비밀번호 안보임":"비밀번호 보임"}
                </p>
                <br/>

                <button type="submit" disabled={isLoading}>회원가입</button>
            
            </form>
        </div>
    )
}

export default Index;