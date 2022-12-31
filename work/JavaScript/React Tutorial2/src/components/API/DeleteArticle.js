import DB_URL from "../utils/DB_URL";

function GetPassword(_id, password){

  return fetch(`${DB_URL}/postings/${_id}.json`,{
      method:'GET'
  })
  .then(res=>{
      if (res.status!=200){
          throw new Error(res.statusText);
      }
      return res.json()
  })
  .then((res)=>{   // 재렌더링
     if (res.password == password){
       return true
     } 
     return false
  }).catch(()=>{
    return false
  })
}

export default function DeleteArticle(_id, password){
    
    if (GetPassword(_id, password)){
      return fetch(`${DB_URL}/postings/${_id}.json`,{
          method:'DELETE'
      })
      .then(res=>{
          if (res.status!=200){
              throw new Error(res.statusText);
          }
          console.log("삭제요청보냄")
          return
        })
      } else {
      console.log("비번 불일치")
      return
    }
}
