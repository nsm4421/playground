part of 'repository.dart';

abstract interface class EmotionRepository {
  Future<Either<ErrorResponse, void>> create(
      {required String referenceId,
      required String referenceTable,
      Emotions emotion = Emotions.like});

  Future<Either<ErrorResponse, void>> delete(
      {required String referenceId, required String referenceTable});
}
