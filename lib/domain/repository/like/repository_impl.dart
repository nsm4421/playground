part of 'repository.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeDataSource _dataSource;

  LikeRepositoryImpl(this._dataSource);

  @override
  Future<Either<ErrorResponse, void>> create(BaseEntity ref) async {
    try {
      return await _dataSource
          .create(refTable: customUtil.getRefTable(ref), refId: ref.id!)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(BaseEntity ref) async {
    try {
      return await _dataSource
          .delete(refTable: customUtil.getRefTable(ref), refId: ref.id!)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
