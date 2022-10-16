import axios from "axios";
import { useEffect, useState } from "react";
import Api from "../../../../utils/Api";
import Pagination from "../pagination";

const Page = () => {

    const [pageNum, setPageNum] = useState(0);
    const [size, setSize] = useState(20);
    const [totalPages, setTotalPages] = useState(0);
    const [posts, setPosts] = useState([]);

    const getPage = async () => {
        const url = `${Api.getPost.URL}?size=${size}&page=${pageNum}`;
        const token = `Bearer ${localStorage.getItem("token")}`;
        await axios
            .get(url, {
                headers:{
                    Authorization:token
                }
            })
            .then((res)=>{
                console.log(res);
                if (!res.data.resultCode === "SUCCESS"){
                    alert("페이지를 가져오는데 에러가 발생했습니다 - 서버 에러");
                    return;
                }
                setPosts(res.data.result.content);
                setTotalPages(res.data.result.totalPages);
            })
            .catch((err)=>{
                console.log(err);
                alert("페이지를 가져오는데 에러가 발생했습니다.");
            })
            .finally(()=>{
                
            })
    }

    useEffect(()=>{
        getPage();
    }, [pageNum]);

    return (
        <div>
            <h3>{pageNum}</h3>
       
            {
                posts.map((post, i) =>{
                    return (
                        <div key={i}>
                            <p>제목 : {post.title}</p>
                            <p>본문 : {post.body}</p>
                            <p>글쓴이 : {post.username}</p>
                            <p>작성시간 : {post.createdAt}</p>
                            <hr/>
                        </div>
                    )
                })
            }

        </div>
    );
};

export default Page;