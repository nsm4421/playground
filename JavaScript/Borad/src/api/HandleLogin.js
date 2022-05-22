import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import app from './App';

const HandleLogin = async ({userInput})=>{
    const email = userInput.email;
    const password = userInput.password;
    const auth = getAuth(app);
    return await signInWithEmailAndPassword(auth, email, password)
        .then((userCredential) => {
            const user = userCredential.user;
            localStorage.setItem('karma-user', JSON.stringify(user));
            return {status:true, user:user}
        })
        .catch((error) => {
            const errCode = error.code;
            const errMsg = error.message;
            return {status:false, errCode:errCode, errMsg:errMsg}    
        });
};

export default HandleLogin;