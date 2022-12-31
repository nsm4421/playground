import DB_URL from "../utils/DB_URL"

// POST 요청을 쏴서 댓글 등록
export default function UploadMention(posting_id, mention){
    
    const today = new Date();
    return fetch(`${DB_URL}/postings/${posting_id}/mentions.json`, {
        method:"POST",
        body:JSON.stringify({
            mention : mention,
            writeAt : `${today.toLocaleDateString()} ${today.toLocaleTimeString()}`
        })
    }).then((res)=>{
        if (res.status!=200){
            throw new Error(res.statusText)
        } else {
            return res.json()
        }
    })
}
