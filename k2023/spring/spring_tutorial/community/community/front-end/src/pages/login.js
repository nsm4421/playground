import { AccountBoxRounded, Key, Visibility, VisibilityOff } from "@mui/icons-material";
import { Avatar, FormControl, IconButton, InputAdornment, InputLabel, OutlinedInput, TextField, Typography } from "@mui/material";
import { Box } from "@mui/system";
import LoginIcon from '@mui/icons-material/Login';
import PatternIcon from '@mui/icons-material/Pattern';
import { useState } from "react"
import { useNavigate } from "react-router-dom";
import { useRecoilState } from "recoil";
import { userState } from "..";
import { getNicknameApi, loginApi } from "../api/authApi";
import { KAKAO_AUTH_URL } from "../api/kakaoApi";

export default function Login() {

    const navigator = useNavigate();
    const kakaoLoginLogoPath = `${process.env.PUBLIC_URL}/public/kakao_login_medium.png`;
    const [user, setUser] = useRecoilState(userState);
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [showPassword, setShowPassword] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    var formData = new FormData();

    const handleUsername = (e) => {
        setUsername(e.target.value);
    };

    const handlePassword = (e) => {
        setPassword(e.target.value);
    };

    const handleClickShowPassword = () => { setShowPassword(!showPassword); };
    const handleMouseDownPassword = (e) => { e.preventDefault(); };

    const handleSubmit = async () => {
        formData.append("username", username);
        formData.append("password", password);
        setIsLoading(true);
        await loginApi(formData, () => { }, () => { });
        await checkLoginSuccess();
        setIsLoading(false);
    }

    const checkLoginSuccess = async () => {
        await getNicknameApi(
            (res) => {
                const nickname = res.data;
                if (nickname) {
                    setUser({ ...user, nickname: res.data });
                    navigator("/article");
                    return;
                }
                alert("로그인 실패");
            },
            (err) => {
                alert("로그인 실패");
                console.log(err)
            }
        )
    }

    const goToKakaoLogin = () => {navigator("/oauth2/kakao");};

    return (
        <div>

            {/* Header */}
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 5, mb: 5 }}>

                <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>

                    <Avatar sx={{ mr: 2 }}>
                        <PatternIcon />
                    </Avatar>

                    <Typography
                        variant="h5"
                        sx={{ fontWeight: 'bold', display: 'flex' }}>
                        로그인
                    </Typography>

                </Box>

                <Box>
                    <a href={KAKAO_AUTH_URL}>
                        <img src={kakaoLoginLogoPath} />
                    </a>
                    
                    <IconButton
                        variant="contained"
                        color="success"
                        disabled={isLoading}
                        onClick={handleSubmit}
                    >
                        <LoginIcon />
                        <Typography sx={{ ml: 1 }}>로그인하기</Typography>
                    </IconButton>
                </Box>

            </Box>

            {/* 유저명 */}
            <TextField
                margin="normal"
                required
                fullWidth
                label="유저명"
                placeholder='로그인 시에 사용할 유저명'
                autoFocus
                InputProps={{ startAdornment: <InputAdornment position="start"><AccountBoxRounded /></InputAdornment>, }}
                value={username}
                onChange={handleUsername}
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
                            <Key />
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


        </div>
    )
}