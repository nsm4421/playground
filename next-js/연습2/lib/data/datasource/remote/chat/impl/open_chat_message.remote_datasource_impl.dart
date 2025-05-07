import 'package:logger/logger.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/supabase_constant.dart';
import '../../../../model/chat/open_chat_message/open_chat_message.model.dart';
import '../../../../model/chat/open_chat_message/open_chat_message_with_user.model.dart';
import '../abstract/chat_message.remote_datasource.dart';

part "../abstract/open_chat_message.remote_datasource.dart";

class OpenChatMessageRemoteDataSourceImpl implements OpenChatMessageRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  OpenChatMessageRemoteDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  OpenChatMessageModel audit(OpenChatMessageModel model) {
    return model.copyWith(
        id: model.id.isNotEmpty ? model.id : const Uuid().v4(),
        created_at: model.created_at ?? DateTime.now().toUtc(),
        created_by: model.created_by.isNotEmpty
            ? model.created_by
            : _client.auth.currentUser!.id);
  }

  @override
  String get tableName => TableName.openChatMessage.name;

  @override
  Future<Iterable<OpenChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true}) async {
    try {
      final res = await _client.rest
          .from(tableName)
          .select("*, user:${TableName.account.name}(*)")
          .eq("chat_id", chatId)
          .lt("created_at", beforeAt)
          .order("created_at", ascending: ascending)
          .range(from, to)
          .then((res) => res.map(OpenChatMessageWithUserModel.fromJson));
      _logger.d(res);
      return res;
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> createChatMessage(OpenChatMessageModel model) async {
    try {
      final audited = audit(model);
      _logger.d(audited);
      return await _client.rest.from(tableName).insert(audited.toJson());
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(OpenChatMessageModel newModel)? onInsert,
      void Function(
              OpenChatMessageModel oldModel, OpenChatMessageModel newModel)?
          onUpdate,
      void Function(OpenChatMessageModel oldModel)? onDelete}) {
    try {
      return _client
          .channel(key, opts: RealtimeChannelConfig(key: key))
          .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: tableName,
              callback: onInsert == null
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onInsert(
                          OpenChatMessageModel.fromJson(payload.newRecord));
                    })
          .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: tableName,
              callback: onUpdate == null
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onUpdate(OpenChatMessageModel.fromJson(payload.oldRecord),
                          OpenChatMessageModel.fromJson(payload.newRecord));
                    })
          .onPostgresChanges(
              event: PostgresChangeEvent.delete,
              schema: 'public',
              table: tableName,
              callback: onDelete == null
                  ? (_) {}
                  : (PostgresChangePayload payload) {
                      onDelete(
                          OpenChatMessageModel.fromJson(payload.oldRecord));
                    });
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatMessageById(String messageId) async {
    return await _client.rest
        .from(tableName)
        .delete()
        .eq("id", messageId)
        .then((_) {
      _logger.d('deleted id:$messageId');
    });
  }
}
