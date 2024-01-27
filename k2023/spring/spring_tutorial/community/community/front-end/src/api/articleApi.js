import axios from "axios";

export async function writeArticleApi(title, content, hashtags, successCallback, failureCallback, config){
    const endPoint = '/api/article';
    const data =  {title, content, hashtags:[...new Set(hashtags)]};
    await axios
        .post(endPoint, data, config)
        .then(successCallback)      
        .catch(failureCallback);
}

export async function modifyArticleApi(articleId, title, content, hashtags, successCallback, failureCallback){
    const endPoint = '/api/article';
    const data =  {articleId, title, content, hashtags:[...new Set(hashtags)]};
    await axios
        .put(endPoint, data)
        .then(successCallback)      
        .catch(failureCallback);
}

export function getArticleApi(articleId, successCallback, failureCallback){
    const endPoint = `/api/article/search/${articleId}`;
    axios.get(endPoint)
        .then(successCallback)
        .catch(failureCallback)
}

export async function getArticlesApi(currentPage, successCallback, failureCallback){
    const endPoint = `/api/article?page=${currentPage}&size=20`;
    axios.get(endPoint)
        .then(successCallback)
        .catch(failureCallback);
}

export function searchArticleApi(searchType, searchWord, successCallback, failureCallback){
    const endPoint = "/api/article/search";
    const data = {searchType, searchWord};
    axios.post(endPoint, data)
        .then(successCallback)
        .catch(failureCallback);
};

export async function deleteArticleApi(articleId, successCallback, failureCallback) {
    const endPoint = `/api/article/${articleId}`;
    await axios
        .delete(endPoint)
        .then(successCallback)
        .catch(failureCallback);
}