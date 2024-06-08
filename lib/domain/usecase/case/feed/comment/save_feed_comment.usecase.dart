part of 'package:my_app/domain/usecase/module/feed/feed_comment.usecase.dart';

class SaveFeedCommentUseCase {
  final FeedCommentRepository _repository;

  SaveFeedCommentUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedCommentEntity entity) async =>
      await _repository.saveComment(entity);
}
