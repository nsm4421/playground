part of '../usecase.dart';

class SaveFeedCommentUseCase {
  final CommentRepository _repository;

  SaveFeedCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call({
    required String feedId,
    String? parentId,
    required String content,
  }) async {
    return await _repository
        .saveComment(
            referenceId: feedId,
            referenceTable: Tables.feeds,
            parentId: parentId,
            content: content)
        .then(UseCaseResponseWrapper<void>.from);
  }
}
