import { ref, set } from "firebase/database";
import MyDB from "./MyDB";

const WriteDiary = ({_id, payload})=>{
    set(ref(MyDB, `diary/${_id}/`), payload)
}

export default WriteDiary;