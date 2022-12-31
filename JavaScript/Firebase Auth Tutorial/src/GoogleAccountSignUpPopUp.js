import app from "./Firebase";
import { getAuth, signInWithPopup, GoogleAuthProvider } from "firebase/auth";

const GoogleAccountSignUp = ()=>{
  const auth = getAuth(app);
  const provider = new GoogleAuthProvider();
  provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  return signInWithPopup(auth, provider)
    .then((result) => {
      // 회원가입 성공
      const credential = GoogleAuthProvider.credentialFromResult(result);
      const token = credential.accessToken;
      const user = result.user;
      return {status :'success', token : token, user:user}
    }).catch((error) => {
      // 회원가입 실패
      const errorCode = error.code;
      const errorMessage = error.message;
      const email = error.email;
      const credential = GoogleAuthProvider.credentialFromError(error);
      return {status :'error', errorCode : errorCode, errorMessage:errorMessage}
    });
}

const GoogleAccountSignUpPopUp = ()=>{

  const handleSignUp = ()=>{
    GoogleAccountSignUp()
      .then((res)=>{
        if (res.status === 'success'){
          alert(`회원가입 성공 | 환영한다 ${res.user.displayName}야`)
        } else if (res.status === 'error') {
          alert(`회원가입 실패 | ${res.errorMessage}`)
        } else {
          alert('버그?')
        }
      })
  }

  return (
    <div>
      <h1>구글계정으로 회원가입하기</h1>
      
      <div style={{border : '1px solid'}}>
        <button onClick={handleSignUp}>구글계정으로 회원가입 팝업창 띄우기</button>
      </div>
    </div>
  )
}

export default GoogleAccountSignUpPopUp;