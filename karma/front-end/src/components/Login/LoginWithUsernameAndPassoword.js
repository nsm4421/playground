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

    const [userInput, setUserInput] = useState({
        username:"",
        password:"",
    });
        
    const [controlls, setControlls] = useState({
        showPassword:false,                   
        isLoading:false                    
    })
    
    const handleUserInput = (key) => (newValue) => {
        setUserInput({...userInput, [key]:newValue})
    };

    const handleControllButtons = (key) => (newValue) => {
        setControlls({...controlls, [key]:newValue})
    };

    const handleSubmit = (e)=>{
        handleControllButtons("isLoading")(true);
        const requestUrl = `${baseUrl}/login`
        const data = {username:userInput.username, password:userInput.password}
        e.preventDefault();
        axios.post(requestUrl, data)
        .then((res)=>{
            console.log(res)
            if (res.data.resultCode === "SUCCESS"){
                const authToken = res.data.result.authToken??""
                localStorage.setItem("karma-token", authToken);
                navigator("/")
            } else {
                alert("Login Failed ~ !")
            }
        })
        .catch((e)=>{
            alert(`Error : ${e.response.data.resultCode}`);
        })
        .finally(()=>{
            handleControllButtons("isLoading")(false);
        })
    }

    const handleClickShowPassoword = ()=>{
        handleControllButtons('showPassword')(!controlls.showPassword);
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

            <Btn variant={"success"} label={"Submit"} isLoading={controlls.isLoading} onClick={handleSubmit}/>

      </Form>
    );
}

export default LoginWithUsernameAndPassword;