part of "feed_comment.datasource_impl.dart";

abstract class FeedCommentDataSource implements BaseDataSource {
  FeedCommentModel audit(FeedCommentModel model);

  Future<Iterable<FeedCommentModelForRpc>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20,
      bool ascending = true});

  Future<void> createComment(FeedCommentModel model);

  Future<void> deleteCommentById(String commentId);
}
