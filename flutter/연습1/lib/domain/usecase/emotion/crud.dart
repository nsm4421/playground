part of 'usecase.dart';

class SendLikeOnUseCase {
  final EmotionRepository _repository;

  SendLikeOnUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call({
    Emotions emotion = Emotions.like,
    required String referenceId,
    required String referenceTable,
  }) async {
    return await _repository.create(
        emotion: emotion,
        referenceId: referenceId,
        referenceTable: referenceTable);
  }
}

class CancelLikeOnUseCase {
  final EmotionRepository _repository;

  CancelLikeOnUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(
      {required String referenceId, required String referenceTable}) async {
    return await _repository.delete(
        referenceId: referenceId, referenceTable: referenceTable);
  }
}
