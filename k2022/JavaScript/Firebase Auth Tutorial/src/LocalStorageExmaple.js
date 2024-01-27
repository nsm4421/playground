import app from './Firebase'
import { getAuth} from "firebase/auth";

// 인증정보를 local storage에 (키값을 user로) 저장하는 함수
const SaveButton = ()=>{
    const auth = getAuth(app);

    const handleInfo = ()=>{
        // user정보 json -> string
        const cUserString = JSON.stringify(auth.currentUser)
        // 저장
        localStorage.setItem('user', cUserString)
        alert('유저 정보가 local storage에 저장됨')
    }
    return (
        <button onClick={handleInfo}>유저정보 저장하기 버튼</button>
    )
}

// 인증정보를 local storage에 (키값을 user로) 조회하는 함수
const LoadButton = ()=>{

    // user정보 가져오기
    const consoleLogging = ()=>{
        const userInfoString = localStorage.getItem('user')
        const usrInfo = JSON.parse(userInfoString)
        alert('유저 정보가 local storage에서 가져옴')
        console.log('유저정보 : ', usrInfo)
    }

    return (
        <button onClick={consoleLogging}>유저정보 콘솔에 찍기 버튼</button>
    )
}

const LocalStorageExmaple = ()=>{
    return (
        <div style={{border:'1px solid'}}>
            <h1>Local Storage에 인증정보 저장 및 읽기</h1>
            <SaveButton/>
            <LoadButton/>
        </div>
    )
}

export default LocalStorageExmaple;