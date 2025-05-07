part of 'repository_impl.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl with CustomLogger implements CommentRepository {
  final CommentDataSource _dataSource;

  CommentRepositoryImpl(this._dataSource);

  @override
  Future<Either<ErrorResponse, void>> create({
    required String id,
    String? parentId,
    required String referenceId,
    required String referenceTable,
    required String content,
  }) async {
    try {
      return await _dataSource
          .create(CreateCommentDto(
              id: id,
              parent_id: parentId,
              reference_id: referenceId,
              reference_table: referenceTable,
              content: content))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<CommentEntity>>> fetchParents(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      int take = 20}) async {
    try {
      return await _dataSource
          .fetchParents(
              beforeAt: beforeAt,
              referenceId: referenceId,
              referenceTable: referenceTable,
              take: take)
          .then((res) => res.map(CommentEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<CommentEntity>>> fetchChildren(
      {required String beforeAt,
      required String referenceId,
      required String referenceTable,
      required String parentId,
      int take = 20}) async {
    try {
      return await _dataSource
          .fetchChildren(
              beforeAt: beforeAt,
              referenceId: referenceId,
              referenceTable: referenceTable,
              parentId: parentId,
              take: take)
          .then((res) => res.map(CommentEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String id) async {
    try {
      return await _dataSource.delete(id).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
