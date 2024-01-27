import * as React from 'react';
import { useState } from 'react';
import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardContent from '@mui/material/CardContent';
import TextField from '@mui/material/TextField';
import { Button } from '@mui/material';
import UploadArticle from './API/UploadArticle';
import IconButton from '@mui/material/IconButton';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import InputAdornment from '@mui/material/InputAdornment';
import FormControl from '@mui/material/FormControl';
import Visibility from '@mui/icons-material/Visibility';
import VisibilityOff from '@mui/icons-material/VisibilityOff';


export default function WriteArticle(props) {

  const [userInput, setUserInput] = useState({
      article:"",
      password:"",
      title:"",
      writeAt:"",
      writer:"",
  });
  const [showPassword, setShowPassword] = useState(false);
  
  return (
    <Card sx={{ maxWidth: "100%" }}>
       
      <CardHeader
        // 아이디
        title={<TextField
                id="filled-multiline-flexible"
                label="제목"
                multiline
                defaultValue=""
                variant="standard"
                placeholder="제목"
                sx={{ width: "100%" }}
                onChange={(e)=>{setUserInput({...userInput, title:e.target.value});}}/>}
        
        subheader={
        
            <div>
                {/* 글쓴이 */}
                <TextField
                    id="filled-multiline-flexible"
                    label="글쓴이"
                    multiline
                    variant="standard"
                    placeholder="ㅇㅇ"
                    sx={{m:1, width: "40%" }}
                    onChange={(e)=>{setUserInput({...userInput, writer:e.target.value})}}
                />

                {/* 비밀번호 */}
                <FormControl sx={{ m: 1, width: '25ch' }} variant="outlined">
                <InputLabel htmlFor="outlined-adornment-password">비밀번호</InputLabel>
                <OutlinedInput
                    id="outlined-adornment-password"
                    type={showPassword ? 'text' : 'password'}
                    value={userInput.password}
                    onChange={(e)=>{    
                        setUserInput({...userInput, password:e.target.value})
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
          
            </div>
        }/>

        {/* 글쓰기 */}
        <CardContent>
            <TextField
                id="filled-multiline-flexible"
                // 글자수 세기
                label={userInput.article?`${userInput.article.length}/1000`:"글쓰기"}
                multiline
                maxRows={20}
                variant="filled"
                placeholder="글쓰기"
                value={userInput.article}
                sx={{ width: "100%" }}
                onChange={(e)=>{
                    let input_ = e.target.value;
                    if (input_){
                        if (input_.length>1000){
                            input_ = input_.slice(0,1000)
                        }
                    }
                    setUserInput({...userInput, article:input_});}}/>
        </CardContent>

        {/* 업로드 버튼 */}
        <Button color='success' onClick={()=>{
            UploadArticle(userInput)
            props.setTab(0)
            }}>Upload</Button>

    </Card>
  );
}
