
import { useState } from 'react';
import Box from '@mui/material/Box';
import IconButton from '@mui/material/IconButton';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import InputAdornment from '@mui/material/InputAdornment';
import FormControl from '@mui/material/FormControl';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormLabel from '@mui/material/FormLabel';
import MenuItem from '@mui/material/MenuItem';
import Select from '@mui/material/Select';


export default function SignUpForm() {

    const [userInput, setUserInput] = useState({
        userName : '',
        age:20,
        sex : '',
        userId: '',
        password: '',
        rePassword: '',
    });
    const [showPassword, setShowPassword] = useState(false);
    const [showRePassword, setShowRePassword] = useState(false);

    return (


    
        <Box sx={{ display: 'flex', flexWrap: 'wrap'}}>
            <div>

                {/* 이름 */}
                <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-userid">이름</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-username"
                        value={userInput.userName}
                        onChange={(e)=>{
                            setUserInput({...userInput, userName:e.target.value});
                        }}
                        label="UserName"
                        />
                </FormControl>

                {/* 나이 */}
                <FormControl sx={{ m: 1, width: '25ch' }}>
                    <InputLabel id="demo-simple-select-label">연령대</InputLabel>
                    <Select
                        labelId="demo-simple-select-label"
                        id="demo-simple-select"
                        value={userInput.age}
                        label="Age"
                        onChange={(e)=>{setUserInput({...userInput, age:e.target.value})}}
                        >

                    <MenuItem value={10}>10대</MenuItem>
                    <MenuItem value={20}>20대</MenuItem>
                    <MenuItem value={30}>30대</MenuItem>
                    <MenuItem value={40}>40대</MenuItem>
                    <MenuItem value={50}>40대</MenuItem>

                    </Select>
                </FormControl>

                {/* 성별 */}
                <FormControl>
                    <FormLabel id="demo-row-radio-buttons-group-label">성별</FormLabel>
                    <RadioGroup
                        row
                        aria-labelledby="demo-row-radio-buttons-group-label"
                        name="row-radio-buttons-group"
                    >
                        <FormControlLabel value="male" control={<Radio />} label="남자" 
                            onChange={(e)=>{setUserInput({...userInput, sex:"male"})}}/>
                        <FormControlLabel value="female" control={<Radio />} label="여자" 
                            onChange={(e)=>{setUserInput({...userInput, sex:"female"})}}/>
                        <FormControlLabel value="else" control={<Radio />} label="그외(?)" 
                            onChange={(e)=>{setUserInput({...userInput, sex:"else"})}}/>
                    </RadioGroup>
                </FormControl>
            
            <br/>
                
                {/* 아이디 */}
                <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-userid">아이디</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-userid"
                        value={userInput.userId}
                        onChange={(e)=>{
                            setUserInput({...userInput, userId:e.target.value});
                        }}
                        endAdornment={
                            <InputAdornment position="end">
                                <IconButton
                                    aria-label="toggle password visibility"
                                    onClick={()=>{setShowPassword(!showPassword);}}
                                    onMouseDown={(e)=>{e.preventDefault();}}
                                    edge="end"
                                >                           
                                </IconButton>
                            </InputAdornment>
                        }
                        label="UserId"
                    />
                </FormControl>
                
                {/* 비밀번호 */}
                <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-password">비밀번호</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-password"
                        type={showPassword ? 'text' : 'password'}
                        value={userInput.password}
                        onChange={(e)=>{
                            setUserInput({...userInput, password:e.target.value});
                        }}
                        endAdornment={
                            <InputAdornment position="end">
                            <IconButton
                                aria-label="toggle password visibility"
                                onClick={()=>{setShowPassword(!showPassword);}}
                                onMouseDown={(e)=>{e.preventDefault();}}
                                edge="end"
                            >
                                {showPassword ? <VisibilityOff /> : <Visibility />}
                            </IconButton>
                            </InputAdornment>
                        }
                        label="Password"
                    />
                </FormControl>

                {/* 비밀번호 확인 */}
                <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-repassword">비밀번호 확인</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-repassword"
                        type={showRePassword ? 'text' : 'password'}
                        value={userInput.rePassword}
                        onChange={(e)=>{
                            setUserInput({...userInput, rePassword:e.target.value});
                        }}
                        endAdornment={
                            <InputAdornment position="end">
                            <IconButton
                                aria-label="toggle repassword visibility"
                                onClick={()=>{setShowRePassword(!showRePassword);}}
                                onMouseDown={(e)=>{e.preventDefault();}}
                                edge="end"
                            >
                                {showRePassword ? <VisibilityOff /> : <Visibility />}
                            </IconButton>
                            </InputAdornment>
                        }
                        label="RePassword"
                    />
                </FormControl>
            </div>
        </Box>

    );
}