part of "../emotion.usecase_module.dart";

class GetEmotionChannelUseCase {
  final EmotionRepository _repository;

  GetEmotionChannelUseCase(this._repository);

  RealtimeChannel call(String emotionId) {
    return _repository.getEmotionChannel();
  }
}
