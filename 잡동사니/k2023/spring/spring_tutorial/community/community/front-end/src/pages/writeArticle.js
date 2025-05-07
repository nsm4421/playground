import { Article, Upload } from "@mui/icons-material";
import { Avatar, Button, IconButton, Paper, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { useState } from "react"
import { useNavigate } from "react-router-dom";
import { writeArticleApi } from "../api/articleApi";
import CreateIcon from '@mui/icons-material/Create';
import WriteArticleForm from "../components/writeArticleForm";
import { useRecoilState } from "recoil";
import { userState } from "..";

export default function WriteArticle() {

    // TODO : 이미지 업로드 
    const [user,setUser] = useRecoilState(userState);
    const navigator = useNavigate();
    const [title, setTitle] = useState("");
    const [content, setContent] = useState("");
    const [hashtags, setHashtags] = useState([""]);
    const [isLoading, setIsLoading] = useState(false);

    const goToArticlePage = () => {navigator("/article");};

    const checkInput = async () => {
        if (!title) {
            alert("제목을 입력해주세요");
            return false;
        }
        if (!content) {
            alert("본문을 입력해주세요");
            return false;
        }
        return true;
    }

    const handleSubmit = async () => {
        if (!await checkInput())return;
        setIsLoading(true);
        await writeArticleApi(
            title,
            content,
            hashtags,
            () => {
                navigator("/article");
            },
            (err) => {
                alert("게시글 업로드 실패");
                console.log(err);
            },
            {
                Headers:{
                    Authorization:`Bearer ${user.kakao.token}`
                }
            })
        setIsLoading(false);
    }

    return (
        <div>

            <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 5, mb: 5 }}>
                
                <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    
                    <Avatar sx={{ mr: 2 }}>
                        <CreateIcon/>
                    </Avatar>

                    <Typography
                        variant="h5"
                        sx={{ fontWeight: 'bold', display: 'flex' }}>
                        게시글 작성하기
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
                        <Upload />
                        <Typography sx={{ ml: 1 }}>게시글 작성하기</Typography>
                    </IconButton>
                </Box>

            </Box>

            <WriteArticleForm title={title} setTitle={setTitle} content={content} setContent={setContent} hashtags={hashtags} setHashtags={setHashtags} />

        </div>
    )
}
