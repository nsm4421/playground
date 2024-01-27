import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Collapse from '@mui/material/Collapse';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import { red } from '@mui/material/colors';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import SendIcon from '@mui/icons-material/Send';
import ThumbUpIcon from '@mui/icons-material/ThumbUp';
import ThumbDownIcon from '@mui/icons-material/ThumbDown';
import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { Container } from '@mui/system';
import axios from 'axios';
import { userState } from '../../recoil/user';
import { useRecoilState } from 'recoil';
import { Box, Button, DialogContent, Grid, Pagination, TextField, Tooltip } from '@mui/material';
import FullScreenDialog from './FullScreenDialog';
import ListItemText from '@mui/material/ListItemText';
import ListItem from '@mui/material/ListItem';
import List from '@mui/material/List';
import Divider from '@mui/material/Divider';

const ExpandMore = styled((props) => {
  const { expand, ...other } = props;
  return <IconButton {...other} />;
})(({ theme, expand }) => ({
  transform: !expand ? 'rotate(0deg)' : 'rotate(180deg)',
  marginLeft: 'auto',
  transition: theme.transitions.create('transform', {
    duration: theme.transitions.duration.shortest,
  }),
}));

const DetailPost = ({postId}) => {

    /**
     * States
     * 포스팅 - title, content, author, createAt, hashtags
     * 좋아요, 싫어요 - likeCount, hateCount, emotionType(LIKE, HATE, NONE)
     * 댓글 - comments, userComment
     * 페이지 - totalPage, expand
     */         
    const [user, setUser] = useRecoilState(userState);
    const [title, setTitle] = useState("");
    const [content, setContent] = useState("");
    const [author, setAuthor] = useState("");
    const [createdAt, setCreatedAt] = useState("");
    const [hashtags, setHashtags] = useState([""]);
    const [likeCount, setLikeCount] = useState(0);
    const [hateCount, setHateCount] = useState(0);
    const [emotionType, setEmotionType] = useState(null);
    const [emotionActionType, setEmotionActionType] = useState(null);
    const [comments, setComments] = useState([]);
    const [userComment, setUserComment] = useState("");
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPage, setTotalPage] = useState(1);
    const [expanded, setExpanded] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    
    // ------- hooks  ------- //
    
    // 포스팅 정보 가져오기
    useEffect(()=>{                                         
        const endPoint = `/api/v1/post/detail?pid=${postId}`;
        axios
            .get(endPoint, {
                headers:{
                    Authorization:user.token??localStorage.getItem("token")
                }
            }).then((res)=>{
                return res.data.result
            }).then((res)=>{
                setTitle(res.title);
                setContent(res.content);
                setAuthor(res.nickname);
                setCreatedAt(res.createdAt);
                setHashtags(res.hashtags);
                handleLikeCount();
            }).catch((err)=>{
                console.log("useEffect 포스팅 정보 가져오기",err);
            })
    }, [])

    // 댓글창 
    useEffect(()=>{                                         
        const endPoint = `/api/v1/comment?pid=${postId}&page=${currentPage}`
        // 댓글창이 열린경우
        if (expanded){
            axios
                .get(endPoint, {
                    headers:{
                        Authorization:user.token??localStorage.getItem("token")
                    }
                }).then((res)=>{
                    return res.data.result;                
                }).then((res)=>{
                    setComments([...res.content]);              // 댓글
                    setCurrentPage(res.pageable.pageNumber);    // 페이지
                    setTotalPage(res.totalPages);               // 전체페이지
                }).catch((err)=>{
                    console.log("useEffect 댓글 정보 가져오기",err);
                });
        }
    }, [expanded, isLoading, currentPage])


    // ------- handeler  -------

    // 댓글창 열기 / 닫기
    const handleExpandClick = () => {
        setExpanded(!expanded);
    };

    // 댓글 최대 500자
    const handleUserComment = (e) => {
        setUserComment(e.target.value.slice(0, 500));
    }

    // 댓글 입력
    const handleSumbitComment = async (e) => {
        const endPoint = `/api/v1/comment`
        setIsLoading(true);
        await axios.post(endPoint, {postId, content:userComment}, {
                headers:{
                    Authorization:user.token??localStorage.getItem("token")
                }
            }).then((res)=>{
                setUserComment("");
            }).catch((err)=>{
                console.log("handleSumbitComment",err);
            }).finally(()=>{
                setIsLoading(false);
            })
    }

    const handleLikeCount = async () => {
        const endPoint = `/api/v1/emotion?pid=${postId}`;
        await axios.get(endPoint, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            return res.data.result;
        }).then((res)=>{
            setLikeCount(res.likeCount);
            setHateCount(res.hateCount);
            setEmotionType(res.emotionType);
        }).catch((err)=>{
            console.log("감정표현 정보가져오기",err);
        })
    }
 
    const handleLike = (type) => async (e) => {
        let data = {};
        const endPoint = `api/v1/emotion?pid=${postId}`;
        setIsLoading(true);
        if (emotionType === "NONE"){
            data = {emotionType:type, emotionActionType:"NEW"};
            setEmotionType(type);
        } else if (type === emotionType){
            data = {emotionType:type, emotionActionType:"CANCEL"};
            setEmotionType("NONE");
        } else {
            data = {emotionType:type, emotionActionType:"SWITCH"};
            setEmotionType(type==="LIKE"?"HATE":"LIKE");
        }
        await axios.post(endPoint, data, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            handleLikeCount();
        }).catch((err)=>{
            console.log("handleLike",err);
        }).finally(()=>{
            setIsLoading(false);
        })
    }

    const handleCommentPage = (e) => {
        setCurrentPage((parseInt(e.target.outerText)??1)-1);
    }

    return (
        <>
            <Card>
                {/* 작성자 & 작성시간 */}
                <CardHeader
                    avatar={
                        <Avatar sx={{ bgcolor: red[500] }} aria-label="recipe">
                            R
                        </Avatar>
                    }
                    title={author}
                    subheader={createdAt}
                />

                {/* TODO : 이미지 삽입기능 */}
                {/* <CardMedia
                    component="img"
                    height="194"
                    image="/static/images/cards/paella.jpg"
                    alt="Paella dish"
                /> */}

                {/* 본문 */}
                <CardContent>
                    <TextField value={content} sx={{width:"100%"}} multiline variant='filled'/>
                    <Divider />
                </CardContent>

                {/* 해쉬태그 */}           
                <Box sx={{display:'flex', width:'100%', padding:'1vh'}} color="primary">
                    {hashtags.map((h, i)=>{
                        return(
                            <Typography variant="span" component="span" color="primary" key={i} sx={{marginLeft:"2vh"}}>
                                #{h}
                            </Typography>
                        )
                    })}           
                    <Divider />   
                </Box>
            
                <CardActions disableSpacing>    
                    {/* 좋아요 아이콘 */}
                    <IconButton onClick={handleLike("LIKE")}>
                        <ThumbUpIcon sx={{color:(emotionType==="LIKE")?"red":"gray"}}/> {likeCount}
                    </IconButton>
                    {/* 싫어요 아이콘 */}
                    <IconButton onClick={handleLike("HATE")}>
                        <ThumbDownIcon sx={{color:(emotionType==="HATE")?"blue":"gray"}}/> {hateCount}
                    </IconButton>

                    <ExpandMore
                        expand={expanded}
                        onClick={handleExpandClick}
                        aria-expanded={expanded}>
                        <ExpandMoreIcon />
                    </ExpandMore>
                </CardActions>
                
                <Collapse in={expanded} timeout="auto" unmountOnExit>
                    <Box sx={{ flexGrow: 1, padding:'1vh' }}>
                        {/* 댓글 입력창 */}
                        <Grid container spacing={2}>
                            <Grid item xs={11}>     
                                <Tooltip title="500자 내외로 댓글을 작성해주세요">
                                    <TextField label={userComment?`${userComment.length}/500`:"댓글"} sx={{width:'100%'}}
                                    variant="standard" multiline onChange={handleUserComment} value={userComment}/>                          
                                </Tooltip>                 
                            </Grid>
                                {/* 댓글 전송 */}
                            <Grid item xs={1}>
                                <Tooltip title="댓글작성">
                                    <IconButton onClick={handleSumbitComment} disabled={isLoading} sx={{color:isLoading?"gray":"blue"}}>
                                        <SendIcon/>
                                    </IconButton>
                                </Tooltip>
                            </Grid>
                        </Grid>
                    </Box>
                    <CardContent>                              
                        {/* 댓글 */}
                            {
                                comments.map((c, i)=>{
                                    return (
                                        <Grid container key={i}>
                                            <Typography variant="strong" component="div">
                                                <strong>{c.content}</strong>
                                            </Typography>
                                            <Grid container>
                                                <Grid item xs={4}>
                                                    <Typography sx={{ mb: 1.5 }} color="text.secondary">
                                                        by {c.nickname}
                                                    </Typography>
                                                </Grid>
                                                <Grid item xs={4}>
                                                </Grid>
                                                <Grid item xs={4}>
                                                    <Typography sx={{ mb: 1.5 }} color="text.secondary">
                                                        {c.createdAt}
                                                    </Typography>
                                                </Grid>
                                            </Grid>                                          
                                        </Grid>
                                    )
                                })
                            } 

                    {/* 댓글페이지 */}
                    <Box sx={{justifyContent:"center", display:"flex", marginTop:"5vh"}}>
                        <Pagination count={totalPage} defaultPage={currentPage+1} boundaryCount={5} onChange={handleCommentPage}
                            color="primary" size="large" sx={{margin: '2vh'}}/>
                    </Box>
                    </CardContent>

                    
                </Collapse>
            </Card>
        </>
    );
}


export default DetailPost;