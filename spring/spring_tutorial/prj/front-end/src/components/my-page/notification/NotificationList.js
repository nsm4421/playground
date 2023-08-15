import { useEffect, useState } from "react";
import { useRecoilState } from "recoil";
import { userState } from "../../../recoil/user";
import { styled } from '@mui/material/styles';
import Box from '@mui/material/Box';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemAvatar from '@mui/material/ListItemAvatar';
import ListItemText from '@mui/material/ListItemText';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import Grid from '@mui/material/Grid';
import DeleteIcon from '@mui/icons-material/Delete';
import ThumbUpIcon from '@mui/icons-material/ThumbUp';
import { Container } from "@mui/system";
import { Alert, Button, Pagination } from "@mui/material";
import { ThumbDown } from "@mui/icons-material";
import CreateIcon from '@mui/icons-material/Create';
import NotificationsIcon from '@mui/icons-material/Notifications';
import axios from "axios";

const Demo = styled('div')(({ theme }) => ({
    backgroundColor: theme.palette.background.paper,
}));

export default function NotificationList(){
    /**
     * States
     * select : 선택한 알림유형(전체/좋아요/싫어요/댓글)
     * currentNotificationType : 현재 선택한 알림 유형
     * currentPage : 현재 페이지수
     * totalPage : 전체 페이지수
     * isLoading : 로딩중 여부
     * user : 로그인한 유저
     */
    const [selected, setSelected] = useState(0);
    const [currentNotificationType, setCurrentNotificationType] = useState("NONE")
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPage, setTotalPage] = useState(0);
    const [isLoading, setIsLoading] = useState(false);
    const [user, setUser] = useRecoilState(userState);
    const [errorMessage, setErrorMessage] = useState("");
    const [notifications, setNotifications] = useState([{}]);
    const tabs = [
        {label:"전체", icon:<NotificationsIcon/>, type:"NONE"},
        {label:"좋아요", icon:<ThumbUpIcon/>, type:"NEW_LIKE_ON_POST"},
        {label:"싫어요", icon:<ThumbDown/>, type:"NEW_HATE_ON_POST"},
        {label:"댓글", icon:<CreateIcon/>, type:"NEW_COMMENT_ON_POST"},
    ]
   
    // 선택한 알림유형 변경이나 페이지수 변경시 알림 리스트 다시 불러오기
    useEffect(()=>{
        setCurrentNotificationType(tabs[selected].type??"NONE");
        getNotifications();
    }, [selected, currentPage])

    // SSE
    useEffect(()=>{
        // SSE 기능 사용시 header를 같이 보낼 수 없어 url에 인증토큰을 넣음
        // Back-End의 Security Filter Chain 코드도 수정이 필요
        const endPoint = `/api/v1/notification/connect?token=${user.token??localStorage.getItem('token').substring(78)}`;
        const eventSource = new EventSource(endPoint);

        eventSource.addEventListener('open', (e)=>{
            console.log("eventSource opened : ", e);
        })

        eventSource.addEventListener('notification',(e)=>{
            console.log("eventSource notification : ", e);
            getNotifications();
        })

        eventSource.addEventListener('error',(err)=>{
            console.log("eventSource error : ", err);
            setErrorMessage("ERROR!!!");
        })
    }, [])

    const handleSelect = (i) => (e) => {setSelected(i);};

    // 선택한 알림 유형의 버튼은 contained, 아닌 버튼은 outlined
    const handleVariant = (i) => (selected===i?'contained':'outlined');

    // 페이지 버튼 클릭시 페이지 수정
    const handlePage = (e) => {
        setCurrentPage((parseInt(e.target.outerText)??1)-1);
    }

    // 알림가져오기
    const getNotifications = async () => {
        const endPoint = `/api/v1/notification?page=${currentPage}&nType=${currentNotificationType}`;
        await axios.get(endPoint, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            return res.data.result
        }).then((res)=>{
            setCurrentPage(res.pageable.pageNumber);    // 현재 페이지수
            setTotalPage(res.totalPages);               // 전체 페이지수    
            setNotifications([...res.content]);         // 포스팅 정보
        }).catch((err)=>{
            console.log(err);
        }).finally(()=>{
            setIsLoading(false);
        });
    }

    // 알림 삭제
    const handleDelete = (nid) => async () => {
        setIsLoading(true);
        const endPoint = `/api/v1/notification?nid=${nid}`;
        await axios.delete(endPoint, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            getNotifications(); // 알림 다시 불러오기
        }).catch((err)=>{
            console.log("deleteNoti - 에러 발생", err)
            setErrorMessage("삭제 시 오류 발생")
        }).finally(()=>{
            setIsLoading(false);
        })
    }

    // 알림 전체 삭제
    const handleDeleteAll = async () => {
        const endPoint = `/api/v1/notification/all`;
        setIsLoading(true);
        await axios.delete(endPoint, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            getNotifications(); // 알림 다시 불러오기
        }).catch((err)=>{
            console.log("handleDeleteAll - 에러 발생", err)
        }).finally(()=>{
            setIsLoading(false);
        })
    }

    return (
        <Container>

            {
                errorMessage
                ?<Alert severity="error" onClose={()=>{setErrorMessage("");}}>{errorMessage}</Alert>
                :null
            }            

            {/* 탭 */}
            <Grid container sx={{mb:3, mt:5}}>            
                {
                    tabs.map((t, i)=>{
                        return (
                            <Grid item sx={{mr:3}}>
                                <Button key={i} onClick={handleSelect(i)} variant={handleVariant(i)} startIcon={t.icon} disabled={isLoading}>
                                    {t.label}
                                </Button>
                            </Grid>
                        )
                    })
                }   
                {/* 전체삭제 버튼 */}
                <Grid item sx={{mr:3}}>
                    <Button onClick={handleDeleteAll} variant={'danger'} startIcon={<DeleteIcon/>} disabled={isLoading}>
                        전체삭제
                    </Button>
                </Grid>
            </Grid>

            {/* 알림 리스트 */}
            <Demo>
                <List dense>
                    {
                        notifications.map((n, i) =>{
                            return (
                                
                                <ListItem key={i} secondaryAction={<IconButton edge="end" disabled={isLoading}><DeleteIcon onClick={handleDelete(n.id)}/></IconButton> }> 
                                {/* 아바타 */}
                                <ListItemAvatar>
                                    <Avatar>
                                        {n.notificationType === "NONE"?<NotificationsIcon/>:null}
                                        {n.notificationType === "NEW_LIKE_ON_POST"?<ThumbUpIcon/>:null}
                                        {n.notificationType === "NEW_HATE_ON_POST"?<ThumbDown/>:null}
                                        {n.notificationType === "NEW_COMMENT_ON_POST"?<CreateIcon/>:null}
                                    </Avatar>
                                </ListItemAvatar>

                                {/* 메세지 & 시간 */}
                                <ListItemText primary={n.message} secondary={n.createdAt}/>

                                </ListItem>
                            )
                        })
                    }
                </List>
            </Demo>

            {/* 페이지 */}
            <Box sx={{justifyContent:"center", display:"flex", marginTop:"5vh"}}>            
                <Pagination count={totalPage} defaultPage={1} boundaryCount={10} color="primary" size="large" sx={{margin: '2vh'}} onChange={handlePage}/>
            </Box>

        </Container>
    )
  
}