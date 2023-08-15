import { Article, Upload } from "@mui/icons-material";
import CreateIcon from '@mui/icons-material/Create';
import { Avatar, Button, IconButton, Paper, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { useEffect, useState } from "react"
import { useNavigate, useParams } from "react-router-dom";
import { getArticleApi, modifyArticleApi } from "../api/articleApi";
import WriteArticleForm from "../components/writeArticleForm";

export default function ModifyArticle(){   
    
    const params = useParams();
    const navigator = useNavigate();
    const [title, setTitle] = useState("");
    const [content, setContent] = useState("");
    const [hashtags, setHashtags] = useState([""]);
    const [isLoading, setIsLoading] = useState(false); 

    const goToArticlePage = () => {navigator("/article");};

    const checkInput = () => {
        if (!title){
            alert("제목을 입력해주세요");
            return false;
        }
        if (!content){
            alert("본문을 입력해주세요");
            return false;
        }
        return true;
    }

    const handleSubmit = async () => {
        if (!await checkInput()) return;
        setIsLoading(true);
        await modifyArticleApi(
            params.id,
            title,
            content,
            hashtags,
            () => {
                navigator("/article")
            },
            (err)=>{
                alert("포스팅 수정 실패")
                console.log(err);
            }
        );
        setIsLoading(false);
    }

    useEffect(()=>{       
        const _getArticle = async () => {
            setIsLoading(true);
            await getArticleApi(params.id, (res) => {
                const data = res.data.data;
                setTitle(data.title);
                setContent(data.content);
                setHashtags(data.hashtags);
            }, console.log);;
            setIsLoading(false);
        }
        _getArticle();
    }, []);

    return(
        <div>

            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 5, mb: 5 }}>

                <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>

                    <Avatar sx={{ mr: 2 }}>
                        <CreateIcon />
                    </Avatar>

                    <Typography
                        variant="h5"
                        sx={{ fontWeight: 'bold', display: 'flex' }}>
                        게시글 수정하기
                    </Typography>
                </Box>


                <Box>

                    <IconButton
                        variant="contained"
                        color="primary"
                        onClick={goToArticlePage}>
                        <Article/>
                        <Typography sx={{ ml: 1 }}>게시글 페이지로</Typography>
                    </IconButton>

                    <IconButton
                        variant="contained"
                        color="success"
                        disabled={isLoading}
                        onClick={handleSubmit}>
                        <Upload/>
                        <Typography sx={{ ml: 1 }}>게시글 수정하기</Typography>
                    </IconButton>

                </Box>
            

            </Box>
            <WriteArticleForm title={title} setTitle={setTitle} content={content} setContent={setContent} hashtags={hashtags} setHashtags={setHashtags} />
        </div>
    )
}
