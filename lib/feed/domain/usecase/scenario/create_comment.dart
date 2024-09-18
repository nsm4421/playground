part of '../usecase.dart';

class CreateFeedCommentUseCase {
  final FeedRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call({
    required String feedId,
    String? parentId,
    required String content,
  }) async {
    return await _repository
        .saveComment(feedId: feedId, parentId: parentId, content: content)
        .then(UseCaseResponseWrapper<void>.from);
  }
}
