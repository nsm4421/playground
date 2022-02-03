import { Table } from "react-bootstrap";

export default function ShowOneCoverage(props){
    

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
                
                    <RowCovInfo0_ covObj={props.covObj}/>   
                    
                    {[...Array(props.covObj.NumBenefit)].map((_, i) => 
                        <RowCovInfo_ bNum = {i+1} covObj={props.covObj}/>
                    )}

                    <RowCovInfo99_ covObj={props.covObj}/>        
            
                </tbody>
            </Table>
        </>
    )
}

function RowCovInfo0_(props){
    return(
        <>
            <tr>
            <th>0</th>
            <th>{props.covObj.ExCode[0]}</th>
            <th>{props.covObj.NonCov[0]}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            </tr>
        </>
    )
}


function RowCovInfo_(props){
    return(
        <>
            <tr>
            <th>{props.bNum}</th>
            <th>{props.covObj.ExCode[props.bNum]}</th>
            <th>{props.covObj.NonCov[props.bNum]}</th>
            <th>{props.covObj.PayRate[props.bNum]}</th>
            <th>{props.covObj.ReduceRate[props.bNum]}</th>
            <th>{props.covObj.ReducePeriod[props.bNum]}</th>
            <th></th>
            <th></th>
            <th></th>
            </tr>
        </>
    )
}


function RowCovInfo99_(props){
    return(
        <>
            <tr>
            <th>99</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th>{props.covObj.GxCode}</th>
            <th>{props.covObj.InvalidPeriod}</th>
            </tr>
        </>
    )
}