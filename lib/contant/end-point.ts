export const NextEndPoint = {
  /// 포스팅
  fetchPosts: "/api/post",
  fetchPostComments: "/api/post/comment",
  createPost: "/api/post",
  createPostComment: "/api/post/comment",
  getLike: "/api/post/like", // get
  likeOnPost: "/api/post/like",

  /// 여행
  createTravelPlan : "/api/travel/plan",
};

export const RemoteEndPoint = {
  searchAddress: "https://api.mapbox.com/search/geocode/v6/forward",
};
