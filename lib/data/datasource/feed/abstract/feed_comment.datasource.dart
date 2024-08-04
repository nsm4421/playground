part of "../impl/feed_comment.datasource_impl.dart";

abstract class FeedCommentDataSource
    implements BaseDataSource<FeedCommentModel> {
  Future<Iterable<FeedCommentModelForRpc>> fetchComments(
      {required DateTime beforeAt, required String feedId, int take = 20});

  Future<void> createComment(FeedCommentModel model);

  Future<void> deleteCommentById(String commentId);
}
