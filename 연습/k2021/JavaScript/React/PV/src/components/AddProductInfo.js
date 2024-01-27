import {Form, InputGroup, Button, FormControl, Alert} from 'react-bootstrap'
import {React, useEffect, useState} from 'react'


function AddProductInfo(props) {
    
    let [numBenefit, changeNumBenefit] = useState(1);
    let [coverage, changeCoverage] = useState('');
    
    // 납면
    let [grantCode, changeGrantCode] = useState('');
    let [grantType, changeGrantType] = useState('');
    let [invalidPeriod, changeInvalidPeriod] = useState(0); 
    // 탈퇴   
    let [exitCodeList, changeExitCodeList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [exitTypeList, changeExitTypeList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [nonCovList, changeNonCovList] = useState(['', '', '', '', '', '', '', '', '', '']);
    // 급부지급
    let [benefitCodeList, changeBenefitCodeList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [benefitTypeList, changeBenefitTypeList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [payRateList, changePayRateList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [reduceRateList, changeReduceRateList] = useState(['', '', '', '', '', '', '', '', '', '']);
    let [reducePeriodList, changeReducePeriodList] = useState(['', '', '', '', '', '', '', '', '', '']);
    // 담보정보
    let [coverageInfo, changeCoverageInfo] = useState({});

    return (
        <>
            <div>
            
            <div style={{'width' : '80%'}}>
            <hr/>
                
                <InputGroup className="mb-3"> 
                    <FormControl placeholder="담보코드" onChange={(e)=>{changeCoverage(e.target.value)}}>
                    </FormControl>
                    <Button variant="danger" onClick={()=>{
                        let exitInfo = {};
                        let benefitInfo = {};
                        let grantInfo = {};
                        [...Array(numBenefit+1).keys()].map((k, _)=>{
                            if (k>0){
                                // 급부지급
                                benefitInfo[k] = {
                                    'RiskCode' : benefitCodeList[k],
                                    'RiskType' : benefitTypeList[k],
                                    'PayRate' : payRateList[k],
                                    'ReduceRate' : reduceRateList[k],
                                    'ReducePeriod' : reducePeriodList[k] 
                                }
                            }
                            // 탈퇴
                            exitInfo[k] = {
                                'RiskCode' : exitCodeList[k],
                                'RiskType' : exitTypeList[k],
                                'NonCov' : nonCovList[k]
                            };
                                                    
                        });
                        // 납면
                        grantInfo = {
                            'RiskCode' : grantCode,
                            'RiskType' : grantType,
                            'InvalidPeriod' : invalidPeriod
                        };
    
                        // covData에 데이터 넣기
                        let coverageData = [];
                        coverageData = [... props.covData];         
                        coverageData.push({   
                            'Coverage' : coverage,
                            'NumBenefit' : numBenefit,
                            'Exit' : exitInfo,
                            'Benefit' : benefitInfo,
                            'Grant' : grantInfo});
                        props.changeCovData(coverageData);   
                                                        
                    }}>담보추가</Button> 
                </InputGroup>
            </div>

            <div style={{'width' : '80%'}}>
                <hr/>
                <InputGroup className="mb-3">
                    <BenefitComp benefitNum={0} 
                        numBenefit={numBenefit} changeNumBenefit={changeNumBenefit}
                        exitCodeList={exitCodeList} changeExitCodeList={changeExitCodeList}
                        exitTypeList={exitCodeList} changeExitTypeList={changeExitTypeList}
                        nonCovList={nonCovList} changeNonCovList={changeNonCovList}
                        benefitCodeList = {benefitCodeList} changeBenefitCodeList={changeBenefitCodeList}
                        benefitTypeList = {benefitTypeList} changeBenefitTypeList={changeBenefitTypeList}
                        payRateList={payRateList} changePayRateList={changePayRateList}
                        reduceRateList={reduceRateList} changeReduceRateList={changeReduceRateList}
                        reducePeriodList={reducePeriodList} changeReducePeriodList={changeReducePeriodList}/>
                    <FormControl placeholder="납입면제율" onChange={(e)=>{changeGrantCode(e.target.value)}}/>
                    <FormControl placeholder="납면율 Type" onChange={(e)=>changeGrantType(e.target.value)}/>
                    <FormControl placeholder="무효해지기간" onChange={(e)=>changeInvalidPeriod(e.target.value)}/>

                </InputGroup>
            </div>

        </div>
        <div>
            {[...Array(numBenefit).keys()].map((benefitNum,_)=>{                
                return <div style={{'width' : '80%'}}>
                    <BenefitComp benefitNum = {benefitNum+1} 
                    numBenefit={numBenefit} changeNumBenefit={changeNumBenefit}
                    exitCodeList={exitCodeList} changeExitCodeList={changeExitCodeList}
                    exitTypeList={exitCodeList} changeExitTypeList={changeExitTypeList}
                    nonCovList={nonCovList} changeNonCovList={changeNonCovList}
                    benefitCodeList = {benefitCodeList} changeBenefitCodeList={changeBenefitCodeList}
                    benefitTypeList = {benefitTypeList} changeBenefitTypeList={changeBenefitTypeList}
                    payRateList={payRateList} changePayRateList={changePayRateList}
                    reduceRateList={reduceRateList} changeReduceRateList={changeReduceRateList}
                    reducePeriodList={reducePeriodList} changeReducePeriodList={changeReducePeriodList}/></div>
            })}
        </div>
 
        </>
    ) 
}

function BenefitComp(props){

    return (
        <>     
        <hr/>   
        {
            props.benefitNum == 0 
            ?<div>
                <h4>전체 유지자</h4>
                <Button variant="primary" onClick={()=>{
                    props.numBenefit<10
                    ? props.changeNumBenefit(props.numBenefit+1)
                    : alert('급부개수는 최대 10개까지 되도록 만듬');
                    }}>급부추가</Button>             
            </div>
            : <h4>{props.benefitNum}번 급부</h4>
        }

        <InputGroup className="mb-3">            
            <FormControl placeholder="탈퇴율" onChange={(e)=>{
                let arr = [... props.exitCodeList];
                arr[props.benefitNum] = e.target.value;
                props.changeExitCodeList(arr);
            }}/>
            <FormControl placeholder="탈퇴율 Type" onChange={(e)=>{
                let arr = [... props.exitTypeList];
                arr[props.benefitNum] = e.target.value;
                props.changeExitTypeList(arr);
            }}/>
            <FormControl placeholder="부담보기간" onChange={(e)=>{
                let arr = [... props.nonCovList];
                arr[props.benefitNum] = e.target.value;
                props.changeNonCovList(arr);
            }}/>
        </InputGroup>

        {props.benefitNum==0
        ? null
        :<div>  
            
            <InputGroup className="mb-3">
                <FormControl placeholder="급부율" onChange={(e)=>{
                    let arr = [... props.benefitCodeList];
                    arr[props.benefitNum] = e.target.value;
                    props.changeBenefitCodeList(arr);
                }}/>
                <FormControl placeholder="급부율 Type" onChange={(e)=>{
                    let arr = [... props.benefitTypeList];
                    arr[props.benefitNum] = e.target.value;
                    props.changeBenefitTypeList(arr);
                }}/>
                <FormControl placeholder="지급률" onChange={(e)=>{
                    let arr = [... props.payRateList];
                    arr[props.benefitNum] = e.target.value;
                    props.changePayRateList(arr);
                }}/>
                <FormControl placeholder="감액률" onChange={(e)=>{
                    let arr = [... props.reduceRateList];
                    arr[props.benefitNum] = e.target.value;
                    props.changeReduceRateList(arr);
                }}/>
                <FormControl placeholder="감액기간" onChange={(e)=>{
                    let arr = [... props.reducePeriodList];
                    arr[props.benefitNum] = e.target.value;
                    props.changeReducePeriodList(arr);
                }}/>
            </InputGroup>

        </div>         
        }
        
        {
            props.benefitNum>1
            ? <Button variant="success" onClick={()=>{
                props.changeNumBenefit(props.numBenefit-1)
            }}>급부삭제</Button> 
            : null   
        }
        
        </>
    )
}





export default AddProductInfo;
