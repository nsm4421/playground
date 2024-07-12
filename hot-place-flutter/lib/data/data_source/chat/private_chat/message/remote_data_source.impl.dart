import 'package:hot_place/data/data_source/chat/private_chat/message/remote_data_source.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/supbase.constant.dart';
import '../../../../../core/util/exeption.util.dart';

class RemotePrivateChatMessageDataSourceImpl
    implements RemotePrivateChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemotePrivateChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<void> createChatMessage(PrivateChatMessageModel message) async {
    try {
      return await _client.rest
          .from(TableName.privateChatMessage.name)
          .insert(message.toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<String> deleteChatMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.privateChatMessage.name)
          .delete()
          .eq('id', messageId)
          .then((value) => messageId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Stream<List<PrivateChatMessageModel>> getChatMessageStream(String chatId) {
    try {
      return _client
          .from(TableName.privateChatMessage.name)
          .stream(primaryKey: ['id'])
          .eq('chat_id', chatId)
          .order('created_at', ascending: true)
          .asyncMap((data) async =>
              data.map(PrivateChatMessageModel.fromJson).toList());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
