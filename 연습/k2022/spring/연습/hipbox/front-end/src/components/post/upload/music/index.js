import { useState } from "react";
import { Button } from "react-bootstrap";
import Form from 'react-bootstrap/Form';
import { useNavigate } from "react-router-dom";
import Api from "../../../../utils/Api";
import textUtil from "../../../../utils/textUtil";
import { RiFolderMusicFill } from "@react-icons/all-files/ri/RiFolderMusicFill";
import { AiFillPicture } from "@react-icons/all-files/ai/AiFillPicture";
import { FaHashtag } from "@react-icons/all-files/fa/FaHashtag";
import { AiFillPlusCircle } from "@react-icons/all-files/ai/AiFillPlusCircle";
import { AiFillMinusCircle } from "@react-icons/all-files/ai/AiFillMinusCircle";
import { BiBracket } from "@react-icons/all-files/bi/BiBracket";
import { AiOutlineCloudUpload } from "@react-icons/all-files/ai/AiOutlineCloudUpload";

const UploadForm = () => {

  const navigator = useNavigate();
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [hashtag, setHashtag] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  const handleTitle = textUtil(30, setTitle);
  const handleDescription = textUtil(3000, setDescription);

  const handleHashtag = (idx) => (e) => {
    const newHashtag = [... hashtag];
    let v = e.target.value;
    if (v.length <= 30){
      v = v.slice(0, Math.min(v.length, 30));
    }
    newHashtag[idx] = e.target.value;
    setHashtag(newHashtag);
  }

  const addHashtag = (e) => {
    e.preventDefault();
    if (hashtag.length<5){
      setHashtag([...hashtag, ""]);
    };
  }

  const deleteHashtag = (idx) => (e) => {
    e.preventDefault();
    let newHashtag = [... hashtag];
    newHashtag.pop(idx);
    setHashtag(newHashtag);
  }

  const handleSubmit = (e)=>{
    setIsLoading(true);
    e.preventDefault();
    let music = document.getElementById("music").files[0];
    let thumbnail = document.getElementById("thumbnail").files[0];
     
    const formData = new FormData();

    formData.append("title", title);
    formData.append("description", description);
    formData.append("hashtag", new Set(hashtag));
    formData.append("music", music);  
    formData.append("thumbnail", thumbnail);
  
    let xhr = new XMLHttpRequest();
    xhr.open(Api.uploadMusic.METHOD, Api.uploadMusic.URL); 
    xhr.setRequestHeader("Authorization", `Bearer ${localStorage.getItem('token')}`);
    xhr.onload = (e) => { 
      const res = JSON.parse(e.target.response)
      if(res.resultCode === "SUCCESS"){
        alert("파일이 업로드 되었습니다.");
        navigator("/");
      } else {
        alert("파일 업로드에 실패하였습니다.");
        console.log(e);
      }
    }; 
    xhr.send(formData);
    setIsLoading(false); 
  };

  return (
  
    <Form>

        <Form.Group className="mt-3">
          <BiBracket style={{marginRight:'10px'}}/>
          <Form.Label>제목</Form.Label>
          <Form.Control className="mt-3" onChange={handleTitle} value={title} placeholder="30자 이내로 입력해주세요"/>
        </Form.Group>
        
        <Form.Group className="mt-3">
          <BiBracket style={{marginRight:'10px'}}/>
          <Form.Label className="mt-3">설명</Form.Label>
          <Form.Control as={"textArea"} style={{resize:"none"}} className="mt-3" onChange={handleDescription} 
            value={description} placeholder="3000자 이내로 입력해주세요"/>
        </Form.Group>
        
        <Form.Group className="mt-3">
          <Form.Label className="mt-3"><AiFillPicture style={{marginRight:'10px'}}/>썸네일</Form.Label>
          <Form.Control type="file" className="mt-3" id="thumbnail"/>
          <Form.Text>.jpg / .png</Form.Text>
        </Form.Group>
        
        <Form.Group className="mt-3">
          <Form.Label className="mt-3"><RiFolderMusicFill style={{marginRight:'10px'}}/>음악</Form.Label>
          <Form.Control type="file" className="mt-3" id="music"/>
          <Form.Text>.mp4 / .avi</Form.Text>
        </Form.Group>

        <Form.Group className="mt-3">
          <Form.Label className="mt-3"><FaHashtag style={{marginRight:'10px'}}/>해쉬태그</Form.Label>
          <br/>
          <div onClick={addHashtag} className="mt-1">
            <AiFillPlusCircle style={{marginRight:'10px'}}></AiFillPlusCircle>
            <Form.Text className="mt-3">최대 5개까지 해쉬태그를 추가할 수 있습니다.</Form.Text>
          </div>

            {
              [...Array(hashtag.length).keys()].map((_, idx)=>{
                return (
                  <span key={idx} className="mt-3" style={{display:"flex", alignItems:"center"}}>
                    <input onChange={handleHashtag(idx)} value={hashtag[idx]} placeholder={`hashtag ${idx+1}`}
                      style={{borderTop:"none", borderLeft:"none", borderRight:"none"}}></input>
                    <AiFillMinusCircle onClick={deleteHashtag(idx)} style={{marginLeft:'10px'}}/>
                  </span>
                )
                })
            }

        </Form.Group>
    
        <Button type="submit" variant="success" className="mt-3" disabled={isLoading} onClick={handleSubmit}>
          <AiOutlineCloudUpload/> 업로드
        </Button>
    
    </Form>
  )
};

export default UploadForm;