import DB_URL from "../utils/DB_URL";

export default function UploadArticle(userInput) {

  const today = new Date();
  return fetch(`${DB_URL}/postings.json`, {
      method:"POST",
      body:JSON.stringify({
        title : userInput.title,
        writer : userInput.writer,
        password : userInput.password,
        article : userInput.article,
        mentions : {},
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