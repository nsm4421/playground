import RowCovInfo0 from "./RowCovInfo0";
import RowCovInfo99 from "./RowCovInfo99";
import RowCovInfo from "./RowCovInfo";
import { useState } from "react";
import { Table } from "react-bootstrap";

export default function ShowOneCoverage(props){
    

    let [covObj, changeCovObj] = useState(props.covObj);


    return (
        <>
            <Table striped bordered hover size="sm">
                <thead>
                    <tr>
                        <h3>{props.covObj.Coverage}</h3>                        
                    </tr>

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

