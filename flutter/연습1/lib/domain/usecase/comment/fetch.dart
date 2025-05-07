part of 'usecase.dart';

class FetchCommentUseCase {
  final CommentRepository _repository;

  FetchCommentUseCase(this._repository);

  Future<Either<ErrorResponse, List<CommentEntity>>> call(
      {String? parentId,
      required String referenceId,
      required String referenceTable,
      required DateTime beforeAt,
      int take = 20}) async {
    final beforeAtStr = beforeAt.toUtc().toIso8601String();
    return parentId == null
        ? await _repository.fetchParents(
            beforeAt: beforeAtStr,
            referenceId: referenceId,
            referenceTable: referenceTable)
        : await _repository.fetchChildren(
            referenceId: referenceId,
            referenceTable: referenceTable,
            parentId: parentId,
            beforeAt: beforeAtStr,
            take: take);
  }
}
