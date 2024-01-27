import { useState } from "react";
import { Container } from '@mui/system';
import MyPostList from "./post/MyPostList";
import { useRecoilState } from "recoil";
import { userState } from "../../recoil/user";
import FollowList from "./follow/FollwerList";
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import { Typography } from '@mui/material';
import DynamicFeedIcon from '@mui/icons-material/DynamicFeed';
import NotificationsNoneIcon from '@mui/icons-material/NotificationsNone';
import ManageAccountsIcon from '@mui/icons-material/ManageAccounts';
import Diversity1Icon from '@mui/icons-material/Diversity1';
import NotificationList from "./notification/NotificationList";

export default function MyPage(){

    const [user, setUser] = useRecoilState(userState);
    const [tabSelect, setTabSelect] = useState(0);

    const types = ["POSTING","FOLLWER","ACCOUNT","NOTIFICATION"];

    const handleSelect = (e, v) => setTabSelect(v);

    return (
        <Container sx={{mt:3}}>

            {/* 상단 탭 */}
            <Tabs value={tabSelect} onChange={handleSelect}>
                {
                    types.map((t, i)=><Tab key={i} value={i} label={<GetLabel type={t}/>}/>)
                }
            </Tabs>
            
            {/* 컨텐츠 */}
            <Box sx={{mt:3}}>                
                <GetContent type={types[tabSelect]} user={user}/>
            </Box>

        </Container>
    );
}

function GetLabel({type}){

    switch(type){
        case "POSTING":
            return(
                <Box sx={{alignContent:"center", display:"flex"}}>
                    <DynamicFeedIcon/>
                    <Typography variant="span" sx={{marginLeft:"10px"}}>{"내 포스팅보기"}</Typography> 
                </Box>
            );
        case ("FOLLWER"):
            return (
                <Box sx={{alignContent:"center", display:"flex"}}>
                    <Diversity1Icon/>
                    <Typography variant="span" sx={{marginLeft:"10px"}}>{"팔로우"}</Typography> 
                </Box>
            )
        case ("ACCOUNT"):
            return (
                <Box sx={{alignContent:"center", display:"flex"}}>
                    <ManageAccountsIcon/>
                    <Typography variant="span" sx={{marginLeft:"10px"}}>{"내 계정설정"}</Typography> 
                </Box>
            )
        case ("NOTIFICATION"):
            return (
                <Box sx={{alignContent:"center", display:"flex"}}>
                    <NotificationsNoneIcon/>
                    <Typography variant="span" sx={{marginLeft:"10px"}}>{"알림보기"}</Typography> 
                </Box>
            );
        default:
            return;
    }
}

function GetContent({type, user}){

    switch(type){
        case "POSTING":
            return(
                <MyPostList nickname={user.nickname}/>
            );
        case ("FOLLWER"):
            return (
                <FollowList/>
            );
        case ("ACCOUNT"):
            return (
                // TODO
                null
            )
        case ("NOTIFICATION"):
            return (
                <NotificationList/>
            );
        default:
            return;
    }

}