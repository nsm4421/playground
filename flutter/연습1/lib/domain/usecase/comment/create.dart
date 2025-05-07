part of 'usecase.dart';

class CreateCommentUseCase {
  final CommentRepository _repository;

  CreateCommentUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String id,
      String? parentId,
      required String referenceId,
      required String referenceTable,
      required String content}) async {
    return await _repository.create(
        id: id,
        referenceId: referenceId,
        parentId: parentId,
        referenceTable: referenceTable,
        content: content);
  }
}
