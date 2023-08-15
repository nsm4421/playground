import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import Link from '@mui/material/Link';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { FormControl, IconButton, InputAdornment, InputLabel, OutlinedInput } from '@mui/material';
import { useState } from 'react';
import { AccountBoxRounded, BorderAllRounded, Email, Key, People, Visibility, VisibilityOff } from '@mui/icons-material';
import { regsterApi } from '../api/authApi';
import { useNavigate } from 'react-router-dom';

const theme = createTheme();

const backgroundImage = 'url(https://source.unsplash.com/random)';

export default function Register() {

    const navigator = useNavigate();
    const [username, setUsername] = useState("");
    const [nickname, setNickname] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [description, setDescription] = useState("");
    const [showPassword, setShowPassword] = useState(false);
    const [isLoading, setIsLoading] = useState(false);

    const handleUsername = (e) => { setUsername(e.target.value);};
    const handleNickname = (e) => { setNickname(e.target.value);};
    const handleEmail = (e) => { setEmail(e.target.value);};
    const handlePassword = (e) => { setPassword(e.target.value);};
    const handleDescription = (e) => { setDescription(e.target.value);};
    const handleClickShowPassword = () => {setShowPassword(!showPassword);};
    const handleMouseDownPassword = (e) => {e.preventDefault();};
    const handleSubmit = async () => {
        setIsLoading(true);
        await regsterApi(
            {username, nickname, email, password, description}, 
            (res)=>{
                if (res.data.status === 'OK'){
                    console.log(res);
                    navigator("/login");
                    return;
                }
                alert("회원가입에 실패하였습니다");
                console.log(res);
            }, 
            (err)=>{
                alert("회원가입에 실패하였습니다");
                console.log(err);
            })
        setIsLoading(false);
    }

    return (
        <ThemeProvider theme={theme}>
            <Grid container component="main" sx={{ height: '100vh' }}>
                <CssBaseline />
                <Grid
                    item
                    xs={false}
                    sm={4}
                    md={7}
                    sx={{
                        // Background Image
                        backgroundImage: backgroundImage,
                        backgroundRepeat: 'no-repeat',
                        backgroundColor: (t) =>
                            t.palette.mode === 'light' ? t.palette.grey[50] : t.palette.grey[900],
                        backgroundSize: 'cover',
                        backgroundPosition: 'center',
                    }}
                />
                
                <Grid item xs={12} sm={8} md={5} component={Paper} elevation={6} square>
                    <Box
                        sx={{
                            my: 8,
                            mx: 4,
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                        }}
                    >
                        <Avatar sx={{ m: 1, bgcolor: 'secondary.main' }}>
                            <LockOutlinedIcon />
                        </Avatar>
                        <Typography component="h1" variant="h5">
                            회원가입
                        </Typography>

                        <Box component="form" noValidate onSubmit={handleSubmit} sx={{ mt: 1 }}>

                            {/* 이메일 */}
                            <TextField
                                margin="normal"
                                required
                                fullWidth
                                label="이메일"
                                placeholder='example@naver.com'
                                autoComplete="email"
                                autoFocus
                                InputProps={{startAdornment: <InputAdornment position="start"><Email/></InputAdornment>,}}
                                value={email}
                                onChange={handleEmail}
                            />

                            {/* 유저명 */}
                            <TextField
                                margin="normal"
                                required
                                fullWidth
                                label="유저명"
                                placeholder='로그인 시에 사용할 유저명'
                                autoFocus
                                InputProps={{startAdornment: <InputAdornment position="start"><AccountBoxRounded/></InputAdornment>,}}
                                value={username}
                                onChange={handleUsername}
                            />

                            {/* 닉네임 */}
                            <TextField
                                margin="normal"
                                required
                                fullWidth
                                label="닉네임"
                                placeholder='상도동 카르마'
                                InputProps={{startAdornment: <InputAdornment position="start"><BorderAllRounded/></InputAdornment>,}}
                                autoFocus
                                value={nickname}
                                onChange={handleNickname}
                            />

                            {/* 비밀번호 */}
                            <FormControl fullWidth variant="outlined" margin="normal">
                                <InputLabel htmlFor="outlined-adornment-password">비밀번호</InputLabel>
                                <OutlinedInput
                                    value={password}
                                    onChange={handlePassword}
                                    type={showPassword ? 'text' : 'password'}    
                                    startAdornment={
                                        <InputAdornment position="start">
                                           <Key/>   
                                        </InputAdornment>
                                    }
                                    placeholder="1q2w3e4r!!"
                                    endAdornment={                                    
                                        <InputAdornment position="end">
                                            <IconButton
                                                aria-label="toggle password visibility"
                                                onClick={handleClickShowPassword}
                                                onMouseDown={handleMouseDownPassword}
                                                edge="end"
                                            >
                                                {showPassword ? <VisibilityOff /> : <Visibility />}
                                            </IconButton>
                                        </InputAdornment>
                                    }
                                    label="비밀번호"
                                />
                            </FormControl>

                            {/* 자기소개 */}
                            <TextField
                                margin="normal"
                                required
                                fullWidth
                                label="한줄 자기소개"
                                placeholder='상도동에서 가장 티모 잘하는 사람'
                                autoFocus
                                value={description}
                                onChange={handleDescription}
                            />

                            <Button
                                type="submit"
                                fullWidth
                                variant="contained"
                                sx={{ mt: 3, mb: 2 }}
                                onClick={handleSubmit}
                                disabled={isLoading}
                            >
                                제출하기
                            </Button>

                            {/* TODO : 비밀번호 찾기 */}
                            <Grid container>
                                <Grid item xs>
                                    <Link href="#" variant="body2">
                                        혹시 비밀번호를 잊어버리셨나요?
                                    </Link>
                                </Grid>
                                <Grid item>
                                    <Link variant="body2" onClick={()=>{navigator("/login")}}>
                                        이메 계정을 가지고 계신가요?
                                    </Link>
                                </Grid>
                            </Grid>
                        </Box>
                    </Box>
                </Grid>
            </Grid>
        </ThemeProvider>
    );
}