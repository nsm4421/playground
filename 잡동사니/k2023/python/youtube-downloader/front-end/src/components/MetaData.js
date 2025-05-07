import { useEffect, useState } from "react";
import axios from "axios";
import MyAlert from "./MyAlert";
export default function MetaData({ytLink, isAudio, metaData, setMetaData, isLoading}){
    const [isError, setIsError] = useState(false);
    const [errorMessage, setErrorMessage] = useState("");
    const data = [
        {label:"제목", value:metaData.title},
        {label:"조회수", value:metaData.numView},
        {label:"설명", value:metaData.description},
        {label:"썸네일", value:metaData.thumbnail, isImage:true},
    ]
    useEffect(()=>{
        // 로딩중(다운로드 버튼 누른 후)인 경우 썸네일 가져오기
        if (isLoading){
            const endPoint = "/meta";
            const data = {ytLink, isAudio};
            axios.post(endPoint, data, {}).then((res)=>{
                return res.data
            }).then((res)=>{
                setMetaData(res);
            }).catch((err)=>{
                console.log("MetaData ▷ ", err);
                setIsError(true);
                setErrorMessage("MetaData 다운로드 에러");
            })
        }
        return;
    }, [isLoading])
    return(
        <div className="container mt-5 p-3 border border-success-subtle">

            <div className="row mt-3 mb-3">
                <h5>Meta Data</h5>
            </div>         

            {
                isError
                ?<MyAlert variant={'danger'} show={isError} setShow={setIsError} message={errorMessage} setMessage={setErrorMessage}/>
                : null
            }

            <hr/>

            {
                data.map((d, i)=>{
                    return <Infomation label={d.label} value={d.value} isImage={d.isImage??false} key={i}/>
                })
            }

        </div>
    )
}

function Infomation ({label, value, isImage}) {
    return (
        <div className="row mt-3 mb-3">
            <div className="col-md-1">
                <span className="input-group-text">{label}</span>
            </div>
            <div className="col">
                {
                    isImage
                    ?<img src={value}/>
                    :<p>{value}</p>
                }
            </div>
        </div>
    )
}