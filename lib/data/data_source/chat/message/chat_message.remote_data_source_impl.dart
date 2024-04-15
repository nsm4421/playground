import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/data/data_source/chat/message/chat_message.data_source.dart';
import 'package:hot_place/domain/model/chat/message/chat_message.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/custom_exception.dart';
import '../../../../core/error/failure.constant.dart';

class RemoteChatMessageDataSourceImpl implements RemoteChatMessageDataSource {
  final SupabaseClient _client;

  RemoteChatMessageDataSourceImpl(this._client);

  final _logger = Logger();

  @override
  Future<String> createChatMessage(ChatMessageModel chat) async {
    try {
      return await _client.rest
          .from(TableName.chatMessage.name)
          .insert(chat.toJson())
          .select()
          .limit(1)
          .then((fetched) => ChatMessageModel.fromJson(fetched.first).id);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Future<String> deleteChatMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.chatMessage.name)
          .delete()
          .eq('id', messageId)
          .then((_) => messageId);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Stream<List<ChatMessageModel>> getChatMessageStream(String chatId) {
    return _client
        .from(TableName.chatMessage.name)
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .asyncMap((data) async => data.map(ChatMessageModel.fromJson).toList());
  }
}
