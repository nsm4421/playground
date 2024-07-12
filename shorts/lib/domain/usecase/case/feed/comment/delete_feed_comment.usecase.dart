part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class DeleteFeedCommentUseCase {
  final FeedCommentRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedCommentEntity comment) async =>
      await _repository.deleteComment(comment.id!);
}
