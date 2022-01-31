import PeriodNonCov from "./PeriodNonCov"
import { useEffect, useState } from "react"

// 0번 급부 (전체 유지자)
export default function RowBenefit0(props){

    let [obj, changeObj] = useState({
        ExCode : "",
        NonCov : 0,
    });

    useEffect(()=>{ 
        let newObj = {... props.coverageObj};
        newObj.ExCode[0] = obj.ExCode;
        newObj.NonCov[0] = obj.NonCov;
        props.changeCoverageObj(newObj);        
    }, [obj]);

    return (
        <>
            <td>0</td>
            <td><input placeholder="탈퇴율" onChange={(event)=>{
                let newObj = {... obj};
                newObj.ExCode = event.target.value;
                changeObj(newObj);
            }}/></td>
            <td><PeriodNonCov obj={obj} changeObj={changeObj}/></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </>
    )
};