import axios from "axios";
import { useState } from "react";
import Api from "../../../Api";

const Index = () => {

    const [title, setTitle] = useState("");
    const [body, setBody] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    
    const handleTitle = (e)=>{setTitle(e.target.value);};
    const handleBody = (e)=>{
        let v = e.target.value;
        if (v.length > 3000){
            v = v.slice(0, Math.min(v.length, 3000));
        }
        setBody(v);
    };
    const handleSubmit = async (e) =>{
        e.preventDefault();
        setIsLoading(true);
        const token = localStorage.getItem("token");
        if (token==null){
            alert("로그인을 해야 합니다.");
            setIsLoading(false);
            return;
        }
        await axios
            .post(Api.uploadPost.URL,{
                title, body
            },{
                headers:{
                    Authorization:token
                }
            })
            .then((res)=>{
                console.log(res);
            })
            .catch((err)=>{
                console.log(err);
            })
            .finally(()=>{
                setIsLoading(false);
            })
    };

    return (
        <div>
            <h1>포스팅 업로드</h1>

            <label>제목</label>
            <br/>
            <input onChange={handleTitle} value={title}></input>
            <br/>

            <label>본문</label>
            <br/>
            <textarea onChange={handleBody} value={body}></textarea>
            <p>{body.length}/3000</p>
            <br/>

            <button onClick={handleSubmit} disabled={isLoading}>업로드</button>
        </div>
    );
};

export default Index;