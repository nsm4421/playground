import { Button, IconButton, Tooltip, Typography } from '@mui/material';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import NotesIcon from '@mui/icons-material/Notes';
import DeleteIcon from '@mui/icons-material/Delete';
import { Box } from '@mui/system';
import { useState } from 'react';
import FullScreenDialog from '../../post/FullScreenDialog'
import { useNavigate } from 'react-router-dom';
import { useRecoilState } from 'recoil';
import { userState } from '../../../recoil/user';
import axios from 'axios';

const MyPostCard = ({post}) => {
    const navigator = useNavigate();
    const [user, setUser] = useRecoilState(userState);
    const [isLoading, setIsLoading] = useState(false);
    const [openDialog, setOpenDialog] = useState(false);
    const handleDialog = (e) => {
        e.preventDefault();
        setOpenDialog(!openDialog);
    }
    const handleModifyButton = () => {
        const url = `/post/modify/${post.id}`;
        navigator(url);
    }
    const handleDelete = async (e) => {
        const endPoint = `api/v1/post?pid=${post.id}`
        setIsLoading(true);
        await axios.delete(endPoint, {
            headers : {
                Authorization : user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            alert("포스팅 삭제에 성공하였습니다.")
            window.location.href = "/mypage"
        }).catch((err)=>{
            alert("포스팅 삭제에 실패했습니다.")
            console.log(err);
        }).finally(()=>{
            setIsLoading(false);
        })
    }

    return (
        <Card sx={{ minWidth: 275 }}>

            {/* 다이얼로그 창 (포스팅 세부정보) */}
            <FullScreenDialog open={openDialog} setOpen={setOpenDialog} post={post}/>
            
            <CardContent onClick={handleDialog}>
                <CardActions sx={{justifyContent:"space-between"}}>
                    {/* 제목 */}
                    <Typography variant="h5" component="strong" color="primary">{post.title}</Typography>
                    <Box>
                        {/* 수정버튼 */}
                        <IconButton disabled={isLoading} onClick={handleModifyButton}>
                            <NotesIcon/>
                            <Typography variant="h6" component="span" color="text.secondary">수정하기</Typography>                    
                        </IconButton>
                        {/* 삭제버튼 */}
                        <IconButton disabled={isLoading} onClick={handleDelete}>
                            <DeleteIcon/>
                            <Typography variant="h6" component="span" color="text.secondary">삭제하기</Typography>                    
                        </IconButton>
                    </Box>
                </CardActions>

                <CardActions sx={{justifyContent:"space-between"}}>
                    {/* 본문 - 100글자까지만 보여주고 ... 붙이기 */}
                    <Box sx={{padding:'1vh'}}>
                        <Typography variant="body2">{post.content.length>=50?post.content.slice(0,50)+" ...":post.content}</Typography>
                    </Box>
                    {/* 작성일자 */}
                    <Typography variant="span" component="span" color="text.secondary">
                        {post.createdAt}
                    </Typography>
                </CardActions>
                {/* 해쉬태그 */}
                <Box sx={{float:'right'}}>
                    {post.hashtags.map((h, i)=>{
                        return(
                            <Typography variant="span" component="span" color="primary" key={i} sx={{marginRight:"2vh"}}>
                                #{h}
                            </Typography>
                        )
                    })}
                </Box>
            </CardContent>
        </Card>
    );
}

export default MyPostCard;