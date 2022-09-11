import { useEffect, useState } from 'react';
import { Col, InputGroup, Row, Tooltip } from 'react-bootstrap';
import { Form } from 'react-bootstrap';
import Button from 'react-bootstrap/Button';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const LoginWithUsernameAndPassoword = () => {
    
    const navigator = useNavigate();
    const [username, setUsername] = useState("");
    const [passoword, setPassword] = useState("");
    const [showPassword, setShowPassword] = useState(false);

    const handleSubmit = (e)=>{
        const requestUrl = '/api/v1/user/login'
        // e.preventDefault();
        // TODO : API 개발
        // axios.post({
            // username:userInput.username,
            // passowrd:userInput.password,
            // provider:"NONE"
        // })
        // .then((res)=>{
        // alert("Login Success");
        //     navigate("/feed");
        // })
        // .catch((e)=>{
        //     console.log(e);
        //     alert("ERROR");
        // })
    }

    const handleUsername = (e) => {
        setUsername(e.target.value);
    }
    
    const handlePassword = (e) => {
        setPassword(e.target.value);
    }
 
    const handleShowPassword = () => {
        setShowPassword(!showPassword);
    }
  
    return (
        <Form>

            {/* 유저명 */}
            <Form.Group className="mb-3">
                <Form.Label className='d-flex'>Username</Form.Label>
                <Row>
                    <Col sm={8}>
                        <Form.Control
                            onChange={handleUsername}
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
                            onChange={handlePassword}
                            style={{textAlign:'left'}} 
                            type={showPassword ? null : "password"} 
                            placeholder="Password..."/>
                    </Col>
                    <Col>
                        <Button style={{width:'100px'}} variant='success' onClick={handleShowPassword}>
                            {showPassword?"Hide":"Show"}
                        </Button>
                    </Col>             
                </Row>
            </Form.Group>

            <Button variant="primary" type="submit" onClick={handleSubmit}>Submit</Button>

      </Form>
    );
}

export default LoginWithUsernameAndPassoword;