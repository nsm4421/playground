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
    }
}

export default ApiRoute