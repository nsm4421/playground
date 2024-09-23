part of '../usecase.dart';

class FetchParentFeedCommentUseCase {
  final FeedRepository _repository;

  FetchParentFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<List<ParentFeedCommentEntity>>> call(
      {required String feedId,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchParentComments(feedId: feedId, beforeAt: beforeAt, take: take)
        .then((res) =>
            res.copyWith(message: res.ok ? '댓글 가져오기 성공' : '댓글 가져오기 실패'));
  }
}

class FetchChildFeedCommentUseCase {
  final FeedRepository _repository;

  FetchChildFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<List<ChildFeedCommentEntity>>> call(
      {required String feedId,
      required String parentId,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchChildComments(
            feedId: feedId, parentId: parentId, beforeAt: beforeAt, take: take)
        .then((res) =>
            res.copyWith(message: res.ok ? '대댓글 가져오기 성공' : '대댓글 가져오기 실패'));
  }
}
