import 'package:logger/logger.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constant/supabase_constant.dart';
import '../../../../model/chat/private_chat_message/private_chat_message.model.dart';
import '../../../../model/chat/private_chat_message/private_chat_message_with_user.model.dart';
import '../abstract/chat_message.remote_datasource.dart';

part "../abstract/private_chat_message.remote_datasource.dart";

class PrivateChatMessageRemoteDataSourceImpl implements PrivateChatMessageRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  PrivateChatMessageRemoteDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.privateChatMessage.name;

  @override
  String getChatId(String receiver, {String? sender}) {
    return ([sender ?? _client.auth.currentUser!.id, receiver]..sort())
        .join("_");
  }

  @override
  PrivateChatMessageModel audit(PrivateChatMessageModel model) {
    final currentUid = _client.auth.currentUser!.id;
    return model.copyWith(
        id: model.id.isNotEmpty ? model.id : const Uuid().v4(),
        created_at: model.created_at ?? DateTime.now().toUtc(),
        sender: model.sender.isNotEmpty ? model.sender : currentUid,
        chat_id: getChatId(model.receiver, sender: currentUid));
  }

  @override
  Future<void> createChatMessage(PrivateChatMessageModel model) async {
    try {
      final audited = audit(model);
      _logger.d(audited);
      await _client.rest.from(tableName).insert(audited.toJson());
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatMessageById(String messageId) async {
    try {
      await _client.rest.from(tableName).delete().eq("id", messageId);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<Iterable<PrivateChatMessageWithUserModelForRpc>> fetchLastMessages(
      DateTime afterAt) async {
    try {
      final res = await _client.rpc<List<Map<String, dynamic>>>(
          "get_latest_private_chat_messages",
          params: {"after_at": afterAt.toIso8601String()}).then((res) {
        return res.map(PrivateChatMessageWithUserModelForRpc.fromJson);
      });
      _logger.d(res);
      return res;
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<Iterable<PrivateChatMessageWithUserModel>> fetchMessages(
      {required DateTime beforeAt,
      required String chatId,
      int take = 20,
      bool ascending = true}) async {
    try {
      return await _client.rest
          .from(tableName)
          .select("id, chat_id, content, created_at, "
              "sender:${TableName.account.name}!private_chat_messages_sender_fkey(*), "
              "receiver:${TableName.account.name}!private_chat_messages_receiver_fkey(*)")
          .eq("chat_id", chatId)
          .lt("created_at", beforeAt)
          .order("created_at", ascending: ascending)
          .range(0, take)
          .then((res) => res.map(PrivateChatMessageWithUserModel.fromJson));
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(PrivateChatMessageModel newModel)? onInsert,
      void Function(PrivateChatMessageModel oldModel,
              PrivateChatMessageModel newModel)?
          onUpdate,
      void Function(PrivateChatMessageModel oldModel)? onDelete}) {
    try {
      final currentUid = _client.auth.currentUser!.id;
      final insertCallback = onInsert == null
          ? (_) {}
          : (PostgresChangePayload payload) {
              onInsert(PrivateChatMessageModel.fromJson(payload.newRecord));
            };
      final updateCallback = onUpdate == null
          ? (_) {}
          : (PostgresChangePayload payload) {
              onUpdate(PrivateChatMessageModel.fromJson(payload.oldRecord),
                  PrivateChatMessageModel.fromJson(payload.newRecord));
            };
      final deleteCallback = onDelete == null
          ? (_) {}
          : (PostgresChangePayload payload) {
              onDelete(PrivateChatMessageModel.fromJson(payload.oldRecord));
            };
      final senderFilter = PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: "sender",
        value: currentUid,
      );
      final receiverFilter = PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: "receiver",
        value: currentUid,
      );
      return _client
          .channel(key, opts: RealtimeChannelConfig(key: key))
          .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: tableName,
              filter: senderFilter,
              callback: insertCallback)
          .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: tableName,
              filter: receiverFilter,
              callback: insertCallback)
          .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: tableName,
              filter: senderFilter,
              callback: updateCallback)
          .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: tableName,
              filter: receiverFilter,
              callback: updateCallback)
          .onPostgresChanges(
              event: PostgresChangeEvent.delete,
              schema: 'public',
              table: tableName,
              filter: senderFilter,
              callback: deleteCallback)
          .onPostgresChanges(
              event: PostgresChangeEvent.delete,
              schema: 'public',
              table: tableName,
              filter: receiverFilter,
              callback: deleteCallback);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }
}
