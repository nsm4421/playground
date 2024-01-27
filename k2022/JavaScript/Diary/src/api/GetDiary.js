import { ref, child, get } from "firebase/database";
import MyDB from "./MyDB";

const GetDiaries = async ()=>{
    const dbRef = ref(MyDB);
    return await get(child(dbRef, 'diary/')).then((snapshot) => {
      if (snapshot.exists()) {
        return snapshot.val();
      } else {
        console.log("No data available");
      }
    }).catch((error) => {
      console.error(error);
    });
}

export default GetDiaries;