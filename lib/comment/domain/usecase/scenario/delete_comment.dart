part of '../usecase.dart';

class DeleteCommentUseCase {
  final CommentRepository _repository;

  DeleteCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(String commentId) async {
    return await _repository
        .deleteCommentById(commentId)
        .then(UseCaseResponseWrapper<void>.from);
  }
}
