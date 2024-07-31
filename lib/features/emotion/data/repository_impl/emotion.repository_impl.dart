import 'package:injectable/injectable.dart';
import 'package:portfolio/features/emotion/domain/entity/emotion.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'package:portfolio/features/emotion/domain/repository/emotion.repository.dart';

@LazySingleton(as: EmotionRepository)
class EmotionRepositoryImpl implements EmotionRepository {
  @override
  Future<void> deleteEmotionById(String id) {
    // TODO: implement deleteEmotionById
    throw UnimplementedError();
  }

  @override
  RealtimeChannel getEmotionChannel(
      {required String key,
      void Function(EmotionEntity newModel)? onInsert,
      void Function(EmotionEntity oldModel, EmotionEntity newModel)? onUpdate,
      void Function(EmotionEntity oldModel)? onDelete}) {
    // TODO: implement getEmotionChannel
    throw UnimplementedError();
  }

  @override
  Future<void> upsertEmotion(EmotionEntity entity) {
    // TODO: implement upsertEmotion
    throw UnimplementedError();
  }
}
