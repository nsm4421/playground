import axios from "axios";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Api from "../../Api";

const UploadForm = () => {

  const navigator = useNavigate();
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [hashtag, setHashtag] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  const handleTitle = (e)=>{
    setTitle(e.target.value);
  }

  const handleDescription = (e) => {
    setDescription(e.target.value);
  }

  const handleHashtag = (idx) => (e) => {
    const newHashtag = [... hashtag];
    newHashtag[idx] = e.target.value;
    setHashtag(newHashtag);
  }

  const addHashtag = (e) => {
    e.preventDefault();
    setHashtag([...hashtag, ""]);
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
    <div>

      <h1>파일 업로드</h1>    
        
        <label>제목</label>
        <input type="text" onChange={handleTitle}></input>
        <br/>

        <label>설명</label>
        <input type="text" onChange={handleDescription}></input>
        <br/>

        <label>음악</label>
        <input type="file" id="music"></input>
        <br/>
        
        <label>썸네일</label>
        <input type="file" id="thumbnail"></input>
        <br/>

        <label>해쉬태그</label>
        <button onClick={addHashtag} disabled={hashtag.length>=5}>+</button>

        {
          [...Array(hashtag.length).keys()].map((_, idx)=>{
            return (
              <div key={idx}>
                <span>#</span>
                <input type="text" id={`hashtag${idx}`} onChange={handleHashtag(idx)}></input>
                <button onClick={deleteHashtag(idx)}>-</button>
                <br/>
              </div>
            )
          })
        }
        <br/>

        <label>제출</label>
        <button type="submit" disabled={isLoading} onClick={handleSubmit}>Submit</button>


    </div>
  )
};

export default UploadForm;