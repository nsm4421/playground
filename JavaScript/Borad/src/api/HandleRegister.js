import { getAuth, createUserWithEmailAndPassword, updateProfile } from "firebase/auth";
import { update, ref, set, child } from "firebase/database";
import { getDatabase } from "firebase/database";
import app from './App.js'

const HandleRegister = async ({userInput})=>{
  const auth = getAuth(app);
  const email = userInput.email;
  const password = userInput.password;
  const nickName = userInput.nickName;
  
  return await createUserWithEmailAndPassword(auth, email, password)
  .then((userCredential) => {
    const user = userCredential.user;
    const auth = getAuth(app);
      
    updateProfile(auth.currentUser, {
        displayName: nickName, 
      })

    return {status:true}

  })
  .catch((error) => {
    const errCode = error.code;
    const errMsg = error.message;
    return {status:false, errCode:errCode, msg:errMsg}
  });
}

export default HandleRegister;