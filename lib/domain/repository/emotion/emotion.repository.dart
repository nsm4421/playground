part of "../../../data/repository_impl/emotion/emotion.repository_impl.dart";

abstract interface class EmotionRepository {
  Future<ResponseWrapper<void>> upsertEmotion(EmotionEntity entity);

  Future<ResponseWrapper<void>> deleteEmotionById(String id);

  RealtimeChannel getEmotionChannel(
      {void Function(EmotionEntity newModel)? onInsert,
      void Function(EmotionEntity oldModel, EmotionEntity newModel)? onUpdate,
      void Function(EmotionEntity oldModel)? onDelete});
}
