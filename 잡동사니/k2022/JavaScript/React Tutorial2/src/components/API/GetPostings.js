// GET요청을 쏴서 Posting 정보를 가져옴
import DB_URL from "../utils/DB_URL";

export default function GetPostings(){
    return fetch(`${DB_URL}/postings.json`).then(
        res => {
            if(res.status!=200){
                throw new Error(res.statusText);
            }
            return res.json()
        }
    ).then(
        resJson => {
          return ({...resJson})
    })
}


// import { ref, child, get } from "firebase/database";
// import myDB from "./Firebase";

// export default function GetPostings(){
//     const dbRef = ref(myDB);
//     return get(child(dbRef, 'postings'))
//     .then((snapshot) => {
//       if (snapshot.exists()) {
//         return snapshot.val()
//       } else {
//         console.log("No data available");
//       }
//     }).catch((error) => {
//       console.error(error);
//     })

// }