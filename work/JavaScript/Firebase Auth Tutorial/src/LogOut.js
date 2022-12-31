import { getAuth, signOut } from "firebase/auth";


// 로그아웃 처리하기
const HandleLogout = ()=>{
    const auth = getAuth();
    signOut(auth)
    .then(() => {
        alert('로그아웃 됨.')
        // local storage에서 인증정보 지우기
        localStorage.removeItem('user')
    }).catch((error) => {
        alert(`로그아웃 중 오류 발생 (${error})`)
    })
}

// 현재 로그인된 유저 정보 콘솔에 찍기
const PrintCurrentUser = ()=>{
    const auth = getAuth();
    console.log(auth.currentUser);
}
  
const LogOut = () => {
    return (
        <>
            <h1>로그아웃하기</h1>

            <div style={{'border' : '1px solid'}}>
                <button onClick={HandleLogout}>로그아웃</button>
                <button onClick={PrintCurrentUser}>현재 유저 정보</button>
            </div>

        </>
    )
}

export default LogOut;