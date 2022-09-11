import { useEffect, useState } from 'react';
import { Col, InputGroup, Row, Tooltip } from 'react-bootstrap';
import { Form } from 'react-bootstrap';
import Button from 'react-bootstrap/Button';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const RegisterWithUsernameAndPassoword = () => {
    
    const Btn = ({onClick, label})=>{
        return <Button variant="success" style={{width:'100px'}} onClick={onClick}>{label}</Button>
    }
    const baseUrl = "api/v1/user";
    const navigator = useNavigate();
    const [userInput, setUserInput] = useState({
        email:"",
        isValidEmail:false,
        username:"",
        isValidUsername:false,
        password:"",
        confirmPassword:"",
        showPassword:false
    });

    const handleUserInput = (key) => (newValue) => {
        setUserInput({...userInput, [key]:newValue})
    };

    const handleClickEmailValidateButton = (e)=>{
        const requestUrl = `${baseUrl}/~~~`
        e.preventDefault();
        // TODO : API 개발
        // axios.get(requestUrl)
        // .then((res)=>{
        //     handleUserInput('isValidUsername')(res.result);
        // })
        // .catch((e)=>{
        //     console.log(e);
        //     alert("ERROR");
        // })
        handleUserInput('isValidEmail')(true);
    }

    const handleClickUsernameValidation = (e)=>{
        const requestUrl = `${baseUrl}/~~~`
        e.preventDefault();
        // TODO : API 개발
        // axios.get(requestUrl)
        // .then((res)=>{
        //     handleUserInput('isValidUsername')(res.result);
        // })
        // .catch((e)=>{
        //     console.log(e);
        //     alert("ERROR");
        // })
        handleUserInput('isValidUsername')(true);
    }

    const handleSubmit = (e)=>{
        const requestUrl = `${baseUrl}/~~~`
        // e.preventDefault();
        // TODO : API 개발
        // axios.post({
            // username:userInput.username,
            // passowrd:userInput.password,
            // email:userInput.email,
            // provider:"NONE"
        // })
        // .then((res)=>{
        // alert("Sign Up Success");
        //     navigate("/login");
        // })
        // .catch((e)=>{
        //     console.log(e);
        //     alert("ERROR");
        // })
    }

    const handleClickShowPassoword = ()=>{
        handleUserInput('showPassword')(!userInput.showPassword);
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
                        {userInput.isValidEmail?null:<Btn label={"Check"} onClick={handleClickEmailValidateButton}/>}
                    </Col>                    
                </Row>
                <Form.Text className="text-muted d-flex">
                    {(userInput.isValidEmail & userInput.email != "" )?"You may use this email":"Check email validation"}
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
                        {userInput.isValidUsername?null:<Btn label={"Check"} onClick={handleClickUsernameValidation}/>}
                    </Col>                    
                </Row>
                <Form.Text className="text-muted d-flex">
                    {(userInput.isValidUsername & userInput.username != "" )?"You may use this username":"Check username validation"}
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
                            type={userInput.showPassword ? null : "password"} 
                            placeholder="Password..."/>
                    </Col>
                    <Col sm={2}>
                        <Btn label={userInput.showPassword?"Hide":"Show"} onClick={handleClickShowPassoword}/>
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
                            type={userInput.showPassword ? null : "password"} 
                            placeholder="Password Confirm..."/>
                    </Col>            
                </Row>
                <Form.Text className="text-muted d-flex">
                    {(userInput.password != userInput.confirmPassword )?"password and confirm password is not matched":null}
                </Form.Text>
            </Form.Group>

            <Button variant="primary" type="submit" onClick={handleSubmit}>Submit</Button>

      </Form>
    );
}

export default RegisterWithUsernameAndPassoword;