part of "emotion.datasource_impl.dart";

abstract interface class EmotionDataSource implements BaseDataSource {
  EmotionModel audit(EmotionModel model);

  Future<void> upsertEmotion(EmotionModel model);

  Future<void> deleteEmotionById(String id);

  RealtimeChannel getEmotionChannel(
      {void Function(EmotionModel newModel)? onInsert,
      void Function(EmotionModel oldModel, EmotionModel newModel)? onUpdate,
      void Function(EmotionModel oldModel)? onDelete});
}
