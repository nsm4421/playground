import Posting from "./utils/Posting";


export default function Postings(props){
    
    return (
        <>
            {
                Object.keys(props.postings).map((k)=>{
                    let posting = props.postings[k]
                    return <Posting posting={posting} _id={k} key={k}/>
                })
            }
        </>
    )
}