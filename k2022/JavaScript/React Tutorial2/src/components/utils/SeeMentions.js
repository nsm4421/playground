import * as React from 'react';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';

export default function SeeMentions(props){
    console.log(props)
    return (
        <CardContent>
        {
            props.mentions?
            Object.keys(props.mentions).map((k, i)=>{
                return (
                <div key={i} style={{display:'flex'}}>
                    <Typography paragraph>
                        <div style={{'display':'flex'}}>
                                {props.mentions[k].mention}  
                            <div style={{'margin-left' : '150px'}}> 
                                {props.mentions[k].writeAt}                   
                            </div>                  
                        </div>
                         
                     
                    </Typography>
                    
                </div>
                )
            })
            : <Typography paragraph>
                등록된 댓글이 없음
            </Typography>
        }
        </CardContent>
    )
}