import { useEffect, useState } from 'react';
import { Col, InputGroup, Row, Tooltip } from 'react-bootstrap';
import { Form } from 'react-bootstrap';
import Button from 'react-bootstrap/Button';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Btn = ({onClick, label, isLoading, variant})=>{
    return <Button variant={variant??"primary"} style={{width:'100px'}} disabled={isLoading} onClick={onClick}>{label}</Button>
}

const RegisterWithUsernameAndPassoword = () => {
    
    const baseUrl = "http://localhost:8080/api/v1/user";
    const navigator = useNavigate();
    
    // 유저가 입력한 정보
    const [userInput, setUserInput] = useState({
        email:"",
        username:"",
        password:"",
        confirmPassword:"",
    });    
    
    const [controlls, setControlls] = useState({
        showPassword:false,                    
        isLoading:false,                    
    })
      
    const handleUserInput = (key) => (newValue) => {
        setUserInput({...userInput, [key]:newValue})
    };

    const handleControllButtons = (key) => (newValue) => {
        setControlls({...controlls, [key]:newValue})
    };

    // 이메일 유효성 검사 버튼 동작
    const handleClickEmailValidateButton = (e)=>{
        handleControllButtons('isLoading')(true);
        const requestUrl = `${baseUrl}/check/is-exist-email`
        const data = {email:userInput.email}
        e.preventDefault();
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.data.resultCode !== "SUCCESS"){
                alert("Error on server...");
                return;
            }
            if (res.data.result){
                alert("Email is duplicated...")                
                return;
            } 
            alert("You may use this email...")
        })
        .catch((e)=>{
            alert("Error on server...");
        })
        .finally(()=>{
            handleControllButtons('isLoading')(false);
        })
    }

    // 유저명 유효성 검사 버튼 동작
    const handleClickUsernameValidation = (e)=>{
        handleControllButtons('isLoading')(true);
        const requestUrl = `${baseUrl}/check/is-exist-username`
        const data = {username:userInput.username}        
        console.table(data);
        e.preventDefault();
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.data.resultCode !== "SUCCESS"){
                alert("Error on server...");
                return;
            }
            if (res.data.result){
                alert("Username is duplicated...")                
                return;
            } 
            alert("You may use this usermane...")
        })
        .catch((e)=>{
            alert("Error on server...");
        })
        .finally(()=>{
            handleControllButtons('isLoading')(false);
        })
    }

    // 제출후 유효성 검사 버튼 동작
    const handleSubmit = (e)=>{

        if (userInput.password!==userInput.confirmPassword){
            alert("Password and confirm password is not same!");
            return;
        }

        handleControllButtons("isLoading")(true);
        const requestUrl = `${baseUrl}/register`
        const data = {email:userInput.email, username:userInput.username, password:userInput.password, provider:"EMAIL"}
        e.preventDefault();
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.data.resultCode === "SUCCESS"){
                alert(`Sign Up Succeed ~ ${res.data.result.username}`);
                navigator("/login");
                return;
            }
            alert(`Sign Up Failed ~ !`);
        })
        .catch((e)=>{
            alert(`Error : ${e.response.data.resultCode}`);
        })
        .finally(()=>{
            handleControllButtons("isLoading")(false);
        })
    }

    const handleClickShowPassoword = ()=>{ handleControllButtons('showPassword')(!controlls.showPassword);}

    return (
        <Form>
            {/* 이메일 주소 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Email Address</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control value={userInput.email} onChange={e=>handleUserInput('email')(e.target.value)}
                            style={{textAlign:'left'}} type="email" placeholder="Email Address..."/>
                    </Col>
                    <Col sm={2}>
                        <Btn isLoading={controlls.isLoading} label={"Check"} onClick={handleClickEmailValidateButton}/>
                    </Col>                    
                </Row>
            </Form.Group>

            {/* 유저명 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Username</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control value={userInput.username} onChange={e=>handleUserInput('username')(e.target.value)}
                            style={{textAlign:'left'}} type="text" placeholder="Username..."/>
                    </Col>
                    <Col sm={2}>
                        <Btn isLoading={controlls.isLoading} label={"Check"} onClick={handleClickUsernameValidation}/>
                    </Col>                    
                </Row>
                <Form.Text className="text-muted d-flex">
                    Combinate 3~10 letters
                </Form.Text>
            </Form.Group>


            {/* 비밀번호 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Password</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control value={userInput.password}
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
            
            {/* 비밀번호 확인*/}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Password Confirm</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control value={userInput.confirmPassword}
                            onChange={e=>handleUserInput('confirmPassword')(e.target.value)}
                            style={{textAlign:'left'}} 
                            type={controlls.showPassword ? null : "password"} 
                            placeholder="Password Confirm..."/>
                    </Col>            
                </Row>
                <Form.Text className="text-muted d-flex">
                    {controlls.isValidPassword?"password and confirm password is not matched":null}
                </Form.Text>
            </Form.Group>

            <Btn variant={"success"} label={"Submit"} isLoading={controlls.isLoading} onClick={handleSubmit}>Submit</Btn>

      </Form>
    );
}

export default RegisterWithUsernameAndPassoword;