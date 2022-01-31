// 급부 삭제 버튼

export default function DeleteCovButton(props){
    return (
        <>
            <button type="button" class="btn btn-secondary" onClick={()=>{
                let newObj = {... props.coverageObj};
                if (newObj.NumBenefit == 1) {
                    let msg = `급부개수는 최소 1개`
                    alert(msg);
                } else {
                    newObj.NumBenefit -= 1;
                    props.changeCoverageObj(newObj);
                }
            }}>담보삭제</button>
        </>
    )
}