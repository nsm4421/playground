import { getDatabase, ref, child, push, update } from "firebase/database";
import MyDB from './MyDB'

const DeleteDiary = (_id) => {
  // Write the new post's data simultaneously in the posts list and the user's post list.
  const updates = {};
  updates[`diary/${_id}`] = null;
  
  return update(ref(MyDB), updates);
}


export default DeleteDiary;