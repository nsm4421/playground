const ApiRoute = {
    getPosts: {
        method: "get",
        url: "/api/post"
    },
    getParentComments : {
        method : "get",
        url:"/api/post/comment"
    },
    getChildComments : {
        method : "get",
        url:"/api/post/comment/child"
    },
    createPost: {
        method: "post",
        url: "/api/post"
    },
    createParentComment: {
        method: "post",
        url: "/api/post/comment"
    },
    createChildComment: {
        method: "post",
        url: "/api/post/comment/child"
    },
    createPlace: {
        method: "post",
        url: "/api/place"
    },
    getRoadAddressFromCoordinate: {
        method: "get",
        url: "/api/place/coordinate2address"
    },
    getLikeCount : {
        method:"get",
        url : "/api/post/emotion"
    },
    likePost : {
        method:"post",
        url : "/api/post/emotion"
    },
    cancelLike : {
        method:"delete",
        url : "/api/post/emotion"
    }
}

export default ApiRoute