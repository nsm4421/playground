import axios from "axios";
import { useState } from "react";
import { Button } from "react-bootstrap";
import Form from 'react-bootstrap/Form';
import Api from "../../../../utils/Api";
import textUtil from "../../../../utils/textUtil";
import { AiOutlineCloudUpload } from "@react-icons/all-files/ai/AiOutlineCloudUpload";
import { BiBracket } from "@react-icons/all-files/bi/BiBracket";

const Index = () => {

    const [title, setTitle] = useState("");
    const [body, setBody] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    
    const handleTitle = textUtil(30, setTitle);
    const handleBody = textUtil(3000, setBody);
    const handleSubmit = async (e) =>{
        e.preventDefault();
        setIsLoading(true);
        const token = `Bearer ${localStorage.getItem("token")}`;
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
                res.data.resultCode === "SUCCESS"?alert("포스트가 업로드 되었습니다."):alert("포스팅 업로드에 실패하였습니다.");
            })
            .catch((err)=>{
                alert("포스팅 업로드에 실패하였습니다.");
                console.log(err);
            })
            .finally(()=>{
                setIsLoading(false);
            })
    };

    return (     
        <Form>

            <Form.Group className="mt-3">
                <BiBracket style={{marginRight:'10px'}}/>
                <Form.Label>제목</Form.Label>
                <Form.Control className="mt-3 mb-3" onChange={handleTitle} value={title}/>
            </Form.Group>
            
            <Form.Group className="mt-3">
                <BiBracket style={{marginRight:'10px'}}/>
                <Form.Label className="mt-3">본문</Form.Label>
                <Form.Control as="textarea" style={{ height: '70%', resize:'none' }} className="mb-3 mt-3"
                    onChange={handleBody} value={body} placeholder="3000자 이내로 적어주세요"/>
            </Form.Group>

            <Button onClick={handleSubmit} disabled={isLoading} className="mt-3" variant="success">
                <AiOutlineCloudUpload/> 업로드
            </Button>
        </Form>
    );
};

export default Index;