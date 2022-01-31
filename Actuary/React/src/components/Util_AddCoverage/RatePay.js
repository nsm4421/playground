import { useState } from "react"


// 지급률
export default function RatePay(){
    
    let [idx, changeIdx] = useState(0);
    let PayRateList = [1, 0.1, 0.5];
    
    return (
        <>
            <button class="btn" onClick={()=>{
               if (idx == PayRateList.length-1){
                    changeIdx(0);
               } else {
                   changeIdx(idx+1);
               }
            }}>
                {PayRateList[idx]*100}%
            </button>                  
        </>
    )
}
