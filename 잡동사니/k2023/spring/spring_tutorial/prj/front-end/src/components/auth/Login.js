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
import styled from 'styled-components';
import VisibilityOffIcon from '@mui/icons-material/VisibilityOff';
import Tooltip from '@mui/material/Tooltip';
import { VisibilityRounded } from '@mui/icons-material';
import { useRecoilState } from 'recoil';
import { userState } from '../../recoil/user';

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

const Login = () => {

    const endPoint = "/api/v1/user/login";
    const navigator = useNavigate();

    // ---------- states  ---------- //
    const [username, setUsername] = useState('');
    const [password, setPassoword] = useState('');
    
    const theme = createTheme();
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);  
    const [isValid, setIsValid] = useState(false);
    const [loginErrorMessage, setRegisterErrorMessage] = useState('');
    const [user, setUser] = useRecoilState(userState);

    // ---------- hook  ---------- //
    useEffect(()=>{
        if (username === ""){
            setRegisterErrorMessage("유저명을 입력해주세요");
            setIsValid(false);
        } else if (password === ""){
            setRegisterErrorMessage("패스워드를 입력해주세요");
            setIsValid(false);
        } else {
            setRegisterErrorMessage("");
            setIsValid(true);
        }
    }, [username,password])
    
    // ---------- handlers  ---------- //   
    const handleUsername = (e)=>{
        const input = e.target.value;
        setUsername(input);
    }
    const handlePassword = (e)=>{
        const input = e.target.value;
        setPassoword(input);
    }
    const handleIsPasswordVisible = (e)=>{
        e.preventDefault();
        setIsPasswordVisible(!isPasswordVisible)
    }    
    const handleSubmit = async (e) => {
        e.preventDefault();
        await axios
        .post(endPoint, {username, password})
        // 로그인 성공시
        .then((res) => {      
            const token = `Bearer ${res.data.result}`;
            // 전역변수 user 세팅
            setUser({...user, token})
            // localstorage에 token 저장
            localStorage.setItem("token", token);
            // 포스팅 페이지로 이동
            window.location.href="/post"
        })
        // 로그인 실패시
        .catch((err) => {
            console.log(err);
            switch (err.response.data.statusCode){
                case "USERNAME_NOT_FOUND":
                    setRegisterErrorMessage(username + '은 존재하지 않는 유저명입니다...');
                    break;
                case "INVALID_PASSWORD":
                    setRegisterErrorMessage('비밀번호가 틀렸습니다...');
                    break;
                default:
                    setRegisterErrorMessage('로그인에 실패하였습니다...');
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
                <Typography component="h1" variant="h5">로그인</Typography>
                <Boxs component="form" noValidate onSubmit={handleSubmit} sx={{ mt: 3 }}>
                
                <FormControl component="fieldset" variant="standard">
                    <Grid container spacing={2}>                      

                        {/* ----- 유저명 ----- */}
                        <Grid item xs={12}>                         
                            <TextField
                            required
                            fullWidth
                            label="유저명"
                            value={username}
                            onChange={handleUsername}/>                      
                        </Grid>

                        {/* ----- 비밀번호  ----- */}
                        <Grid item xs={10}>
                            <Tooltip title="비밀번호를 입력해주세요">
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
                    </Grid>

                    {/* ----- 로그인 버튼 ----- */}
                    <Button 
                    disabled = {!isValid}
                    type="submit" 
                    fullWidth 
                    variant="contained"
                    sx={{ mt: 3, mb: 2 }} 
                    size="large">
                    로그인
                    </Button>
                </FormControl>
                <FormHelperTexts>{loginErrorMessage}</FormHelperTexts>
                </Boxs>
            </Box>
        </Container>
    </ThemeProvider>
    );
};

export default Login;