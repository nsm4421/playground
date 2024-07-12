part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class ModifyFeedCommentUseCase {
  final FeedCommentRepository _repository;

  ModifyFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedCommentEntity entity) async =>
      await _repository.saveComment(entity);
}
