part of "../emotion.usecase_module.dart";

class LikeOnFeedUseCase {
  final EmotionRepository _repository;

  LikeOnFeedUseCase(this._repository);

  Future<ResponseWrapper<EmotionEntity>> call(String feedId) async {
    return await _repository.upsertEmotion(EmotionEntity(
        type: EmotionType.like,
        referenceId: feedId,
        referenceTable: TableName.feed.name));
  }
}

class LikeOnFeedCommentUseCase {
  final EmotionRepository _repository;

  LikeOnFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<EmotionEntity>> call(String commentId) async {
    return await _repository.upsertEmotion(EmotionEntity(
        type: EmotionType.like,
        referenceId: commentId,
        referenceTable: TableName.feedComment.name));
  }
}
