import { useState } from "react"


// 감액기간
export default function RateReduce(){
    
    let [idx, changeIdx] = useState(0);
    let RateReduceList = [0, 0.5, 1];
    
    return (
        <>
            <button class="btn" onClick={()=>{
               if (idx == RateReduceList.length-1){
                    changeIdx(0);
               } else {
                   changeIdx(idx+1);
               }
            }}>
                {RateReduceList[idx]*100}%
            </button>                  
        </>
    )
}
