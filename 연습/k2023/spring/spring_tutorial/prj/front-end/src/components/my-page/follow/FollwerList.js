import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Divider from '@mui/material/Divider';
import InboxIcon from '@mui/icons-material/Inbox';
import DraftsIcon from '@mui/icons-material/Drafts';
import { Avatar, Button, Container, Grid, ListSubheader, Typography } from '@mui/material';
import { useEffect, useState } from 'react';
import { useRecoilState } from 'recoil';
import { userState } from '../../../recoil/user';
import axios from 'axios';

export default function FollowList(){

    const [user, setUser] = useRecoilState(userState);
    const [followers, setFollower] = useState([]);
    const [selected, setSelected] = useState(0);
    const [labelText, setLabelText] = useState("");
    const handleSelect = (i) => (e) => {setSelected(i);};

    useEffect(()=>{
        
    }, [selected])

    useEffect(()=>{
        const endPoint = '/api/v1/user/follow';
        const data = {nickname:user.nickname, followingType:(selected===0?"FOLLOWER":"LEADER")}
        axios.post(
            endPoint,
            data,
            {   
                headers:{
                    Authorization : user.token??localStorage.getItem("token")
                }
            }
        ).then((res)=>{
            return res.data.result;
        }).then((res)=>{
            setFollower(res);  
            setLabelText(selected===0
                ?'내가 팔로우하는 사람'
                :'나를 팔로우하는 사람');          
        }).catch((err)=>{
            console.log(err);
            setLabelText("리스트를 가져오는데 실패했습니다...")
        })

    }, [selected])


    return (
        <Container>

            {/* 버튼 */}
            <Grid container spacing={2} sx={{mt:5}}>
                <Button variant={selected===0?'contained':'outlined'} onClick={handleSelect(0)} sx={{mr:2}}>
                    I FOLLOW                       
                </Button>
                <Button variant={selected===1?'contained':'outlined'} onClick={handleSelect(1)} sx={{mr:2}}>
                    I FOLLOWED                      
                </Button>               
            </Grid>

            {/* 리스트 */}
            <Grid container sx={{mt:5}}>

                <List sx={{ width: '100%', bgcolor: 'background.paper'}}
                    component="nav"
                    subheader={<ListSubheader component="div"><Typography variant='h6'>{labelText}</Typography></ListSubheader>}>

                    {
                        followers.map((f, i)=>{
                            return (                                
                                <ListItem disablePadding sx={{mt:2}} key={i}>
                                    <ListItemButton>
                                        
                                        {/* TODO : 프사 */}
                                        <Avatar sx={{mr:3}}>
                                            <InboxIcon/>
                                        </Avatar>
                                        
                                        <ListItemText primary={f.nickname}/>
                                    </ListItemButton>
                                </ListItem>
                            )
                        })
                    }

                </List>
            </Grid>                

        </Container>
    );
}