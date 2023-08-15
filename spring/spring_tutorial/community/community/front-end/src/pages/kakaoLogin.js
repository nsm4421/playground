import { Button } from '@mui/material';
import { useEffect, useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useRecoilState } from 'recoil';
import { initUserState, userState } from '..';
import { getKakaoToken, getUserInfoApi } from '../api/kakaoApi';

/**
 * 전체적인 Flow
 * 1. login.js에서 카카오 로고 버튼을 누르는 경우 KAKAO_AUTH_URL로 이동하도록 함
 * 2. KAKAO_AUTH_URL에서 인증이 완료되면 localhost:3000/oauth2/kakao로 redirection됨
 *  (카카오 개발자 홈페이지에서 해당 경로로 설정해놓음)
 * 3. 리다이렉션 경로 url parameter에서 인증토큰을 추출
 *  (key 값은 code)
 * =================== △ Front End ===============================
 * =================== ▽ Back End ===============================
 * 4. 인증토큰으로 GET요청 보내서 Access 토큰 얻기
 *  - Request
 *      - params : 인증토큰/client-id/grant-type
 *      - path : https://kauth.kakao.com/oauth/token
 *  - Response
 *      - Access Token 등
 * 5. Access 토큰으로 GET 요청 보내서 유저 정보 얻기
 *  - Request
 *      - params : Access token
 *      - path : https://kapi.kakao.com/v2/user/me
 */
export default function KakaoLogin(){

    const location = useLocation();
    const navigator = useNavigate();
    const [user, setUser] = useRecoilState(userState);
    const [isError, setIsError] = useState(true);
    const [isLoading, setIsLoading] = useState(true);

    /**
     * 리다이렉션된 URL parameter에는 카카오에서 발급한 인증코드가 있음
     * 해당 인증코드를 추출하는 함수
     */
    const getAuthTokenFromUrl = () => {
        const searchParams = new URLSearchParams(location.search);
        return searchParams.get('code');
    }

    const parsingRequest = (res, authToken) => {
        return {
            username : `KAKAO_${res.data.id}`,
            nickname : res.data.kakao_account.profile.nickname, 
            kakao : {
                id : res.data.id,
                connected_at : res.data.connected_at,
                email : res.data.kakao_account.email,
                nickname : res.data.kakao_account.profile.nickname,
                profile_image_url : res.data.kakao_account.profile.profile_image_url,
                thumbnail_image_url : res.data.kakao_account.profile.thumbnail_image_url,
                token:authToken
            }
        }
    }

    /**
     * 인증토큰을 서버(Spring)로 보내서 카카오 유저 정보를 받음
     * 이를 토대로 전역 State를 갱신하는 함수
     */
    const getKakaoAccountInfo = async (authToken) => {
        await getUserInfoApi(
            authToken,
            (res) => {
                setUser(parsingRequest(res, authToken)); 
                setIsError(false);
                return;
            }, 
            ()=>{}
        );
        localStorage.setItem("user", JSON.stringify(user));
    }

    useEffect(()=>{
        const _handleAuth = async () => {
            setIsLoading(true);
            await getKakaoAccountInfo(getAuthTokenFromUrl());
            setIsLoading(false);
        }
        _handleAuth();
    }, [])

    if (isLoading){
        return (
            <div>
                <h1>로딩중입니다...</h1>
            </div>
        )
    }

    if (isError){
        return (
            <div>
                <h1>에러입니다...</h1>
                <Button onClick={()=>{navigator("/login")}}>로그인페이지로</Button>
            </div>
        )
    }

    return (
        <div>
            <h1>카카오 인증 페이지</h1>
            <h2>회원가입 성공</h2>
            <label>Username</label>
            <label>Nickname</label>
            <Button onClick={()=>{navigator("/")}}>홈 화면으로</Button>
        </div>
    )
}

