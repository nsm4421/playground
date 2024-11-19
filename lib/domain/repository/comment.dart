part of 'repository.dart';

abstract interface class CommentRepository {
  Future<Either<ErrorResponse, List<CommentEntity>>> fetchParents(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      int take = 20});

  Future<Either<ErrorResponse, List<CommentEntity>>> fetchChildren(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      required String parentId,
      int take = 20});

  Future<Either<ErrorResponse, void>> create(
      {required String id,
      String? parentId,
      required String referenceId,
      required String referenceTable,
      required String content});

  Future<Either<ErrorResponse, void>> delete(String id);
}
