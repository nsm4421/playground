import { useState } from "react"


// 감액기간
export default function PeriodReduce(props){
    
    let [idx, changeIdx] = useState(0);
    let reduceYearList = [0, 0.5, 1, 2];
    
    return (
        <>
            <button class="btn" onClick={()=>{
               if (idx == reduceYearList.length-1){
                    changeIdx(0);
               } else {
                   changeIdx(idx+1);
               }
               let newObj = {... props.Obj};
               newObj.ReducePeriod = reduceYearList[idx];
               props.changeObj(newObj); 
            }}>
                {reduceYearList[idx]}年
            </button>                  
        </>
    )
}
