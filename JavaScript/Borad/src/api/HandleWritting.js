import HandleDB from './HandleDB'
import { child, ref, push, getDatabase, update, set } from 'firebase/database';
import app from './App';

const HandleWritting = async (uid, payload)=>{

    const newPayload = {...payload};
    const today = new Date();
    newPayload.uid = uid;
    newPayload.writeAt = `${today.toLocaleDateString()} ${today.toLocaleTimeString()}`
    newPayload.comments = {};

    const database = getDatabase(app);
    const dbRef = ref(database, '/posting');
    const newPostKey = push(dbRef);

    return await set(newPostKey, newPayload).then(()=>{
        return {status:true}
    }).catch((e)=> {
        return {status:false, error:e}
    })
}

export default HandleWritting;