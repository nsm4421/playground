part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class GetFeedCommentStreamUseCase {
  final FeedCommentRepository _repository;

  GetFeedCommentStreamUseCase(this._repository);

  Stream<List<FeedCommentEntity>> call(
          {required String afterAt,
          required String feedId,
          bool descending = false}) =>
      _repository
          .getCommentStream(afterAt: afterAt, feedId: feedId)
          .fold((l) => throw l.toCustomException(), (r) => r);
}
