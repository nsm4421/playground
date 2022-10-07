const Api = {
    "uploadMusic":{
        URL:"/api/v1/music",
        METHOD:"post"
    },
    "register":{
        URL:"/api/v1/user/register",
        METHOD:"post"
    },
    "checkIsDuplicated":{
        URL:"/api/v1/user/check",
        METHOD:"post"
    },
    "login":{
        URL:"/api/v1/user/login",
        METHOD:"post"
    },
    "uploadPost":{
        URL:"/api/v1/post",
        METHOD:"post"    
    },
    "getPost":{
        URL:"/api/v1/post",
        METHOD:"get"
    },
    "getUsername":{
        URL:"/api/v1/user",
        METHOD:"post"
    }
}

export default Api;  