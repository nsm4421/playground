import axios from "axios";
import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import CreateIcon from '@mui/icons-material/Create';
import { Button, FormControl, IconButton, InputAdornment, OutlinedInput, TextField, Tooltip, Typography } from "@mui/material";
import { Box, Container } from "@mui/system";
import UploadIcon from '@mui/icons-material/Upload';
import AddCircleOutlineRoundedIcon from '@mui/icons-material/AddCircleOutlineRounded';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import RemoveCircleOutlineRoundedIcon from '@mui/icons-material/RemoveCircleOutlineRounded';
import { useRecoilState } from "recoil";
import { userState } from "../../../recoil/user";

const ModifyPost = () => {
    const MAX_HASHTAG_NUM = 5;
    const MAX_HASHTAG_LENGTH = 10;    
    const navigator = useNavigate();
    // ------ state ------
    const params = useParams();
    let initHashtags = Array(MAX_HASHTAG_NUM).fill("");
    const [title, setTitle] = useState("");
    const [content, setContent] = useState("");
    const [hashtags, setHashtags] = useState(Array(MAX_HASHTAG_NUM).fill(""));
    const [numHashtags, setNumHashtags] = useState(0);
    const [isLoading, setIsLoading] = useState(false);
    const [user, setUser] = useRecoilState(userState);

    useEffect(()=>{
        const endPoint = `/api/v1/post/detail?pid=${params.pid}`;
        axios.get(
            endPoint,
            {
                headers:{
                    Authorization : user.token??localStorage.getItem("token")
                }
            }
        ).then((res)=>{
            return res.data.result;
        }).then((res)=>{
            res.hashtags.forEach((v, i, _)=>{
                initHashtags[i] = v;
            })
            setTitle(res.title);
            setContent(res.content);
            setHashtags(initHashtags);
            setNumHashtags(res.hashtags.length);
        }).catch((err)=>{
            alert("포스팅 업로드에 실패하였습니다 \n" + (err.response.data.resultCode??"알수 없는 서버 오류"));
            console.log(err);
        }).finally(()=>{
            setIsLoading(false);
        });
    }, []);

    // ------ handler ------
    const handleGoBack = (e) => {
        navigator(-1);
    }
    const handleTitle = (e) =>{
        setTitle(e.target.value.slice(0, 100));
    }
    const handleContent = (e) => {
        setContent(e.target.value.slice(0, 2000));
    }
    const handleHashtag = (i) => (e) => {
        let newHashtag = [...hashtags]
        if (e.target.value === ""){
            newHashtag[i] = ""
        } else {
            const matched = e.target.value.match(/^[\wㄱ-힣]+$/g);                            // 한글,숫자,영어
            newHashtag[i] = matched?matched[0].slice(0, MAX_HASHTAG_LENGTH):hashtags[i];     // 최대 10자
        }
        setHashtags(newHashtag);
    }
    const addHashtag = () => {
        setNumHashtags(Math.min(MAX_HASHTAG_NUM, numHashtags+1));
    }
    const deleteHashtag = () => {
        setNumHashtags(Math.max(0, numHashtags-1));
    }
    const handleSubmit = async (e) =>{
        const endPoint = "/api/v1/post";
        e.preventDefault();
        if (!title){
            alert("제목을 입력해주세요");
            return;
        }
        if (!content){
            alert("본문을 입력해주세요");
            return;
        }
        setIsLoading(true);
        // Hashtags 변수를 문자열로 변경
        // Ex) ["사과","파인애플","","",""] → "#사과#파인애플"
        let hashtagString = hashtags.map((h, i)=>{
            const matched = h.match(/^[\wㄱ-힣]+$/g);  
            return matched?matched[0]:null;
        }).filter((v, _)=>{
            return v;
        }).join("#");
        hashtagString = handleHashtag?"#"+hashtagString:""
        console.log({title, content, hashtags:hashtagString, postId:params.pid})
        await axios.put(
            endPoint,
            {title, content, hashtags:hashtagString, postId:params.pid},
            {
                headers:{
                    Authorization : localStorage.getItem("token")
                }
            }
        ).then((res)=>{
            navigator("/mypage");
        }).catch((err)=>{
            alert("포스팅 업로드에 실패하였습니다 \n" + (err.response.data.resultCode??"알수 없는 서버 오류"));
            console.log(err);
        }).finally(()=>{
            setIsLoading(false);
        });
    }
    
    return (
        <>
        <Container>
            <Box sx={{marginTop:'5vh', display:'flex', justifyContent:'space-between', alignContent:'center'}}>
                <Typography variant="h5" component="h5">
                    <CreateIcon/> 포스팅 수정하기
                </Typography>
                <Box>
                    {/* 뒤로가기 */}
                    <Button variant="contained" color="success" sx={{marginRight:'10px'}} onClick={handleGoBack}>
                        <ArrowBackIcon sx={{marginRight:'10px'}}/>뒤로가기
                    </Button>
                    {/* 수정하기 */}
                    <Button variant="contained" color="error" type="submit" onClick={handleSubmit} disabled={isLoading}>
                        <UploadIcon sx={{marginRight:'10px'}}/>수정하기
                    </Button>
                </Box>
            </Box>

            {/* 제목작성 */}
            <Box sx={{marginTop:'5vh'}}>
            <Box sx={{alignItems:'center'}}>
                    <Typography variant="h6" component="h6" sx={{display:'inline', marginRight:'20px'}}>제목</Typography>
                    <Typography variant="span" component="span" sx={{color:'gray'}}>
                        ({title.length} / 100)
                    </Typography>
                </Box>
                <TextField
                    sx={{width:'100%'}}
                    onChange={handleTitle}
                    variant="outlined"
                    color="warning"
                    maxRows={1}
                    value={title}
                    focused/>  
            </Box>
            
            {/* 본문작성 */}
            <Box sx={{marginTop:'5vh'}}>
                <Box sx={{alignItems:'center'}}>
                    <Typography variant="h6" component="h6" sx={{display:'inline', marginRight:'20px'}}>본문</Typography>
                    <Typography variant="span" component="span" sx={{color:'gray'}}>
                        ({content.length} / 2000)
                    </Typography>
                </Box>
                <TextField
                    sx={{width:'100%'}}
                    onChange={handleContent}
                    variant="outlined"
                    color="warning"
                    value={content}
                    multiline
                    focused/>
            </Box>

             {/* 해쉬태그작성 */}
             <Box sx={{marginTop:'5vh'}}>
                <Box sx={{alignItems:'center'}}>
                    <Typography variant="h6" component="h6" sx={{display:'inline', marginRight:'20px'}}>해쉬태그</Typography>
                    <Typography variant="span" component="span" sx={{color:'gray'}}>
                        ({numHashtags} / 5)
                    </Typography>
                    {/* 해쉬태그 추가/삭제하기 */}
                    <IconButton sx={{height:'100%'}}>
                        <AddCircleOutlineRoundedIcon onClick={addHashtag}/>
                    </IconButton>
                    <IconButton sx={{height:'100%'}}>
                        <RemoveCircleOutlineRoundedIcon onClick={deleteHashtag}/>
                    </IconButton>
                </Box>
                {/* 해쉬태그 입력창 */}
                {
                   hashtags.map((h, i)=>{
                        if (numHashtags>i){
                            return (
                                <Tooltip key={i} title={`한글,영어,숫자로 ${MAX_HASHTAG_LENGTH}자이내(띄어쓰기,특수문자x)`}>
                                    <FormControl sx={{ m: 1 }} onChange={handleHashtag(i)}>
                                        <OutlinedInput value={h} startAdornment={<InputAdornment position="start">#</InputAdornment>} />
                                    </FormControl>
                                </Tooltip>
                            )
                        }
                        return;
                   })
                }
                
            </Box>           

        </Container>
        </>
    )
}

export default ModifyPost;