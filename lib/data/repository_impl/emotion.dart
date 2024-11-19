part of 'repository_impl.dart';

@LazySingleton(as: EmotionRepository)
class EmotionRepositoryImpl with CustomLogger implements EmotionRepository {
  final EmotionDataSource _dataSource;

  EmotionRepositoryImpl(this._dataSource);

  @override
  Future<Either<ErrorResponse, void>> create(
      {required String referenceId,
      required String referenceTable,
      Emotions emotion = Emotions.like}) async {
    try {
      return await _dataSource
          .edit(EditEmotionDto(
              reference_id: referenceId,
              reference_table: referenceTable,
              emotion: emotion))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(
      {required String referenceId, required String referenceTable}) async {
    try {
      return await _dataSource
          .delete(DeleteEmotionDto(
              reference_id: referenceId, reference_table: referenceTable))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
