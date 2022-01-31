import PeriodNonCov from "./PeriodNonCov"
import PeriodInvalid from './PeriodInvalid'
import {useState, useEffect} from "react"

// 99번 급부 (납입자)
export default function RowBenefit99(props){

    let [obj, changeObj] = useState({
        GxCode : "",
        InvalidPeriod : 0,
    });

    useEffect(()=>{
        let newObj = {... props.coverageObj};
        newObj.GxCode = obj.GxCode;
        newObj.InvalidPeriod = obj.InvalidPeriod;
        props.changeCoverageObj(newObj);
    }, [obj])

    return (
        <>
            <td>99</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td><input placeholder="납면율" onChange={(event)=>{
                let newObj = {... obj};
                newObj.ExCode = event.target.value;
                changeObj(newObj);
            }}/></td>
            <td><PeriodInvalid obj={obj} changeObj={changeObj}/></td>
        </>
    )
};