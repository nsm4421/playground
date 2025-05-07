import { useEffect, useState } from "react"
import { getCommentApi, writeCommentApi } from "../api/commentApi";

export default function Comment({articleId}){
    const [comments, setComments] = useState([]);
    const [userComment, setUserComment] = useState("");
    const [parentCommentId, setParentCommentId] = useState(null);
    const [isLoading, setIsLoading] = useState(false);
    const handleUserComment = (e) => setUserComment(e.target.value);

    const getArticle = async () => {
        const successCallback = (res) => setComments([...res.data.data.content]);
        const failureCallback = () => {};
        getCommentApi(articleId, successCallback, failureCallback);
    }

    const handleSubmit = async () => {
        const successCallback = () => {};
        const failureCallback = () => {};
        setIsLoading(true);
        await writeCommentApi(articleId, parentCommentId, userComment, successCallback, failureCallback);
        setUserComment("");
        await getArticle();
        setIsLoading(false);        
    }

    useEffect(()=>{
        const _getArticle = async () => {
            setIsLoading(true);
            await getArticle();
            setIsLoading(false);
        }
        _getArticle();
    }, [])

    if (isLoading){
        return (
            <div>
                <h1>로딩중</h1>
            </div>
        )
    }

    return(
        <div>
            <h3>댓글</h3>
            <input value={userComment} onChange={handleUserComment} placeholder="댓글을 입력해주세요"/>
            <button disabled={isLoading} onClick={handleSubmit}>댓글입력</button>

            {
                comments.map((c, i)=>{
                    return (
                        <div key={i}>
                            <div>
                                <span>댓글내용</span>
                                <br/>
                                <span>{c.content}</span>
                            </div>
                            <div>
                                <span>작성자</span>
                                <br/>
                                <span>{c.userAccountDto.nickname}</span>
                            </div>
                            <div>
                                <span>작성시간</span>
                                <br/>
                                <span>{c.createdAt}</span>
                            </div>
                            <div>
                                <span>수정시간</span>
                                <br/>
                                <span>{c.modifiedAt}</span>
                            </div>                               
                        </div>
                    )
                })
            }
        </div>   
    )
}