import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { Button, Grid, TextField, Typography } from "@mui/material";
import IconButton from '@mui/material/IconButton';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';
import { Container } from "@mui/system";
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormControl from '@mui/material/FormControl';
import Paper from '@mui/material/Paper';
import { Female, Male } from '@mui/icons-material';

const Index = () => {


    const navigator = useNavigate();
    // 사용자 입력
    const [username, setUsername] = useState("");
    const [nickname, setNickname] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [passwordConfirm, setPasswordConfirm] = useState("");
    const [sex, setSex] = useState("MALE");
    const [description, setDescription] = useState("");
    const [birthAt, setBirthAt] = useState(new Date());

    // 변수
    const [isLoading, setIsLoading] = useState(false);      // 회원가입 버튼 disabled
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);      // 비밀번호 보이기/감추기
    const [isPasswordConfirmVisible, setIsPasswordConfirmVisible] = useState(false);      // 비밀번호 보이기/감추기
    const [message, setMessage] = useState("");             // 에러메세지

    // handlers
    const handleEmail=(e)=>{setEmail(e.target.value);};
    const handleNickname=(e)=>{setNickname(e.target.value);};
    const handleUsername=(e)=>{setUsername(e.target.value);};
    const handlePassword=(e)=>{setPassword(e.target.value);};
    const handlePasswordConfirm=(e)=>{setPasswordConfirm(e.target.value);};
    const handleSex=(e)=>{setSex(e.target.value)};
    const handleDescription = (e)=>{setDescription(e.target.value);};
    const handleBirthAt = (e)=>{setBirthAt(e.target.value);};

    const handleIsPasswordVisible = (e)=>{
        e.preventDefault();
        setIsPasswordVisible(!isPasswordVisible)
    }
    const handleIsPasswordConfirmVisible = (e)=>{
        e.preventDefault();
        setIsPasswordConfirmVisible(!isPasswordConfirmVisible);
    }

    const handleSubmit = (e)=>{
        setIsLoading(true);
        setMessage("");
        e.preventDefault();
        if (password!=passwordConfirm){
            setMessage("비밀번호와 비밀번호확인 값이 일치하지 않습니다.");
            setIsLoading(false);
            return;
        }
        const endPoint = "api/userAccount/register";
        const data = {username, nickname, email, password, sex, description, birthAt}
        console.log(data);
        axios.post(endPoint, data
        ).then((res)=>{
            navigator("/login");            
        }).catch((err)=>{
            setMessage(`에러 발생 >>> ${message}`)
            console.log("Error >>>", err)
        }).finally(()=>{
            setIsLoading(false);
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

    return (
        <Container>
            
            <Typography variant='h4' sx={{marginTop:'5vh', padding:'1vh'}}>회원가입</Typography>
            <Typography variant="p">{message}</Typography>

            <Grid container sx={{padding:'1vh'}} spacing={2}>
                {/* 유저명 */}
                <Grid item xs={6}>
                    
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>유저명</Typography>
                        <TextField sx={{width:'100%'}} required value={username} onChange={handleUsername} placeholder="유저명을 입력하세요"/>
                    </Paper>
                </Grid>
                {/* 닉네임 */}
                <Grid item xs={6}>                                  
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>닉네임</Typography>
                        <TextField sx={{width:'100%'}} required value={nickname} onChange={handleNickname} placeholder="닉네임을 입력하세요"/>
                    </Paper>
                </Grid>               
            </Grid>
            
            <Grid container  sx={{padding:'1vh'}} spacing={2}>
                {/* 비밀번호 */}  
                <Grid item xs={6}>  
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}><LabelForVisibility label={"비밀번호"} isVisible={isPasswordVisible} handleIsVisible={handleIsPasswordVisible}/></Typography>
                        <TextField sx={{width:'100%'}} required label={isPasswordVisible?"Visible":"Hide"} value={password} type={isPasswordVisible?"text":"password"} onChange={handlePassword} placeholder="비밀번호를 다시 입력하세요"
                        helperText="10자이상으로 작성해주세요"/>
                    </Paper>
                </Grid>

                {/* 비밀번호 확인 */}             
                <Grid item xs={6}>     
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                    <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}><LabelForVisibility label={"비밀번호확인"} isVisible={isPasswordConfirmVisible} handleIsVisible={handleIsPasswordConfirmVisible}/></Typography>
                        <TextField sx={{width:'100%'}} required value={passwordConfirm} type={isPasswordConfirmVisible?"text":"password"} label={isPasswordConfirmVisible?"Visible":"Hide"}
                        onChange={handlePasswordConfirm} placeholder="비밀번호를 다시 입력하세요"
                        helperText={password===passwordConfirm ? "비밀번호를 다시 입력해주세요" :"비밀번호가 서로 일치하지 않습니다!"}/>
                    </Paper>
                </Grid>
            </Grid>
            
            {/* 이메일 */}
            <Grid container>                
                <Grid item xs={12} sx={{padding:'1vh', width:'100%'}}>                
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>이메일</Typography>
                        <TextField required type="email" value={email} onChange={handleEmail} sx={{width:'100%'}} placeholder="이메일을 입력하세요"/>
                    </Paper>
                </Grid>
            </Grid>


            {/* 자기소개 */}
            <Grid container>                
                <Grid item xs={12} sx={{padding:'1vh', width:'100%'}}>                
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>한줄 자기소개</Typography>
                        <TextField onChange={handleDescription} variant='outlined' sx={{width:'100%'}} placeholder="간단히 자신을 표현해주세요"/>
                    </Paper>
                </Grid>
            </Grid>

             
             <Grid container spacing={2} sx={{padding:'1vh', width:'100%'}}> 
                {/* 성별 */}
                <Grid item xs={6}>
                    <Paper sx={{marginTop:'5vh', padding:'1vh'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>성별</Typography>
                        <FormControl sx={{marginBottom:'1vh', padding:'1vh'}}>
                            <RadioGroup value={sex} onChange={handleSex} >
                                <FormControlLabel value="MALE" control={<Radio icon={<Male/>}/>} label="남자" />
                                <FormControlLabel value="FEMALE" control={<Radio icon={<Female/>}/>} label="여자"/>
                            </RadioGroup>
                        </FormControl>
                    </Paper>
                </Grid>
                {/* 생년월일 */}
                <Grid item xs={6}>
                    <Paper sx={{marginTop:'5vh', padding:'1vh', height:'75%'}}>
                        <Typography fontWeight={"bold"} sx={{marginBottom:'1vh', padding:'1vh'}}>생년월일</Typography>
                        <input style={{margin:'2vh'}} type="date" onChange={handleBirthAt}></input>
                    </Paper>
                </Grid>
            </Grid>
            
            <Grid sx={{padding:'1vh'}}>
                <Button color="success" sx={{marginTop:'5vh', padding:'1vh'}} onClick={handleSubmit} disabled={isLoading} variant="contained">회원가입</Button>          
            </Grid> 
            
        </Container>
    );
} 
export default Index;