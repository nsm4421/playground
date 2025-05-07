
import { useState } from 'react';
import IconButton from '@mui/material/IconButton';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import InputAdornment from '@mui/material/InputAdornment';
import FormControl from '@mui/material/FormControl';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';

export default function PasswordInput(props){

    const [showPassword, setShowPassword] = useState(false);

    return(

        <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
            <InputLabel htmlFor="outlined-adornment-password">비밀번호</InputLabel>
            <OutlinedInput
                id="outlined-adornment-password"
                type={showPassword ? 'text' : 'password'}
                value={props.password}
                onChange={(e)=>{    
                    let input_ = e.target.value
                    if (input_.length>10){
                        input_ = input_.slice(0, 10)
                    }
                    if (props.setPassword){
                        props.setPassword(input_)
                    }
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
    )
}