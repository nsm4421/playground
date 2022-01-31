import {Table} from 'react-bootstrap';
import RowBenefit0 from './Util_AddCoverage/RowBenefit0';
import RowBenefit from './Util_AddCoverage/RowBenefit';
import RowBenefit99 from './Util_AddCoverage/RowBenefit99';
import { useState } from 'react';
import AddCovButton from './Util_AddCoverage/AddCovButton';
import DeleteCovButton from './Util_AddCoverage/DeleteCovButton';

function AddCoverage(){

    const MaxBenefitNum = 10;
    

    let [coverageObj, changeCoverageObj] = useState({

        Coverage : "",      // 담보키                                
        NumBenefit : 1,     // 급부개수
        MaxBenefitNum : MaxBenefitNum,  // 급부개수 최대
        
        ExCode : [...Array(MaxBenefitNum)].map((_, i) => ""),   // 탈퇴율
        BxCode : [...Array(MaxBenefitNum)].map((_, i) => ""),   // 급부율
        GxCode : "",                                            // 납면율
        
        NonCov : [...Array(MaxBenefitNum)].map((_, i) => 0),        // 부담보기간
        PayRate : [...Array(MaxBenefitNum)].map((_, i) => 1),       // 지급률
        ReduceRate : [...Array(MaxBenefitNum)].map((_, i) => 0.),   // 감액률
        ReducePeriod : [...Array(MaxBenefitNum)].map((_, i) => 0),  // 감액기간
        InvalidPeriod : 0                                           // 무효해지기간

    });


    return (
        <>
            <div>

                <h1>담보키 : <input onChange={(event)=>{
                    let newObj = {... coverageObj};
                    newObj.Coverage = event.target.value;
                    changeCoverageObj(event.target.value);
                }}/></h1>

                <AddCovButton coverageObj={coverageObj} changeCoverageObj={changeCoverageObj}/>
                <DeleteCovButton coverageObj={coverageObj} changeCoverageObj={changeCoverageObj}/>

                <button onClick={()=>{
                    console.log(coverageObj);
                }}> 콘솔에 담보 Object 로그 찍기 </button>

                <p>급부개수 : {coverageObj.NumBenefit} 개</p>
            </div>

            <Table striped bordered hover size="sm">
                <thead>
                    <tr>
                    <th>담보번호</th>
                    <th>탈퇴율코드</th>
                    <th>부담보기간</th>
                    <th>급부율코드</th>
                    <th>지급률</th>
                    <th>감액률</th>
                    <th>감액기간</th>
                    <th>납면율코드</th>
                    <th>무효해지기간</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <RowBenefit0 coverageObj={coverageObj} changeCoverageObj={changeCoverageObj}/>
                    
                    {
                        [...Array(coverageObj.NumBenefit)].map((_, i) => <RowBenefit 
                        bNum={i+1} coverageObj={coverageObj} changeCoverageObj={changeCoverageObj}/>)
                    }
           
                    <RowBenefit99 coverageObj={coverageObj} changeCoverageObj={changeCoverageObj}/>

                </tbody>
            </Table>    

        
        </>
    )
}



export default AddCoverage;