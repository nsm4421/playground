part of '../impl/feed_comment.remote_datasource_impl.dart';

abstract interface class RemoteFeedCommentDataSource {
  Future<Iterable<FeedCommentWithAuthorModel>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false});

  Future<void> saveComment(FeedCommentModel model);

  Future<void> modifyComment(
      {required String commentId, required String content});

  Future<void> deleteComment(String commentId);

  RealtimeChannel getCommentChannel(
      {required String feedId,
      required PostgresChangeEvent changeEvent,
      required void Function(PostgresChangePayload p) callback});
}
