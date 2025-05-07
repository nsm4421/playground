part of "../impl/feed_comment.remote_datasource_impl.dart";

abstract class FeedCommentRemoteDataSource
    implements BaseRemoteDataSource<FeedCommentModel> {
  Future<Iterable<FeedCommentModelForRpc>> fetchComments(
      {required DateTime beforeAt, required String feedId, int take = 20});

  Future<void> createComment(FeedCommentModel model);

  Future<void> deleteCommentById(String commentId);
}
