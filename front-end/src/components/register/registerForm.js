import axios from "axios";
import Form from 'react-bootstrap/Form';
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Container } from "react-bootstrap";
import {Button} from "react-bootstrap";
import Api from "../../Api";
import { FiMail }  from '@react-icons/all-files/fi/FiMail';
import { BiUserCircle }  from '@react-icons/all-files/bi/BiUserCircle';
import { FiKey }  from '@react-icons/all-files/fi/FiKey';
import { AiOutlineEyeInvisible }  from '@react-icons/all-files/ai/AiOutlineEyeInvisible';
import { AiOutlineEye }  from '@react-icons/all-files/ai/AiOutlineEye';

const RegisterForm = () => {

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
        <Container>
        
            <Form>
                <Form.Group className="mb-3">
                    <FiMail/>
                    <Form.Label>이메일</Form.Label>
                    <Form.Control type="email" placeholder="이메일 주소를 입력해주세요" 
                        value={email} onChange={handleEmail}/>
                    {
                        email === ""
                        ? <Form.Text className="text-muted">이메일을 입력하세요</Form.Text>
                        : null
                    }
                </Form.Group>

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
                </Form.Group>
                
                <Form.Group className="mb-3">
                    <FiKey/>
                    <Form.Label>비밀번호 확인</Form.Label>
                    
                    <Form.Control type={isPasswordVisible?"text":"password"} placeholder="비밀번호를 입력해주세요"
                        value={passwordConfirm} onChange={handlePasswordConfirm}/>                            
                    
                    <Form.Text className="text-muted">
                        { 
                            password=== passwordConfirm 
                            ? null 
                            : <span onMouseOver={handleVisibility} onMouseLeave={handleVisibility}>
                                {
                                    isPasswordVisible
                                    ? <span> <AiOutlineEyeInvisible/> {'비밀번호 가리기'} </span>
                                    : <span> <AiOutlineEye/> {'비밀번호 보이기'} </span>
                                }
                            </span>
                        }
                    </Form.Text>

                </Form.Group>

                <Button variant="success" type="submit" disabled={isLoading} onClick={handleSubmit}>
                    회원가입
                </Button>

            </Form>

            </Container>
    )
}

export default RegisterForm;