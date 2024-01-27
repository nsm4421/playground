import {React, useState} from 'react'


function ProductInfo(props) {

    // 담보코드
    let [coverage, changeCoverage] = useState(props.productInfo['Coverage']);
    // 급부개수
    let [numBenefit, changeNumBenefit] = useState(props.productInfo['NumBenefit']);
    // 탈퇴정보
    let [exitInfo, changeExitInfo] = useState(props.productInfo['Exit']);
    // 급부지급정보
    let [benefitInfo, changeBenefitInfo] = useState(props.productInfo['Benefit']);
    // 납입면제정보
    let [grantInfo, changeGrantInfo] = useState(props.productInfo['Grant']);

    return (
        <>
        <hr/>
        <div style={{'width':'100%', 'background' : 'rgb(85, 73, 73)', 'color' : 'white', 'margin' : '5px', 'padding' : '5px'}}>
            
            <h5>담보명 : {coverage} / 급부개수 : {numBenefit}</h5>
            <hr/>
            <label>탈퇴</label>

            {Object.keys(exitInfo).map((k, _)=>{
                return <div>
                    <p>{k}번 급부 탈퇴위험률코드 : {exitInfo[k]['RiskCode'] == ''
                                                ? "無"
                                                : exitInfo[k]['RiskCode']}</p>
                    <p>{k}번 급부 탈퇴율 Type : {exitInfo[k]['RiskType'] == ''
                                                ? "無"
                                                : exitInfo[k]['RiskType'] }</p>
                    <p>{k}번 급부 부담보기간 : {exitInfo[k]['NonCov'] == ''
                                                ? 0
                                                : exitInfo[k]['NonCov']}개월</p>               
                </div>})}
            
            <hr/>
            <label>급부지급</label>
            {Object.keys(benefitInfo).map((k, _)=>{
                return <div>
                    <p>{k}번 급부 급부위험률코드 : {benefitInfo[k]['RiskCode'] == ''
                                                ? "無"
                                                : benefitInfo[k]['RiskCode']}</p>
                    <p>{k}번 급부 급부율 Type : {benefitInfo[k]['RiskType'] === ''
                                                ? "無"
                                                : benefitInfo[k]['RiskType'] }</p>
                    <p>{k}번 급부 지급률 : {benefitInfo[k]['PayRate'] == ''
                                            ? 0
                                            : benefitInfo[k]['PayRate']}</p>               
                    <p>{k}번 급부 감액률 : {benefitInfo[k]['ReduceRate'] == '' 
                                            ? 0
                                            : benefitInfo[k]['ReduceRate']*100} %</p>               
                    <p>{k}번 급부 감액기간 : {benefitInfo[k]['ReducePeriod'] == ''
                                            ? 0
                                            : benefitInfo[k]['ReducePeriod']} 개월</p>               
                </div>})}

            <hr/>

            <label>납입면제</label>
            <p> 납면위험률코드 : {grantInfo['RiskCode'] === ''
                                ? "無"
                                : grantInfo['RiskCode']} </p>
            <p> 납면율 Type : {grantInfo['RiskType'] === ''
                                ? "無"
                                : grantInfo['RiskCode']} </p>
           <p>무효해지기간 : {grantInfo['InvalidPeriod'] == ''
                            ? 0
                            : grantInfo['InvalidPeriod']}개월</p>
            
            </div>
        </>
    )
    
    
}

export default ProductInfo;
