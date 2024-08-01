import 'package:logger/logger.dart';
import 'package:portfolio/features/emotion/data/model/emotion.model.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../main/core/constant/supabase_constant.dart';

part "emotion.datasource.dart";

class EmotionDataSourceImpl implements EmotionDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  EmotionDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.emotion.name;

  @override
  EmotionModel audit(EmotionModel model) {
    return model.copyWith(
        id: const Uuid().v4(),
        created_by: model.created_by.isNotEmpty
            ? model.created_by
            : _client.auth.currentUser!.id,
        created_at: DateTime.now().toUtc());
  }

  @override
  Future<void> upsertEmotion(EmotionModel model) async {
    await _client.rest.from(tableName).upsert(audit(model).toJson());
  }

  @override
  Future<void> deleteEmotionById(String id) async {
    await _client.rest.from(tableName).delete().eq("id", id);
  }

  @override
  RealtimeChannel getEmotionChannel(
      {void Function(EmotionModel newModel)? onInsert,
      void Function(EmotionModel oldModel, EmotionModel newModel)? onUpdate,
      void Function(EmotionModel oldModel)? onDelete}) {
    final currentUid = _client.auth.currentUser!.id;
    final key = "emotion:$currentUid";
    final filter = PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: "created_by",
        value: currentUid);
    return _client
        .channel(key, opts: RealtimeChannelConfig(key: key))
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: tableName,
            filter: filter,
            callback: onInsert == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.newRecord);
                    onInsert(EmotionModel.fromJson(payload.newRecord));
                  })
        .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: tableName,
            filter: filter,
            callback: onUpdate == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.newRecord);
                    onUpdate(EmotionModel.fromJson(payload.oldRecord),
                        EmotionModel.fromJson(payload.newRecord));
                  })
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: tableName,
            filter: filter,
            callback: onDelete == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.newRecord);
                    onDelete(EmotionModel.fromJson(payload.newRecord));
                  });
  }
}
