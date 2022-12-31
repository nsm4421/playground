import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import Box from '@mui/material/Box';
import TextField from '@mui/material/TextField';
import { Button } from '@mui/material';
import PasswordInput from './PasswordInput';
import UploadMention from '../API/UploadMention';
import { useState } from 'react';

export default function WriteMention(props){

    const [mention, setMention] = useState("");
    const [password, setPassword] = useState("");

    return(
        <div>
            <hr/>           
            <Box className='Mention-Upload'
                component="form"
                sx={{
                '& .MuiTextField-root': { m: 1, width: '35ch' },
                }}
                noValidate
                autoComplete="off">
                    <TextField
                        id="filled-multiline-flexible"
                        label="댓글달기"
                        multiline
                        maxRows={5}
                        defaultValue=""
                        variant="filled"
                        placeholder="댓글"
                        onChange={(e)=>{setMention(e.target.value)}}
                    />

                <div>
                    <Button className='Mention-Upload-Button' 
                    onClick={()=>{
                        UploadMention(props._id, mention)
                    }}>
                        Upload
                        <ArrowForwardIosIcon/>
                    </Button>
                </div>

            </Box>
            <hr/>
        </div>
    )
}
