import axios from "axios";
import Form from 'react-bootstrap/Form';
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Container } from "react-bootstrap";
import {Button} from "react-bootstrap";
import Api from "../../../utils/Api";
import { BiUserCircle }  from '@react-icons/all-files/bi/BiUserCircle';
import { FiKey }  from '@react-icons/all-files/fi/FiKey';
import { AiOutlineEyeInvisible }  from '@react-icons/all-files/ai/AiOutlineEyeInvisible';
import { AiOutlineEye }  from '@react-icons/all-files/ai/AiOutlineEye';
import textUtil from "../../../utils/textUtil";

const LoginForm = () => {

    const navigator = useNavigate();
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

    const handleUsername = textUtil(30, setUsername);
    const handlePassword = textUtil(30, setPassword);

    const handleVisibility = (e) =>{
        setIsPasswordVisible(!isPasswordVisible);        
    }

    const handleSubmit = async (e) =>{
        
        e.preventDefault();
        setIsLoading(true);

        if (username === ""){
            setIsLoading(false);
            return;
        }
        if (password === ""){
            setIsLoading(false);
            return;
        }

        await axios
            .post(Api.login.URL, {username, password})
            .then((res)=>{
                if (res.data.resultCode === "SUCCESS"){
                    const token = res.data.result.token;
                    localStorage.setItem("token", token);
                    alert("로그인에 성공하였습니다.");
                    navigator("/");
                    return;
                }
                alert("로그인에 실패하였습니다.")
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
        <Container>

            <Form.Group className="mb-3">
                <BiUserCircle/>
                <Form.Label>유저명</Form.Label>
                <Form.Control type="email" placeholder="유저명 주소를 입력해주세요" 
                    value={username} onChange={handleUsername}/>
                {
                    username === ""
                    ? <Form.Text className="text-muted">유저명을 입력하세요</Form.Text>
                    : null
                }
            </Form.Group>

            <Form.Group className="mb-3">
                <FiKey/>
                <Form.Label>비밀번호</Form.Label>
                <Form.Control type={isPasswordVisible?"text":"password"} placeholder="비밀번호를 입력해주세요" 
                    value={password} onChange={handlePassword}/>
                    <Form.Text className="text-muted" onMouseOver={handleVisibility} onMouseLeave={handleVisibility}>
                        {
                            isPasswordVisible 
                            ? <span> <AiOutlineEyeInvisible/> {'비밀번호 가리기'} </span>
                            : <span> <AiOutlineEye/> {'비밀번호 보기'} </span>
                        }
                    </Form.Text>
            </Form.Group>
                
            <Button variant="success" type="submit" disabled={isLoading} onClick={handleSubmit}>
                로그인
            </Button>

        </Container>
    )
}

export default LoginForm;