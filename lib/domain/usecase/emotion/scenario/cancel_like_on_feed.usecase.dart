part of "../emotion.usecase_module.dart";

class CancelLikeOnFeedUseCase {
  final EmotionRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String emotionId) async {
    return await _repository.deleteEmotionById(emotionId);
  }
}
