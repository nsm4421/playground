import 'package:logger/logger.dart';
import 'package:my_app/core/constant/error_code.dart';
import 'package:my_app/domain/model/chat/private_chat/save_private_chat_message_request.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/database.constant.dart';
import '../../../../core/exception/custom_exception.dart';
part '../abstract/private_chat_message.remote_datasource.dart';

class RemotePrivateChatMessageDataSourceImpl
    implements RemotePrivateChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemotePrivateChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  static const String _orderByField = "createdAt";

  // 현재 로그인 유저의 id
  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }

  @override
  Future<void> deleteMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.privateChatMessage.name)
          .delete()
          .eq("id", messageId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChatMessage(SavePrivateChatMessageRequestDto dto) async {
    try {
      // uid 검사
      final senderUid = _getCurrentUidOrElseThrow;
      if (dto.receiverUid.isEmpty) {
        throw CustomException(
            errorCode: ErrorCode.invalidArgs,
            message: 'receiver uid is not given');
      }
      // chat id
      String chatId = dto.chatId;
      if (chatId.isEmpty) {
        final users = [senderUid, dto.receiverUid];
        users.sort();
        chatId = users.join();
      }
      return await _client.rest
          .from(TableName.privateChatMessage.name)
          .insert(dto.copyWith(chatId: chatId).toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
