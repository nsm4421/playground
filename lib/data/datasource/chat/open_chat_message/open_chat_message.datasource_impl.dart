import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/supabase.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/model/chat/message/open_chat_message.model.dart';

part 'open_chat_message.datasource.dart';

class LocalOpenChatMessageDataSourceImpl
    implements LocalOpenChatMessageDataSource {}

class RemoteOpenChatMessageDataSourceImpl
    implements RemoteOpenChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteOpenChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Future<void> saveChatMessage(OpenChatMessageModel model) async {
    try {
      return await _client.rest.from(TableName.openChatMessage.name).insert(
          model
              .copyWith(
                  id: model.id.isEmpty ? const Uuid().v4() : model.id,
                  createdBy: _getCurrentUidOrElseThrow,
                  createdAt: DateTime.now())
              .toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.openChatMessage.name)
          .delete()
          .eq("chatId", messageId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String chatId,
      required PostgresChangeEvent changeEvent,
      required void Function(PostgresChangePayload p) callback}) {
    return _client
        .channel('${TableName.openChatMessage.name}:$chatId')
        .onPostgresChanges(
            event: changeEvent,
            schema: 'public',
            table: TableName.openChatMessage.name,
            filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: "chatId",
                value: chatId),
            callback: callback);
  }
}
