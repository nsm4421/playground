import axios from "axios";

export async function getNicknameApi(successCallback, failureCallback) {
    const endPoint = "/api/user";
    await axios.get(endPoint)
        .then(successCallback).catch(failureCallback);
}

export async function loginApi(formData, successCallback, failureCallback) {
    const endPoint = "/api/login";
    await axios.post(endPoint, formData, {
        headers: {
            "Content-Type": "multipart/form-data",
        },
    }).then(successCallback).catch(failureCallback);
}

export async function regsterApi(data, successCallback, failureCallback){
    const endPoint = '/api/user/register';
    await axios.post(endPoint, data)
        .then(successCallback)
        .catch(failureCallback);
}