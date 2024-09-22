part of '../usecase.dart';

class CreateFeedParentCommentUseCase {
  final FeedRepository _repository;

  CreateFeedParentCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<ParentFeedCommentEntity>> call({
    required String feedId,
    required String content,
  }) async {
    return await _repository
        .saveParentComment(feedId: feedId, content: content)
        .then(UseCaseResponseWrapper<ParentFeedCommentEntity>.from);
  }
}

class CreateFeedChildCommentUseCase {
  final FeedRepository _repository;

  CreateFeedChildCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<ChildFeedCommentEntity>> call({
    required String feedId,
   required String parentId,
    required String content,
  }) async {
    return await _repository
        .saveChildComment(feedId: feedId, parentId: parentId, content: content)
        .then(UseCaseResponseWrapper<ChildFeedCommentEntity>.from);
  }
}
