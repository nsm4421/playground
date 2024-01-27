import { Box, Container } from "@mui/system";
import axios from "axios";
import { useEffect, useState } from "react";
import Paper from '@mui/material/Paper';
import MyPostCard from "./MyPostCard";
import { Pagination } from "@mui/material";
import { useRecoilState } from "recoil";
import { userState } from "../../../recoil/user";

const MyPostList = ({nickname})=>{
    /**
     * States
     * totalPage : 전체 페이지수
     * isLoading : 포스팅을 가져오는지 여부
     * user : 현재 로그인한 유저(Global State)
     */
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPage, setTotalPage] = useState(0);
    const [posts, setPosts] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [user, setUser] = useRecoilState(userState);
    // ------- hooks ------- //
    useEffect(()=>{
        setIsLoading(true);
        // 서버요청
        const endPoint = `/api/v1/post/my?page=${currentPage}`;    
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
    }, [currentPage]);

    // ------- handler ------- //
    const handlePage = (e) => {
        setCurrentPage((parseInt(e.target.outerText)??1)-1);
    }

    return (
        <>
        <Container>

            {/* 포스팅 */}    
            <Paper>          
                {
                    posts.map((p, i)=>{
                        return (
                            <Box sx={{marginTop:'5vh'}} key={i}>                
                                <MyPostCard post={p}/>
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

export default MyPostList;