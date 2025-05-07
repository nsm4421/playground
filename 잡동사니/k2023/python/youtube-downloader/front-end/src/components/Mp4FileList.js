import axios from "axios";
import { useEffect, useState } from "react";


export default function Mp4FileList({mp4Files, setMp4Files}){

    const [nowPlaying, setNowPlaying] = useState(0);

    useEffect(()=>{
        const endPoint = "/files";
        axios.get(endPoint,{}).then((res)=>{
            return res.data
        }).then((res)=>{
            setMp4Files(res);
        }).catch((err)=>{
            console.log("Mp4FileList ▷ ", err); 
        })
    }, [])

    return(
        <div className="container mt-5">
            <div className="row">
                <div className="col-3">
                <ul className="list-group">
                    {
                        mp4Files.map((m, i)=>{
                            return (
                                <div className="row" key={i}>
                                    <li onClick={()=>setNowPlaying(i)} className={`list-group-item ${i===nowPlaying?'active':''}`}>{m}</li>
                                </div>
                            );
                        })
                    }
                </ul>
                </div>
                <div className="col-8 ms-3">
                    {
                        mp4Files.map((m, i)=>{
                            if (i===nowPlaying){                            
                                return (
                                    <div key={i} className="row">
                                        <video id="video" autoPlay controls preload="auto">
                                            <source src={`/downloaded/${m}`} type="video/mp4"/>영상을 출력할 수 없습니다...
                                        </video>
                                    </div>
                                )
                            }
                        })
                    }
                </div>
            </div>
        </div>
    )
};