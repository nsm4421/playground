import { Box, Container } from "@mui/system";
import axios from "axios";
import { useEffect, useState } from "react";
import { Link, useLocation} from "react-router-dom";
import { Button, FormControl, MenuItem, Pagination, Select, Tooltip, Typography } from "@mui/material";
import CreateIcon from '@mui/icons-material/Create';
import PostCard from './PostCard';
import { useRecoilState } from "recoil";
import { userState } from "../../recoil/user";
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import SearchIcon from '@mui/icons-material/Search';

const PostList = ()=>{
    /**
     * States
     * MAX_LENGTH_SEARCH_VALUE : 검색값의 최대길이
     * searchType : 현재 페이지에 조회된 포스팅의 검색유형 (← 검색요청을 하는 순간 변경)
     * currentType : 검색유형
     * searchValue : 현재 페이지에 조회된 포스팅의 검색유형 (← 검색요청을 하는 순간 변경)
     * currentValue : 검색값
     * totalPage : 전체 페이지수
     * isLoading : 포스팅을 가져오는지 여부
     * user : 현재 로그인한 유저(Global State)
     */
    const MAX_LENGTH_SEARCH_VALUE = 30;
    const [searchType, setSearchType] = useState("NONE");
    const [currentType, setCurrentType] = useState("NONE");
    const [searchValue, setSearchValue] = useState("");
    const [currentValue, setCurrentValue] = useState("");
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPage, setTotalPage] = useState(0);
    const [posts, setPosts] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [user, setUser] = useRecoilState(userState);
    
    // ------- hooks ------- //
    useEffect(()=>{
        setIsLoading(true);
        // 서버요청
        const endPoint = `/api/v1/post?page=${currentPage}&searchType=${searchType??'NONE'}&searchValue=${searchValue??'NONE'}`;    
        axios.get(endPoint, {
            headers:{
                Authorization:user.token??localStorage.getItem("token")
            }
        }).then((res)=>{
            return res.data.result
        }).then((res)=>{
            setCurrentPage(res.pageable.pageNumber);    // 현재 페이지수
            setTotalPage(res.totalPages);               // 전체 페이지수    
            setPosts([...res.content]);                 // 포스팅 정보
        })
        .catch((err)=>{
            console.log(err);
        })
        .finally(()=>{
            setIsLoading(false);
        })
    }, [currentPage, searchType, searchValue]);

    // ------- handler ------- //
    const handlePage = (e) => {
        setCurrentPage((parseInt(e.target.outerText)??1)-1);
    }
    const handleCurrentType = (e) =>{
        setCurrentType(e.target.value);
    }
    const handleCurrentValue = (e) => {
        let input = e.target.value;
        if (currentType === "HASHTAG") input=input.replace("#", "");
        input = input.slice(0, MAX_LENGTH_SEARCH_VALUE);
        setCurrentValue(input);
    }
    const handleSearch = (e) => {
        setSearchType(currentType);
        setSearchValue(currentValue);
    }

    return (
        <>
        <Container>

            <Paper component="form" sx={{display: 'flex', width: '100%',alignItems: 'center', marginTop:'3vh', padding:'10px'}}>
                
                {/* 검색유형 드롭박스 */}
                <FormControl variant="standard" sx={{ m: 1, minWidth: 120 }}>
                    <Select value={currentType} onChange={handleCurrentType} label="searchType">
                        <MenuItem value={"NONE"}>NONE</MenuItem>
                        <MenuItem value={"TITLE"}>제목</MenuItem>
                        <MenuItem value={"NICKNAME"}>작성자</MenuItem>
                        <MenuItem value={"HASHTAG"}>해쉬태그</MenuItem>
                        <MenuItem value={"CONTENT"}>본문</MenuItem>
                    </Select>
                </FormControl>

                {/* 입력창 */}
                <InputBase sx={{ ml: 1, flex: 1 }} placeholder="검색어를 입력하세요" onChange={handleCurrentValue} value={currentValue} disabled={currentType==="NONE"}/>

                {/* 검색하기 */}
                <Tooltip title={`검색어는 최대 ${MAX_LENGTH_SEARCH_VALUE}자`}>
                    <Button type="button" sx={{ p: '10px' }} variant="contained" disabled={isLoading} onClick={handleSearch}>
                        <SearchIcon sx={{marginRight:'5px'}}/><Typography>검색하기</Typography>
                    </Button>
                </Tooltip>

                {/* 포스팅 작성페이지로 */}
                <Link to="/post/write">
                    <Button variant="contained" color="success" sx={{ p: '10px', marginLeft:'10px' }}>
                        <CreateIcon sx={{marginRight:'5px'}}/><Typography>포스팅 작성</Typography>
                    </Button>
                </Link>
            </Paper>

            {/* helper Text */}
            {
                currentType === "HASHTAG"
                ?
                <Box>
                    <Typography sx={{marginLeft:"1vw", marginTop:"1vh"}} color="text.secondary">
                        해쉬 태그 검색시에는 하나의 해쉬태그를 검색해주세요
                    </Typography>
                </Box>
                :null
            }
    
            {/* 포스팅 */}    
            <Paper>                   
                {
                    posts.map((p, i)=>{
                        return (
                            <Box sx={{marginTop:'5vh'}} key={i}>
                                <PostCard post={p}/>
                            </Box>
                        )
                    })
                }
            </Paper> 
            
            {/* 페이지 */}
            <Box sx={{justifyContent:"center", display:"flex", marginTop:"5vh"}}>            
                <Pagination count={totalPage} defaultPage={1} boundaryCount={10} color="primary" size="large" sx={{margin: '2vh'}} onChange={handlePage}/>
            </Box>
        </Container>
        </>
    )
}

export default PostList;