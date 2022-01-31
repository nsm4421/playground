import { useState } from "react"


// 무효해지 기간
export default function PeriodNonCov(props){
    
    let [idx, changeIdx] = useState(0);
    let invalidPeriodList = [0, 3];
    
    return (
        <>
            <button class="btn" onClick={()=>{
               if (idx == invalidPeriodList.length-1){
                    changeIdx(0);
               } else {
                   changeIdx(idx+1);
               }
               let newObj = {... props.Obj};
               newObj.InvalidPeriod = invalidPeriodList[idx];
               props.changeObj(newObj); 
            }}>
                {invalidPeriodList[idx]}月
            </button>                  
        </>
    )
}
