import { useEffect, useState } from "react";

export default function RowCovInfo(props){

    const bNum = props.benefitNum;

    // 버튼 item
    const nCovList = [0, 3];                    // 부담보기간(월)
    const payRateList = [1, 0.1, 0.5];          // 지급률
    const reduceRateList = [0, 0.1, 1];         // 감액률
    const reducePeriodList = [0, 1, 2];         // 감액기간(년)
    
    // 버튼 index
    let [idx_nCov, changeIdx_nCov] = useState(0);
    let [idx_payRate, changeIdx_payRate] = useState(0);
    let [idx_reduceRate, changeIdx_reduceRate] = useState(0);
    let [idx_reducePeriod, changeIdx_reducePeriod] = useState(0);

    // hooks

    useEffect(()=>{ // 부담보기간
        let newObj = {... props.covObj};
        newObj.NonCov[bNum] = nCovList[idx_nCov];
        props.changeCovObj(newObj);
    }, [idx_nCov])

    useEffect(()=>{ // 지급률
        let newObj = {... props.covObj};
        newObj.PayRate[bNum] = payRateList[idx_payRate];
        props.changeCovObj(newObj);
    }, [idx_payRate])
    
    useEffect(()=>{ // 감액률
        let newObj = {... props.covObj};
        newObj.ReduceRate[bNum] = reduceRateList[idx_reduceRate];
        props.changeCovObj(newObj);
    }, [idx_reduceRate])

    useEffect(()=>{ // 감액기간
        let newObj = {... props.covObj};
        newObj.ReducePeriod[bNum] = reducePeriodList[idx_reducePeriod];
        props.changeCovObj(newObj);
    }, [idx_reducePeriod])

  

        return(
            <>

                <tr>
                    
                    <td>{bNum}</td>

                    <td><input placeholder="탈퇴율" onChange={(event)=>{
                        let newObj = {... props.covObj};
                        newObj.ExCode[bNum] = event.target.value;
                        props.changeCovObj(newObj);
                    }}/></td>
                    
                    <td>
                        <button className="btn btn-secondary" onClick={()=>{
                            if (idx_nCov == nCovList.length-1){
                                changeIdx_nCov(0);
                            } else {
                                changeIdx_nCov(idx_nCov+1);
                            }
                        }}>{nCovList[idx_nCov]}月</button>     
                    </td>
                    
                    <td><input placeholder="급부율" onChange={(event)=>{
                        let newObj = {... props.covObj};
                        newObj.BxCode[bNum] = event.target.value;
                        props.changeCovObj(newObj);
                    }}/></td>
                    
                    <td>
                        <button  className="btn btn-secondary" onClick={()=>{
                            if (idx_payRate == payRateList.length-1){
                                changeIdx_payRate(0);
                            } else {
                                changeIdx_payRate(idx_payRate+1);
                            }
                        }}>{payRateList[idx_payRate]*100}%</button>        
                    </td> 
                    
                    <td>
                        <button  className="btn btn-secondary" onClick={()=>{
                            if (idx_reduceRate == reduceRateList.length-1){
                                changeIdx_reduceRate(0);
                            } else {
                                changeIdx_reduceRate(idx_reduceRate+1);
                            }
                        }}>{reduceRateList[idx_reduceRate]*100}%</button>  
                    </td>
                    
                    <td>
                        <button  className="btn btn-secondary" onClick={()=>{
                            if (idx_reducePeriod == reducePeriodList.length-1){
                                changeIdx_reducePeriod(0);
                            } else {
                                changeIdx_reducePeriod(idx_reducePeriod+1);
                            }
                        }}>{reducePeriodList[idx_reducePeriod]}年</button>    
                    </td>
                    
                    <td></td>
                    <td></td>
                </tr>

            </>
        ) 

}