part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class FetchFeedCommentsUseCase {
  final FeedCommentRepository _repository;

  FetchFeedCommentsUseCase(this._repository);

  Future<Either<Failure, List<FeedCommentEntity>>> call(
          {required DateTime beforeAt,
          required String feedId,
          required int from,
          required int to,
          bool ascending = false}) async =>
      await _repository.fetchComments(
          beforeAt: beforeAt,
          feedId: feedId,
          from: from,
          to: to,
          ascending: ascending);
}
