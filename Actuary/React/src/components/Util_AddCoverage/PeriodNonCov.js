import { useEffect, useState } from "react"


// 부담보 기간
export default function PeriodNonCov(props){
    
    let [idx, changeIdx] = useState(0);
    let nonCovList = [0, 3];

    return (
        <>
            <button class="btn" onClick={()=>{
               if (idx == nonCovList.length-1){
                    changeIdx(0);
               } else {
                   changeIdx(idx+1);
               }
               let newObj = {... props.Obj};
               newObj.NonCov = nonCovList[idx];
               props.changeObj(newObj);    
            }}>
                {nonCovList[idx]}月
            </button>                  
        </>
    )
}
