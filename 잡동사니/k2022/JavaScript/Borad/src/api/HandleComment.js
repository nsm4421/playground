import { ref, push, getDatabase, update, set } from 'firebase/database';
import app from './App';

const HandleComment = async (pid, payload)=>{

    const newPayload = {...payload};
    const today = new Date();
    newPayload.writeAt = `${today.toLocaleDateString()} ${today.toLocaleTimeString()}`
    newPayload.comments = {};

    const database = getDatabase(app);
    const dbRef = ref(database, `/posting/${pid}/comments`);
    const newPostKey = push(dbRef);

    return await set(newPostKey, newPayload).then(()=>{
        return {status:true}
    }).catch((e)=> {
        return {status:false, error:e}
    })
}

export default HandleComment;