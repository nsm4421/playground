const ApiRoute = {
    getPosts: {
        method: "get",
        url: "/api/post"
    },
    createPost: {
        method: "post",
        url: "/api/post"
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