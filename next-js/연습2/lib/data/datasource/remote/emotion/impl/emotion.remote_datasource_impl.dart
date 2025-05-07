import 'package:logger/logger.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:portfolio/data/model/emotion/emotion.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/supabase_constant.dart';
import '../../../base/remote_datasource.dart';

part "../abstract/emotion.remote_datasource.dart";

class EmotionRemoteDataSourceImpl implements EmotionRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  EmotionRemoteDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.emotion.name;

  @override
  EmotionModel audit(EmotionModel model) {
    return model.copyWith(
        id: [model.reference_id, model.reference_table].join("_"),
        created_by: model.created_by.isNotEmpty
            ? model.created_by
            : _client.auth.currentUser!.id,
        created_at: model.created_at ?? DateTime.now().toUtc());
  }

  @override
  Future<EmotionModel> upsertEmotion(EmotionModel model) async {
    try {
      final audited = audit(model);
      _logger.d(audited);
      return await _client.rest
          .from(tableName)
          .upsert(audited.toJson())
          .then((_) => audited);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> deleteEmotionById(String id) async {
    try {
      await _client.rest.from(tableName).delete().eq("id", id);
      _logger.d('deleted id:$id');
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  RealtimeChannel getEmotionChannel(
      {void Function(EmotionModel newModel)? onInsert,
      void Function(EmotionModel oldModel, EmotionModel newModel)? onUpdate,
      void Function(EmotionModel oldModel)? onDelete}) {
    try {
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
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onInsert(EmotionModel.fromJson(payload.newRecord));
                    })
          .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: tableName,
              filter: filter,
              callback: onUpdate == null
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onUpdate(EmotionModel.fromJson(payload.oldRecord),
                          EmotionModel.fromJson(payload.newRecord));
                    })
          .onPostgresChanges(
              event: PostgresChangeEvent.delete,
              schema: 'public',
              table: tableName,
              filter: filter,
              callback: onDelete == null
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onDelete(EmotionModel.fromJson(payload.newRecord));
                    });
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }
}
