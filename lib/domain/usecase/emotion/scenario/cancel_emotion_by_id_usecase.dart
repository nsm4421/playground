part of "../emotion.usecase_module.dart";

class CancelEmotionByIdUseCase {
  final EmotionRepository _repository;

  CancelEmotionByIdUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String emotionId) async {
    return await _repository.deleteEmotionById(emotionId);
  }
}
