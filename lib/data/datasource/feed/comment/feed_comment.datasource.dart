part of 'feed_comment.datasource_impl.dart';

abstract interface class FeedCommentDataSource {}

abstract interface class LocalFeedCommentDataSource
    implements FeedCommentDataSource {}

abstract interface class RemoteFeedCommentDataSource
    implements FeedCommentDataSource {
  Stream<Iterable<FeedCommentModel>> getCommentStream(
      {required String afterAt,
      required String feedId,
      bool descending = false});

  Future<Iterable<FeedCommentModel>> fetchComments(
      {required String afterAt,
      required String feedId,
      int take = 20,
      bool descending = false});

  Future<void> saveComment(FeedCommentModel model);
}
