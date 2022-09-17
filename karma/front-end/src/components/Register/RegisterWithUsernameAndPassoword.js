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
        validEmail:"",                          // 서버로부터 사용 가능한 이메일라고 확인 받은 이메일 저장
        validUsername:""                        // 서버로부터 사용 가능한 유저명이라고 확인 받은 유저명 저장
    });
    
    
    const [controlls, setControlls] = useState({
        isValidEmail:false,                     // 이메일 유효 여부
        isValidUsername:false,                  // 유저명 유효 여부
        isValidPassword:false,                  // 비밀번호 유효 여부
        showPassword:false,                     // 비밀번호 보이기 여부
        loadingEmailButton:false,               // 이메일 유효성 로딩중 여부
        loadingUsernameButton:false,            // 유저명 유효성 로딩중 여부
        loadingSubmit:false                     // 제출 후 로딩중 여부
    })
    
    // 이메일 유효성 여부
    useEffect(()=>{
        handleControllButtons("isValidEmail")(userInput.email !== "" & userInput.email !== userInput.validEmail);
    }, [userInput.email]);

    // 유저명 유효성 여부
    useEffect(()=>{
        handleControllButtons("isValidUsername")(userInput.username !== "" & userInput.username !== userInput.validUsername);
    }, [userInput.username]);

    // 비밀번호 유효성 여부
    useEffect(()=>{
        handleControllButtons("isValidPassword")((userInput.password !== "") & (userInput.password === userInput.confirmPassword));
    }, [userInput.password, userInput.confirmPassword]);
    

    // userInput object 다루는 함수
    const handleUserInput = (key) => (newValue) => {
        setUserInput({...userInput, [key]:newValue})
    };

    // controlls object 다루는 함수
    const handleControllButtons = (key) => (newValue) => {
        setControlls({...controlls, [key]:newValue})
    };

    // 이메일 유효성 검사 버튼 동작
    const handleClickEmailValidateButton = (e)=>{
        // 로딩중 버튼 못 누르게 만들기
        handleControllButtons('loadingEmailButton')(true);
        // 요청 보낼 주소 & 데이터
        const requestUrl = `${baseUrl}/check/is-exist-email`
        const data = {email:userInput.email}
        e.preventDefault();
        // 요청 보내기
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.result === true){
                handleUserInput('validEmail')(userInput.email);
        }})
        .catch((e)=>{
            console.log(e);
            alert("ERROR");
        })
        .finally(()=>{
            handleControllButtons('loadingEmailButton')(false);
        })
    }

    // 유저명 유효성 검사 버튼 동작
    const handleClickUsernameValidation = (e)=>{
        // 로딩중 버튼 못 누르게 만들기
        handleControllButtons('loadingUsernameButton')(true);
        // 요청 보낼 주소 & 데이터
        const requestUrl = `${baseUrl}/check/is-exist-username`
        const data = {username:userInput.username}
        e.preventDefault();
        // 요청 보내기
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.result === true){handleControllButtons('loadingUsernameButton')(true)};
            handleUserInput('validUsername')(userInput.username);
        })
        .catch((e)=>{
            console.log(e);
            alert("ERROR");
        })
        .finally(()=>{
            // 버튼 살리기
            handleControllButtons('loadingUsernameButton')(false);
        })
    }

    // 제출후 유효성 검사 버튼 동작
    const handleSubmit = (e)=>{
        // 로딩중 버튼 못 누르게 만들기
        handleControllButtons("loadingSubmit")(true);
        // 요청 보낼 주소 & 데이터
        const requestUrl = `${baseUrl}/register`
        const data = {email:userInput.email, username:userInput.username, password:userInput.password, provider:"NONE"}
        e.preventDefault();
        // 요청 보내기
        axios.post(requestUrl, data)
        .then((res)=>{
            if (res.resultCode === "SUCCESS"){
                alert(`Sign Up Succeed ~ ${res.result.username}`);
                navigator("/login");
            } else {
                alert(`Sign Up Failed ~ !`);
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

    useEffect(()=>{
        handleUserInput('isValidEmail')(false);
    }, [userInput.email]);
    
    useEffect(()=>{        
        handleUserInput('isValidUsername')(false);
    }, [userInput.username]);

    return (
        <Form>
            {/* 이메일 주소 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Email Address</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={e=>handleUserInput('email')(e.target.value)}
                            style={{textAlign:'left'}} type="email" placeholder="Email Address..."/>
                    </Col>
                    <Col sm={2}>
                        {controlls.isValidEmail
                        ?null
                        :<Btn isLoading={controlls.loadingEmailButton} label={"Check"} onClick={handleClickEmailValidateButton}/>}
                    </Col>                    
                </Row>
                <Form.Text className="text-muted d-flex">
                    {controlls.isValidEmail?"You may use this email":"Check email validation"}
                </Form.Text>
            </Form.Group>

            {/* 유저명 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Username</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={e=>handleUserInput('username')(e.target.value)}
                            style={{textAlign:'left'}} type="text" placeholder="Username..."/>
                    </Col>
                    <Col sm={2}>
                        <Btn isLoading={controlls.loadingUsernameButton} label={"Check"} onClick={handleClickUsernameValidation}/>
                    </Col>                    
                </Row>
                <Form.Text className="text-muted d-flex">
                    {controlls.isValidUsername?"You may use this username":"Check username validation"}
                </Form.Text>
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
            
            {/* 비밀번호 확인*/}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Password Confirm</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={e=>handleUserInput('passwordConfirm')(e.target.value)}
                            style={{textAlign:'left'}} 
                            type={controlls.showPassword ? null : "password"} 
                            placeholder="Password Confirm..."/>
                    </Col>            
                </Row>
                <Form.Text className="text-muted d-flex">
                    {controlls.isValidPassword?"password and confirm password is not matched":null}
                </Form.Text>
            </Form.Group>

            <Btn variant={"success"} label={"Submit"} isLoading={controlls.loadingSubmit} onClick={handleSubmit}>Submit</Btn>

      </Form>
    );
}

export default RegisterWithUsernameAndPassoword;