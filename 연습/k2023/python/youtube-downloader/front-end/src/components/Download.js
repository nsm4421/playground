import { useState } from "react";
import MyAlert from './MyAlert';
import axios from "axios";

export default function Download({ytLink, setYtLink, isAudio, setIsAudio, isLoading, setIsLoading}){
    /**
     * isLoading : 다운로드 중에는 true로 변해서 다운로드 버튼을 못누르게 막음
     * isError : 다운로드 중 에러 발생시 Alert창 렌더링 여부
     * errorMessage : 에러메세지
     */
    
    const [isError, setIsError] = useState(false);
    const [errorMessage, setErrorMessage] = useState("");
    const handleIsAudio = (e) => {setIsAudio(e.target.value==="AUDIO")};
    const handleYtLink = (e) => {setYtLink(e.target.value)};
    const handleSubmit = async (e) => {
        setIsLoading(true);
        const endPoint = "/download";
        const data = {ytLink, isAudio}
        await axios.post(endPoint, data, {}).then((res)=>{
            setYtLink("");
        }).catch((err)=>{
            setIsError(true);
            setErrorMessage("Download 에러 ▷", err.message);
            console.log(err);
        }).finally(()=>{
            setIsLoading(false);
        })        
    }
    return (
        <div className="row mt-5 mb-3">
           
            {/* 오류 발생시 오류 발생창 */}
            <MyAlert variant={'danger'} show={isError} setShow={setIsError} message={errorMessage} setMessage={setErrorMessage}/>

            <div className="row mt-3 mb-3">

                <div className="col-md-1">
                    <span className="input-group-text">링크</span>
                </div>

                {/* 영상/음향 선택창 */}
                <div className="dropdown col-md-2">
                    <select className="form-select" onChange={handleIsAudio}>
                        <option defaultValue value="VIDEO">영상</option>
                        <option value="AUDIO">음성</option>
                    </select>       
                </div>

                {/* 유트브 링크 입력 */}
                <div className="col-md-6">
                    <input onChange={handleYtLink} type="text" className="form-control" placeholder="link..."/>
                </div>

                {/* 다운로드 버튼 */}
                <div className="col-md-2">
                    <button type="button" className="btn btn-primary" disabled={isLoading} onClick={handleSubmit}>
                        {isLoading?"다운로드 중....":"다운로드"}
                    </button>
                </div>

            </div>
        </div>
    )
}
