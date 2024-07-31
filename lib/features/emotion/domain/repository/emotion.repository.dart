part of 'package:portfolio/features/emotion/data/repository_impl/emotion.repository_impl.dart';

abstract interface class EmotionRepository {

  Future<void> upsertEmotion(EmotionEntity entity);

  Future<void> deleteEmotionById(String id);

  RealtimeChannel getEmotionChannel(
      {required String key,
        void Function(EmotionEntity newModel)? onInsert,
        void Function(EmotionEntity oldModel, EmotionEntity newModel)? onUpdate,
        void Function(EmotionEntity oldModel)? onDelete});
}
