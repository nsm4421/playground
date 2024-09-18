part of '../usecase.dart';

class FetchChildCommentUseCase {
  final CommentRepository _repository;

  FetchChildCommentUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<CommentEntity>>> _call(
      {required String referenceId,
      required Tables referenceTable,
      required String parentId,
      required String content,
      required DateTime beforeAt,
      int take = 20}) async {
    return await _repository
        .fetchChildComments(
            referenceId: referenceId,
            referenceTable: referenceTable,
            parentId: parentId,
            beforeAt: beforeAt,
            take: take)
        .then(UseCaseResponseWrapper<List<CommentEntity>>.from);
  }
}

class FetchChildFeedCommentUseCase extends FetchChildCommentUseCase {
  FetchChildFeedCommentUseCase(super.repository);

  Future<UseCaseResponseWrapper<List<CommentEntity>>> call(
      {required String feedId,
      required String parentId,
      required String content,
      required DateTime beforeAt,
      int take = 20}) async {
    return await super._call(
        referenceId: feedId,
        referenceTable: Tables.feeds,
        parentId: parentId,
        content: content,
        beforeAt: beforeAt,
        take: take);
  }
}
