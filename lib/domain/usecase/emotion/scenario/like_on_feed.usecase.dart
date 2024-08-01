part of "../emotion.usecase_module.dart";

class LikeOnFeedUseCase {
  final EmotionRepository _repository;

  LikeOnFeedUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String feedId) async {
    return await _repository.upsertEmotion(EmotionEntity(
        type: EmotionType.like,
        referenceId: feedId,
        referenceTable: TableName.feed.name));
  }
}
