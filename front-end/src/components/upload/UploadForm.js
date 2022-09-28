import { useState } from "react";
import { useNavigate } from "react-router-dom";
import Api from "../../Api";

const UploadForm = () => {

  const navigator = useNavigate();
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = (e)=>{
    setIsLoading(true);
    e.preventDefault();
    let xhr = new XMLHttpRequest();
    xhr.open(Api.uploadMusic.METHOD, Api.uploadMusic.URL); 
    xhr.onload = (e) => { 
      if(e.target.response.resultCode){
        alert("파일이 업로드 되었습니다.");
        navigator("/");
      } else {
        alert("파일 업로드에 실패하였습니다.");
        console.log(e.target.response);
      }
    }; 
    const formData = new FormData(document.getElementById("music-upload-form")); 
    xhr.send(formData);
    setIsLoading(false);
  };

  return (
    <div>

      <h1>파일 업로드</h1>

      <form id="music-upload-form" encType="multipart/form-data" onSubmit={handleSubmit}>
        
        <label>제목</label>
        <input type="text" name="title"></input>

        <label>설명</label>
        <input type="text" name="description"></input>

        <label>음악</label>
        <input type="file" name="music"></input>
        
        <label>썸네일</label>
        <input type="file" name="thumbnail"></input>
        
        <label>제출</label>
        <button type="submit" disabled={isLoading}>Submit</button>

      </form>   
    </div>
  )
};

export default UploadForm;