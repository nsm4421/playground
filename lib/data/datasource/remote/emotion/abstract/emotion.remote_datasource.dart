part of "../impl/emotion.remote_datasource_impl.dart";

abstract interface class EmotionRemoteDataSource
    implements BaseRemoteDataSource<EmotionModel> {
  Future<EmotionModel> upsertEmotion(EmotionModel model);

  Future<void> deleteEmotionById(String id);

  RealtimeChannel getEmotionChannel(
      {void Function(EmotionModel newModel)? onInsert,
      void Function(EmotionModel oldModel, EmotionModel newModel)? onUpdate,
      void Function(EmotionModel oldModel)? onDelete});
}
