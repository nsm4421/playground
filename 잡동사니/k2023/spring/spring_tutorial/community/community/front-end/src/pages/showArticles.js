import { Create } from "@mui/icons-material";
import { Avatar, Button, IconButton, Pagination, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { useEffect, useState } from "react";
import ArticleIcon from '@mui/icons-material/Article';
import { getArticlesApi, searchArticleApi } from "../api/articleApi";
import Article from "../components/article";
import SearchArticle from "../components/searchArticle";
import { useNavigate } from "react-router-dom";

const HeaderForShowArticle = () => {

    const navigator = useNavigate();
    const goToWritePage = () => {navigator("/article/write");};

    return (
        <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 5, mb: 5 }}>

            <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>

                <Avatar sx={{ mr: 2 }}>
                    <ArticleIcon/>
                </Avatar>

                <Typography
                    variant="h5"
                    sx={{ fontWeight: 'bold', display: 'flex' }}>
                    게시글 보기
                </Typography>
            </Box>

            <IconButton color="primary" onClick={goToWritePage}>
                <Create/>
                <Typography sx={{ml:1}}>글쓰기</Typography>
            </IconButton>
            
        </Box>
    )
}

export default function ShowArticle(){
    
    const [searchType, setSearchType] = useState("TITLE");
    const [searchWord, setSearchWord] = useState("");
    const [currentPage, setCurrentPage] = useState(0);
    const [articles, setArticles] = useState([]);
    const [totalElements, setTotalElements] = useState(0);
    const [totalPages, setTotalPages] = useState(1);
    const [isLoading, setIsLoading] = useState(false);

    const successCallback = (res) => {
        const data = res.data.data;
        console.log(data);
        setArticles(data.content);
        setTotalElements(data.totalElements);
        setTotalPages(data.totalPages);       
    }

    const failureCallback = (err) => {
        alert("게시글을 불러오기 실패")
        console.log(err);
    }

    const handleGetArticle = async () => {
        setIsLoading(true);
        await getArticlesApi(currentPage, successCallback, failureCallback);
        setIsLoading(false);
        setSearchWord("");
    }

    const handleSearchArticle = async () => {
        setIsLoading(true);
        await searchArticleApi(searchType, searchWord, successCallback, failureCallback);
        setIsLoading(false);
    }

    const handleCurrentPage = (e, v) => {
        setCurrentPage(v-1);
    };

    // 페이지 번호가 변경될 때마다 게시글 다시 불러오기
    useEffect(() => {
        handleGetArticle();
    }, [currentPage]);

    if (isLoading) {
        return (
            <div>
                <h1>로딩중...</h1>
            </div>
        )
    }

    return (
        <div>

            {/* 헤더 */}
            <HeaderForShowArticle />
            {
                totalElements===0
                ? <p>조회된 게시물이 없습니다.</p>
                : <p>전체 게시글수 : {totalElements}</p>
            }
            
            {/* 검색창 */}
            <SearchArticle searchType={searchType} setSearchType={setSearchType} searchWord={searchWord} setSearchWord={setSearchWord}
                isLoading={isLoading} setIsLoading={setIsLoading} handleSearchArticle={handleSearchArticle} handleGetArticle={handleGetArticle}
            />

            {/* 게시글 */}
            {
                articles.map((a, i) => {
                    return (
                        <Box key={i} sx={{mt:1}}>
                            <Article article={a} isLoading={isLoading} setIsLoading={setIsLoading} />
                            <hr />
                        </Box>
                    )
                })
            }
            
            {/* 페이지 */}
            <Box>
                <Pagination onChange={handleCurrentPage} count={totalPages} color="primary" sx={{justifyContent:'center'}}/>
            </Box>
    
            <div style={{height:'50px'}}>

            </div>
        </div>
    )
}