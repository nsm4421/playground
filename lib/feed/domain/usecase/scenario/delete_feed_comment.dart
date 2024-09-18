part of '../usecase.dart';

class DeleteFeedCommentUseCase {
  final FeedRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(String commentId) async {
    return await _repository
        .deleteCommentById(commentId)
        .then(UseCaseResponseWrapper.from);
  }
}
