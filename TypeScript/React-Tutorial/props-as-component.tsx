type MotherCompoentProps = {
    child:React.ReactNode[]
}

export const MotherCompoent = (props:MotherCompoentProps) => {
    return(
        <div>
            <h1>Chlid Compoent</h1>
            {props.child.map((c, i)=>{
                return (
                    <div key={i}>
                        <div>{c}</div>
                        <hr/>
                    </div>
                )
            })}
        </div>
    )
}