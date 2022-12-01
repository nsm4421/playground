import { VisibilityOff } from '@mui/icons-material';
import Visibility from '@mui/icons-material/Visibility';
import { Button, Container, IconButton, Paper, Typography } from '@mui/material';
import TextField from '@mui/material/TextField';
import axios from "axios";
import { useState } from "react";

const Login = ()=>{

    const [username, setUsername] = useState("");
    const [password, setPassowrd] = useState("");
    const [isLoading, setIsLoaidng] = useState(false);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

    const handleUsername = (e)=>{
        setUsername(e.target.value);
    }
    const handlePassword = (e)=>{
        setPassowrd(e.target.value);
    }

    const handleIsPasswordVisible = (e) =>{
        e.preventDefault();
        setIsPasswordVisible(!isPasswordVisible);
    }

    const handleSubmit = async (e)=>{
        setIsLoaidng(true);
        e.preventDefault();
        const data = {username, password}
        await axios
            .post("/api/userAccount/login", data)
            .then((res)=>{
                // TODO
                console.log(res);
            })
            .catch((err)=>{
                console.log(err);
            })
            .finally(()=>{
                setIsLoaidng(false);
            })
    }

    const LabelForVisibility = ({label, isVisible, handleIsVisible}) => {
        return (
            <label>
                {label}
                <span>
                    <IconButton onClick={handleIsVisible}>{isVisible?<VisibilityOff/>: <Visibility/>}</IconButton>
                </span>
            </label>
        )
    }

    return(
        <Container>

            <Typography variant='h4' sx={{marginTop:'5vh', padding:'1vh'}}>로그인</Typography>

            <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>유저명</Typography>
                <TextField sx={{width:'100%'}} required value={username} onChange={handleUsername} placeholder="유저명을 입력하세요"/>
            </Paper>

            <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}><LabelForVisibility label={"비밀번호"} isVisible={isPasswordVisible} handleIsVisible={handleIsPasswordVisible}/></Typography>
                <TextField sx={{width:'100%'}} required label={isPasswordVisible?"Visible":"Hide"} value={password} type={isPasswordVisible?"text":"password"} onChange={handlePassword} placeholder="패스워드를 입력하세요"/>
            </Paper>
            
            <Button sx={{marginTop:'5vh', padding:'1vh'}} disabled={isLoading} color="success" variant='contained' onClick={handleSubmit}>로그인</Button>
            
        </Container>
    );
}
export default Login;