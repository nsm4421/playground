import 'package:logger/logger.dart';
import 'package:my_app/domain/model/chat/open_chat/modify_open_chat_request.dto.dart';
import 'package:my_app/domain/model/chat/open_chat/save_open_chat_request.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/model/chat/open_chat/fetch_open_chat_response.dto.dart';

part '../abstract/open_chat.remote_datasource.dart';

class RemoteOpenChatDataSourceImpl implements RemoteOpenChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const _orderByField = "createdAt";

  RemoteOpenChatDataSourceImpl(
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
  Stream<Iterable<FetchOpenChatResponseDto>> get chatStream => _client
      .from(TableName.openChat.name)
      .stream(primaryKey: ['id'])
      .order(_orderByField, ascending: false)
      .asyncMap((event) => event.map(FetchOpenChatResponseDto.fromJson));

  @override
  Future<void> saveChat(SaveOpenChatRequestDto dto) async {
    try {
      return await _client.rest
          .from(TableName.openChat.name)
          .insert(dto.toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> modifyChat(ModifyOpenChatRequestDto dto) async {
    try {
      return await _client.rest.from(TableName.openChat.name).update({
        if (dto.title != null) 'title': dto.title,
        if (dto.lastTalkAt != null)
          'lastTalkAt': dto.lastTalkAt!.toIso8601String(),
        if (dto.lastMessage != null) 'lastMessage': dto.lastMessage,
      }).eq("id", dto.chatId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatById(String chatId) async {
    try {
      return await _client.rest
          .from(TableName.openChat.name)
          .delete()
          .eq("id", chatId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
