import React, { useEffect, useState } from 'react';
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import {
  Avatar,
  Button,
  CssBaseline,
  TextField,
  FormControl,
  FormHelperText,
  Grid,
  Box,
  Typography,
  Container,
} from '@mui/material/';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import validateUtil from './customValidate';
import styled from 'styled-components';
import VisibilityOffIcon from '@mui/icons-material/VisibilityOff';
import Tooltip from '@mui/material/Tooltip';
import { VisibilityRounded } from '@mui/icons-material';

// ---------- styled components  ---------- //
const FormHelperTexts = styled(FormHelperText)`
  width: 100%;
  padding-left: 16px;
  font-weight: 700 !important;
  color: #d32f2f !important;
`;

const Boxs = styled(Box)`
  padding-bottom: 40px !important;
`;

const Register = () => {

    const endPoint = "/api/v1/user/register";
    const navigator = useNavigate();

    // ---------- states  ---------- //
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [nickname, setNickname] = useState('');
    const [password, setPassoword] = useState('');
    const [passwordConfirm, setPassowordConfirm] = useState('');
    
    const theme = createTheme();
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);  
    const [isPasswordConfirmVisible, setIsPasswordConfirmVisible] = useState(false);  
    const [isValid, setIsValid] = useState(false);
    const [registerErrorMessage, setRegisterErrorMessage] = useState('');

    // ---------- hook  ---------- //
    useEffect(()=>{
        if (email==="" || password === "" || nickname === "" || username === ""){
            setRegisterErrorMessage("");
            setIsValid(false);
        } else if (validateUtil("email", email)){
            setRegisterErrorMessage("이메일이 유효하지 않습니다.");
            setIsValid(false);
        } else if (validateUtil("password", password)){
            setRegisterErrorMessage("패스워드가 유효하지 않습니다 (숫자+영문자+특수문자 8자리 이상).");
            setIsValid(false);
        } else if (password !== passwordConfirm) {
            setRegisterErrorMessage("비밀번호와 확인값이 서로 일치하지 않습니다.")
            setIsValid(false);
        } else {
            setRegisterErrorMessage("");
            setIsValid(true);
        }
    }, [username, email, password, passwordConfirm])
    
    // ---------- handlers  ---------- //   
    const handleUsername = (e)=>{
        const input = e.target.value;
        setUsername(input);
    }
    const handleNickname = (e)=>{
        const input = e.target.value;
        setNickname(input);
    }
    const handlePassword = (e)=>{
        const input = e.target.value;
        setPassoword(input);
    }
    const handlePasswordConfirm = (e)=>{
        const input = e.target.value;
        setPassowordConfirm(input);
    }
    const handleEmail = (e)=>{
        const input = e.target.value;
        setEmail(input);
    }
    const handleIsPasswordVisible = (e)=>{
        e.preventDefault();
        setIsPasswordVisible(!isPasswordVisible)
    }
    const handleIsPasswordConfirmVisible = (e)=>{
        e.preventDefault();
        setIsPasswordConfirmVisible(!isPasswordConfirmVisible)
    }
    
    const handleSubmit = async (e) => {
        e.preventDefault();
        await axios
        .post(endPoint, {email, username, nickname, password})
        .then((res) => {                
            navigator("/login");
        })
        .catch((err) => {
            console.log(err);
            switch (err.response.data.statusCode){
                case "DUPLICATED_EMAIL":
                    setRegisterErrorMessage(email + '은 이미 존재하는 이메일입니다...');
                    break;
                case "DUPLICATED_USERNAME":
                    setRegisterErrorMessage(username + '은 이미 존재하는 유저명입니다 ...');
                    break;
                case "DUPLICATED_NICKNAME":
                    setRegisterErrorMessage(nickname + '이미 존재하는 닉네임입니다...');
                    break;
                default:
                    setRegisterErrorMessage('회원가입에 실패하였습니다...');
            }
            
        });
    };

    return (
    <ThemeProvider theme={theme}>
        <Container component="main" maxWidth="xs">
            <CssBaseline />
            <Box
                sx={{
                marginTop: 8,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                }}>
                <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }} />
                <Typography component="h1" variant="h5">회원가입</Typography>
                <Boxs component="form" noValidate onSubmit={handleSubmit} sx={{ mt: 3 }}>
                
                <FormControl component="fieldset" variant="standard">
                    <Grid container spacing={2}>
                        {/* ----- 이메일  ----- */}
                        <Grid item xs={12}>
                            <TextField
                            required
                            autoFocus
                            fullWidth
                            type="email"
                            label="이메일 주소"
                            value={email}
                            onChange={handleEmail}
                            />
                        </Grid>

                        {/* ----- 유저명 ----- */}
                        <Grid item xs={12}>
                            <Tooltip title="로그인 시 사용할 유저명을 입력해주세요">
                                <TextField
                                required
                                fullWidth
                                label="유저명"
                                value={username}
                                onChange={handleUsername}/>
                            </Tooltip>
                        </Grid>

                        {/* ----- 닉네임 ----- */}
                        <Grid item xs={12}>
                            <TextField
                            required
                            fullWidth
                            label="닉네임"
                            value={nickname}
                            onChange={handleNickname}/>
                        </Grid>

                        {/* ----- 비밀번호  ----- */}
                        <Grid item xs={10}>
                            <Tooltip title="숫자+영문자+특수문자 8자리 이상으로 작명해주세요">
                                <TextField
                                required
                                fullWidth
                                type={isPasswordVisible?"text":"password"}
                                label="비밀번호"
                                value={password}
                                onChange={handlePassword}/>
                            </Tooltip>                            
                        </Grid>
                        <Grid item xs={1}>
                            <Button onClick={handleIsPasswordVisible}>
                            {
                                isPasswordVisible?<VisibilityOffIcon/>:<VisibilityRounded/>
                            }
                            </Button>
                        </Grid>

                        {/* ----- 비밀번호 확인 ----- */}
                        <Grid item xs={10}>
                            <Tooltip title="비밀번호를 다시한번 입력해주세요">
                                <TextField
                                required
                                fullWidth
                                type={isPasswordConfirmVisible?"text":"password"}
                                label="비밀번호 재입력"
                                value={passwordConfirm}
                                onChange={handlePasswordConfirm}/>
                            </Tooltip>
                        </Grid>
                        <Grid item xs={1}>
                            <Button onClick={handleIsPasswordConfirmVisible}>
                            {
                                isPasswordConfirmVisible?<VisibilityOffIcon/>:<VisibilityRounded/>
                            }
                            </Button>
                        </Grid>
                    </Grid>

                    {/* ----- 회원가입 버튼 ----- */}
                    <Button 
                    disabled = {!isValid}
                    type="submit" 
                    fullWidth 
                    variant="contained"
                    sx={{ mt: 3, mb: 2 }} 
                    size="large">
                    회원가입
                    </Button>
                </FormControl>
                <FormHelperTexts>{registerErrorMessage}</FormHelperTexts>
                </Boxs>
            </Box>
        </Container>
    </ThemeProvider>
    );
};

export default Register;