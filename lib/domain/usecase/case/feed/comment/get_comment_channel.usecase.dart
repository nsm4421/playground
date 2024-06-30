part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class GetCommentChannel {
  final FeedCommentRepository _repository;

  GetCommentChannel(this._repository);

  RealtimeChannel call({
    required String feedId,
    required PostgresChangeEvent changeEvent,
    required void Function(
            FeedCommentEntity? oldRecored, FeedCommentEntity? newRecord)
        callback,
  }) =>
      _repository.getCommentChannel(
          feedId: feedId, changeEvent: changeEvent, callback: callback);
}
