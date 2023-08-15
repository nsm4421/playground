import axios from "axios";

export async function getCommentApi(articleId, successCallback, failureCallback){
    const endPoint = `/api/comment/${articleId}`;
    await axios
        .get(endPoint)
        .then(successCallback)
        .catch(failureCallback);
}

export async function writeCommentApi(articleId, parentCommentId, content, successCallback, failureCallback){
    const endPoint = '/api/comment';
    const data = {articleId, parentCommentId, content};
    await axios
        .post(endPoint, data)
        .then(successCallback)
        .catch(failureCallback);
}