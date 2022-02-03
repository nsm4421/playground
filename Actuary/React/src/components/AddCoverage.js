import RowCovInfo0 from "./utils/RowCovInfo0";
import RowCovInfo99 from "./utils/RowCovInfo99";
import RowCovInfo from "./utils/RowCovInfo";
import { useState } from "react";
import { Table } from "react-bootstrap";
import axios from 'axios';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';

export default function AddCoverage(props){

    const MaxBenefitNum = 10;
    
    let history = useHistory();
    let [covObj, changeCovObj] = useState({

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

                <h1>담보코드 : <input onChange={(event)=>{
                    let newObj = {... covObj};
                    newObj.Coverage = event.target.value;
                    changeCovObj(newObj);
                }}/></h1>

                <button type="button" className="btn btn-info" onClick={()=>{
                    if (covObj.NumBenefit<MaxBenefitNum) {
                        let newObj = {...covObj};
                        newObj.NumBenefit = newObj.NumBenefit+1;
                        changeCovObj(newObj);
                    } else {
                        let msg = `급부개수는 최大 ${MaxBenefitNum}개`;
                        alert(msg);
                    }
                }}> 급부추가 </button>

                <button type="button" className="btn btn-info" onClick={()=>{
                    if (covObj.NumBenefit===1) {
                        let msg = `급부개수는 최小 1개`;
                        alert(msg);
                    } else {
                        let newObj = {...covObj};
                        newObj.NumBenefit = newObj.NumBenefit-1;
                        changeCovObj(newObj);
                    }
                }}> 급부삭제 </button>


                <button type="button" className="btn btn-danger" onClick={()=>{
                    const url = `http://127.0.0.1:${props.port}/api/${props.address}`;
                    if (covObj.Coverage.trim() === "") {
                        alert('담보코드가 입력되지 않음')
                        return;
                    }
                    axios.post(url, covObj).then((response) => {
                        if (response.data.status == true){
                            alert(response.data.message);
                        } else {
                            console.log(response);
                            alert(response.data.message);
                        }
                    })
                    }}>담보 Object 보내기</button>

                <button className="btn btn-success" onClick={()=>{
                    console.log(covObj);
                }}> 콘솔에 담보 Object 로그 찍기 </button>

                
            <button type="button" className="btn btn-warning" onClick={()=>{
                   history.goBack();
                }}> 담보정보화면으로 빡구 </button>

                <p>급부개수 : {covObj.NumBenefit} 개</p>

            </div>

            <Table striped bordered hover size="sm">
                <thead>
                    <tr>
                    <th>급부번호</th>
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
                
                    <RowCovInfo0 benefitNum={0} covObj={covObj} changeCovObj={changeCovObj}/>   
                    
                    {[...Array(covObj.NumBenefit)].map((_, i) => 
                        <RowCovInfo benefitNum = {i+1} covObj={covObj} changeCovObj={changeCovObj}/>
                    )}

                    <RowCovInfo99 benefitNum={99} covObj={covObj} changeCovObj={changeCovObj}/>        
            
                </tbody>
            </Table>
        </>
    )


}

