part of 'usecase.dart';

class FetchCommentOnFeedUseCase {
  final CommentRepository _repository;

  FetchCommentOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, List<CommentEntity>>> call(
      {String? parentId,
      required String feedId,
      required DateTime beforeAt,
      int take = 20}) async {
    final beforeAtStr = beforeAt.toUtc().toIso8601String();
    return parentId == null
        ? await _repository.fetchParents(
            beforeAt: beforeAtStr,
            referenceId: feedId,
            referenceTable: Tables.feeds.name)
        : await _repository.fetchChildren(
            referenceId: feedId,
            referenceTable: Tables.feeds.name,
            parentId: parentId,
            beforeAt: beforeAtStr,
            take: take);
  }
}

class FetchCommentOnReelsUseCase {
  final CommentRepository _repository;

  FetchCommentOnReelsUseCase(this._repository);

  Future<Either<ErrorResponse, List<CommentEntity>>> call(
      {String? parentId,
        required String reelsId,
        required DateTime beforeAt,
        int take = 20}) async {
    final beforeAtStr = beforeAt.toUtc().toIso8601String();
    return parentId == null
        ? await _repository.fetchParents(
        beforeAt: beforeAtStr,
        referenceId: reelsId,
        referenceTable: Tables.reels.name)
        : await _repository.fetchChildren(
        referenceId: reelsId,
        referenceTable: Tables.reels.name,
        parentId: parentId,
        beforeAt: beforeAtStr,
        take: take);
  }
}
