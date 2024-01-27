const urlPrefix = "/api/v1"
const Api = {
    'register':{
        url: `${urlPrefix}/user/register`,
        method:'POST'
    },
    'login':{
        url:`${urlPrefix}/user/login`,
        method:'POST'
    },
    'notification':{
        url:`${urlPrefix}/user/notification`,
        method:'GET'        
    }
}

export default Api;