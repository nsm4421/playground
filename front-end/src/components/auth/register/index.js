import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const SignUp = () => {


    const navigator = useNavigate();
    // 사용자 입력
    const [username, setUsername] = useState("");
    const [nickname, setNickname] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [passwordConfirm, setPasswordConfirm] = useState("");
    const [sex, setSex] = useState("MALE");
    const [description, setDescription] = useState("");
    const [birthAt, setBirthAt] = useState(new Date());

    // 변수
    const [isLoading, setIsLoading] = useState(false);      // 회원가입 버튼 disabled
    const [isVisible, setIsVisible] = useState(false);      // 비밀번호 보이기/감추기
    const [message, setMessage] = useState("");             // 에러메세지

    // handlers
    const handleEmail=(e)=>{setEmail(e.target.value)};
    const handleNickname=(e)=>{setNickname(e.target.value)};
    const handleUsername=(e)=>{setUsername(e.target.value)};
    const handlePassword=(e)=>{setPassword(e.target.value)};
    const handlePasswordConfirm=(e)=>{setPasswordConfirm(e.target.value)};
    const handleSex=(e)=>{setSex(e.target.options.selectedIndex===0?"MALE":"FEMALE")};
    const handleDescription = (e)=>{setDescription(e.target.value)};
    const handleBirthAt = (e)=>{setBirthAt(e.target.value)};

    const handleVisible = (e)=>{
        e.preventDefault();
        setIsVisible(!isVisible)
    }

    const handleSubmit = (e)=>{
        setIsLoading(true);
        setMessage("");
        e.preventDefault();
        if (password!=passwordConfirm){
            setMessage("비밀번호와 비밀번호확인 값이 일치하지 않습니다.");
            setIsLoading(false);
            return;
        }
        const endPoint = "api/userAccount/register";
        const data = {username, nickname, email, password, sex, description, birthAt}
        console.log(data);
        axios.post(endPoint, data
        ).then((res)=>{
            navigator("/login");            
        }).catch((err)=>{
            setMessage(`에러 발생 >>> ${message}`)
            console.log("Error >>>", err)
        }).finally(()=>{
            setIsLoading(false);
        })
    }

    return (
        <div>
            <h1>회원가입 페이지</h1>
            <p>{message}</p>

            <div>
                <label>유저명</label>
                <input onChange={handleUsername} placeholder="회원가입시 사용할 유저명..."></input>
            </div>              
            <div>
                <label>닉네임</label>
                <input onChange={handleNickname} placeholder="닉네임..."></input>
            </div>
            <div>
                <label>비밀번호</label>
                <input onChange={handlePassword} placeholder="비밀번호..." type={isVisible?"text":"password"}></input>
            </div>
            <div>
                <label>비밀번호 확인</label>
                <input onChange={handlePasswordConfirm} placeholder="비밀번호 다시 입력..." type={isVisible?"text":"password"}></input>
            </div>
            <button onClick={handleVisible}>비밀번호 {isVisible?"감추기":"보이기"}</button>
            <div>
                <label>이메일주소</label>
                <input onChange={handleEmail} placeholder="이메일..."></input>
            </div>
            <div>
                <label>성별</label>
                <select onChange={handleSex}>
                    <option value={"MALE"}>남</option>
                    <option value={"FEMALE"}>여</option>
                </select>
            <div>
                <label>자기소개</label>
                <textarea onChange={handleDescription} placeholder="자기소개..."></textarea>
            </div>
            <div>
                <label>생년월일</label>
                <input type="date" onChange={handleBirthAt}></input>
            </div>
            </div>
            <button onClick={handleSubmit} disabled={isLoading}>회원가입</button>

        </div>
    );
} 
export default SignUp;