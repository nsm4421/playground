import { useEffect, useState } from "react";

export default function RowCovInfo99(props){

    const bNum = props.benefitNum;

    // 버튼 item
    const invalidPeriodList = [0, 3];           // 무효해지기간(월)
    
    // 버튼 index
    let [idx_invalidPeriod, changeIdx_invalidPeriod] = useState(0);

    // hooks

    useEffect(()=>{ // 무효해지기간
        let newObj = {... props.covObj};
        newObj.InvalidPeriod = invalidPeriodList[idx_invalidPeriod];
        props.changeCovObj(newObj);
    }, [idx_invalidPeriod])



    return (
        <>

            <tr>
                <td>{bNum}</td>
                <td></td>                   
                <td></td>                    
                <td></td>                
                <td></td>                 
                <td></td>                
                <td></td>                
                <td>
                    <input placeholder="납입면제율" onChange={(event)=>{
                        let newObj = {... props.covObj};
                        newObj.GxCode = event.target.value;
                        props.changeCovObj(newObj);
                    }}/></td>
                <td>
                    <button  className="btn btn-secondary" onClick={()=>{
                        if (idx_invalidPeriod == invalidPeriodList.length-1){
                            changeIdx_invalidPeriod(0);
                        } else {
                            changeIdx_invalidPeriod(idx_invalidPeriod+1);
                        }
                    }}>{invalidPeriodList[idx_invalidPeriod]}月</button>
                </td>
            </tr>
                    
        </>
    )
}