part of '../usecase.dart';

class FetchParentCommentUseCase {
  final CommentRepository _repository;

  FetchParentCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<CommentEntity>>> _call(
      {required String referenceId,
      required Tables referenceTable,
      required String content,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchParentComments(
            referenceId: referenceId,
            referenceTable: referenceTable,
            beforeAt: beforeAt,
            take: take)
        .then(UseCaseResponseWrapper<List<CommentEntity>>.from);
  }
}

class FetchParentFeedCommentUseCase extends FetchParentCommentUseCase {
  FetchParentFeedCommentUseCase(super._repository);

  Future<UseCaseResponseWrapper<List<CommentEntity>>> call(
      {required String feedId,
      required String content,
      required DateTime beforeAt,
      int take = 20}) async {
    return await super._call(
        referenceId: feedId,
        referenceTable: Tables.feeds,
        content: content,
        beforeAt: beforeAt);
  }
}
