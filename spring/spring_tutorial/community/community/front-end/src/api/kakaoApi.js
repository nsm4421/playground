import axios from "axios";

const KAKAO_REST_API_KEY = "b6023639a0983010fa1b4636be190b80";
const KAKAO_REDIRECT_URI = "http://localhost:3000/oauth2/kakao";
export const KAKAO_AUTH_URL = `https://kauth.kakao.com/oauth/authorize?client_id=${KAKAO_REST_API_KEY}&redirect_uri=${KAKAO_REDIRECT_URI}&response_type=code&promt=login`;

export function getUserInfoApi(code, successCallback, failureCallback){
    const endPoint = `/api/user/kakao/me?code=${code}`;
    axios.get(endPoint, code).then(successCallback).catch(failureCallback);
}