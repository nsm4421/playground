import { useEffect, useState } from "react";

export default function RowCovInfo0(props){

    const bNum = props.benefitNum;

    // 버튼 item
    const nCovList = [0, 3];                    // 부담보기간(월)
    
    // 버튼 index
    let [idx_nCov, changeIdx_nCov] = useState(0);

    // hooks
    useEffect(()=>{ // 부담보기간
        let newObj = {... props.covObj};
        newObj.NonCov[bNum] = nCovList[idx_nCov];
        props.changeCovObj(newObj);
    }, [idx_nCov])


    return (
        <>
            <tr>
                <td>0</td>

                <td><input placeholder="탈퇴율" onChange={(event)=>{
                    let newObj = {... props.covObj};
                    newObj.ExCode[bNum] = event.target.value;
                    props.changeCovObj(newObj);
                }}/></td>
                
                <td>
                    <button  className="btn btn-secondary" onClick={()=>{
                        if (idx_nCov == nCovList.length-1){
                            changeIdx_nCov(0);
                        } else {
                            changeIdx_nCov(idx_nCov+1);
                        }
                    }}>{nCovList[idx_nCov]}月</button>     
                </td>
                
                <td></td>                
                <td></td>                 
                <td></td>                
                <td></td>                
                <td></td>
                <td></td>
            </tr>
                    
        </>
    ) 
}