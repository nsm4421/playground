part of '../usecase.dart';

class FetchParentFeedCommentUseCase {
  final FeedRepository _repository;

  FetchParentFeedCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<ParentFeedCommentEntity>>> call(
      {required String feedId,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchParentComments(feedId: feedId, beforeAt: beforeAt, take: take)
        .then(UseCaseResponseWrapper<List<ParentFeedCommentEntity>>.from);
  }
}

class FetchChildFeedCommentUseCase {
  final FeedRepository _repository;

  FetchChildFeedCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<ChildFeedCommentEntity>>> call(
      {required String feedId,
      required String parentId,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchChildComments(
            feedId: feedId, parentId: parentId, beforeAt: beforeAt, take: take)
        .then(UseCaseResponseWrapper<List<ChildFeedCommentEntity>>.from);
  }
}
