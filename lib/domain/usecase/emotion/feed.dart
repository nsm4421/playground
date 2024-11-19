part of 'usecase.dart';

class SendLikeOnFeedUseCase {
  final EmotionRepository _repository;

  SendLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String feedId) async {
    return await _repository.create(
        referenceId: feedId, referenceTable: Tables.emotions.name);
  }
}

class CancelLikeOnFeedUseCase {
  final EmotionRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<Either<ErrorResponse, void>> call(String feedId) async {
    return await _repository.delete(
        referenceId: feedId, referenceTable: Tables.emotions.name);
  }
}
