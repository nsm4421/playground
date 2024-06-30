part of '../impl/feed_comment.remote_datasource_impl.dart';

abstract interface class RemoteFeedCommentDataSource {
  Future<Iterable<FetchFeedCommentResponseDto>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false});

  Future<void> saveComment(SaveFeedCommentRequestDto dto);

  Future<void> modifyComment(
      {required String commentId, required String content});

  Future<void> deleteComment(String commentId);

  RealtimeChannel getCommentChannel(
      {required String feedId,
      required PostgresChangeEvent changeEvent,
      required void Function(PostgresChangePayload p) callback});
}
