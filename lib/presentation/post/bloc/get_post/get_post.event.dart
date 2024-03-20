class GetPostEvent {}

class InitPost extends GetPostEvent {}

class LikePost extends GetPostEvent {
  final String postId;

  LikePost(this.postId);
}

class CancelLikePost extends GetPostEvent {
  final String postId;
  final String likeId;

  CancelLikePost({required this.postId, required this.likeId});
}
