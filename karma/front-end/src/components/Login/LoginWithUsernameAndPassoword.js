import { useState } from 'react';
import { Col, Row } from 'react-bootstrap';
import { Form } from 'react-bootstrap';
import Button from 'react-bootstrap/Button';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Btn = ({onClick, label, isLoading, variant})=>{
    return <Button variant={variant??"primary"} style={{width:'100px'}} disabled={isLoading} onClick={onClick}>{label}</Button>
}

const LoginWithUsernameAndPassword = () => {
    
    const baseUrl = "http://localhost:8080/api/v1/user";
    const navigator = useNavigate();
    
    // 유저가 입력한 정보
    const [userInput, setUserInput] = useState({
        username:"",
        password:"",
    });
        
    const [controlls, setControlls] = useState({
        showPassword:false,                     // 비밀번호 보이기 여부
        loadingSubmit:false                     // 제출 후 로딩중 여부
    })
    
    // userInput object 다루는 함수
    const handleUserInput = (key) => (newValue) => {
        setUserInput({...userInput, [key]:newValue})
    };

    // controlls object 다루는 함수
    const handleControllButtons = (key) => (newValue) => {
        setControlls({...controlls, [key]:newValue})
    };

    // 제출후 유효성 검사 버튼 동작
    const handleSubmit = (e)=>{
        // 로딩중 버튼 못 누르게 만들기
        handleControllButtons("loadingSubmit")(true);
        // 요청 보낼 주소 & 데이터
        const requestUrl = `${baseUrl}/login`
        const data = {username:userInput.username, password:userInput.password}
        e.preventDefault();
        // 요청 보내기
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.resultCode === "SUCCESS"){
                const authToken = res.result.authToken??""
                localStorage.setItem("karma-token", authToken);
                navigator("/")
            } else {
                alert("Login Failed ~ !")
            }
        })
        .catch((e)=>{
            console.log(e);
            alert("ERROR");
        })
        .finally(()=>{
            handleControllButtons("loadingSubmit")(false);
        })
    }

    const handleClickShowPassoword = ()=>{
        handleUserInput('showPassword')(!controlls.showPassword);
    }

    return (
        <Form>

            {/* 유저명 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Username</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={e=>handleUserInput('username')(e.target.value)}
                            style={{textAlign:'left'}} type="text" placeholder="Username..."/>
                    </Col>                
                </Row>
            </Form.Group>

            {/* 비밀번호 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Password</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={e=>handleUserInput('password')(e.target.value)}
                            style={{textAlign:'left'}} 
                            type={controlls.showPassword ? null : "password"} 
                            placeholder="Password..."/>
                    </Col>
                    <Col sm={2}>
                        <Btn label={controlls.showPassword?"Hide":"Show"} onClick={handleClickShowPassoword}/>
                    </Col>                    
                </Row>
            </Form.Group>

            <Btn variant={"success"} label={"Submit"} isLoading={controlls.loadingSubmit} onClick={handleSubmit}/>

      </Form>
    );
}

export default LoginWithUsernameAndPassword;