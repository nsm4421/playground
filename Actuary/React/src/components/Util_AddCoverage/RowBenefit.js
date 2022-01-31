import PeriodNonCov from "./PeriodNonCov"
import PeriodReduce from "./PeriodReduce"
import PeriodInvalid from './PeriodInvalid'
import RatePay from "./RatePay"
import RateReduce from './RateReduce'
import { useEffect, useState } from "react"

// (급부별 유지자)
export default function RowBenefit(props){

    const bNum = props.bNum;
    let [obj, changeObj] = useState({
        ExCode : "",
        NonCov : 0,
        BxCode : "",
        PayRate : 1,
        ReduceRate : 0,
        ReducePeriod : 0
    });

    useEffect(()=>{
        let newObj = {... props.coverageObj};
        newObj.ExCode[bNum] = obj.ExCode;
        newObj.NonCov[bNum] = obj.Noncov;
        newObj.BxCode[bNum] = obj.BxCode;
        newObj.PayRate[bNum] = obj.PayRate;
        newObj.ReduceRate[bNum] = obj.ReduceRate;
        newObj.ReducePeriod[bNum] = obj.ReducePeriod;
        props.changeCoverageObj(newObj);
    }, [obj]);

    return (
        <>
            <tr>

                <td>{bNum}</td>

                <td><input placeholder="탈퇴율" onChange={(event)=>{
                    let newObj = {... obj};
                    newObj.ExCode = event.target.value;
                    changeObj(newObj);
                }}/></td>
                
                <td><PeriodNonCov obj={obj} changeObj={changeObj}/></td>
                
                <td><input placeholder="급부율" onChange={(event)=>{
                    let newObj = {... obj};
                    newObj.BxCode = event.target.value;
                    changeObj(newObj);
                }}/></td>
                
                <td><RatePay obj={obj} changeObj={changeObj}/></td> 
                
                <td><RateReduce obj={obj} changeObj={changeObj}/></td>
                
                <td><PeriodReduce obj={obj} changeObj={changeObj}/></td>
                
                <td></td>
                <td></td>
            </tr>
        </>
    )
};