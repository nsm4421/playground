// 급부 추가 버튼

export default function AddCovButton(props){
    return (
        <>
            <button type="button" class="btn btn-info" onClick={()=>{
                let newObj = {... props.coverageObj};
                if (newObj.NumBenefit == newObj.MaxBenefitNum) {
                    let msg = `급부개수는 최대 ${newObj.MaxBenefitNum}개까지 가능`
                    alert(msg);
                } else {
                    newObj.NumBenefit = newObj.NumBenefit+1;
                    props.changeCoverageObj(newObj);
                }
            }}>담보추가</button>
        </>
    )
}