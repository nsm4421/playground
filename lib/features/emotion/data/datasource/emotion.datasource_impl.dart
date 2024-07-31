import 'package:logger/logger.dart';
import 'package:portfolio/features/emotion/data/model/emotion.model.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "emotion.datasource.dart";

class EmotionDataSourceImpl implements EmotionDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  EmotionDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  EmotionModel audit(EmotionModel model) {
    // TODO: implement audit
    throw UnimplementedError();
  }

  @override
  // TODO: implement tableName
  String get tableName => throw UnimplementedError();

  @override
  Future<void> upsertEmotion(EmotionModel model) {
    // TODO: implement upsertEmotion
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEmotionById(String id) {
    // TODO: implement deleteEmotion
    throw UnimplementedError();
  }

  @override
  RealtimeChannel getEmotionChannel(
      {required String key,
      void Function(EmotionModel newModel)? onInsert,
      void Function(EmotionModel oldModel, EmotionModel newModel)? onUpdate,
      void Function(EmotionModel oldModel)? onDelete}) {
    // TODO: implement getEmotionChannel
    throw UnimplementedError();
  }
}
