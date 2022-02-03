import axios from 'axios';
import ShowOneCoverage from './utils/ShowOneCoverage';
import { useState } from 'react';
import AddCoverage from './AddCoverage';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';

export default function ShowCoverage(props){

    let [covObjList, changeCovObjList] = useState([{}]);
    let [flag, changeFlag] = useState(false);
    let history = useHistory();

    return (
        <div>
            <button type="button" className="btn btn-danger" onClick={()=>{
                const url = `http://127.0.0.1:${props.port}/api/${props.address}`;
                axios.get(url).then((response) => {
                    if (response.data.status == true){
                        if (response.data.covJsonList.length>0){
                            changeCovObjList(response.data.covJsonList);
                            changeFlag(true);
                        } 
                        alert(response.data.message);
                    } else {
                        alert(response.data.message);
                    }
                }).catch((_)=>{
                    alert("ERR");
                    }
                )
                }}>담보정보 새로고침</button>

            <button className="btn btn-success" onClick={()=>{
                history.push('/AddCoverage')
            }}>담보추가하기</button>

            {
                flag
                ? covObjList.map((_, idx)=>{
                    return <ShowOneCoverage covObj={covObjList[idx]}/>
                })
                : <p>조회된 담보정보가 없음</p>
            }

    
        </div>
    )
}

