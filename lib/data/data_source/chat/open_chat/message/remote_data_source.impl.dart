import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/util/exeption.util.dart';
import 'package:hot_place/data/data_source/chat/open_chat/message/remote_data_source.dart';
import 'package:hot_place/domain/model/chat/open_chat/message/open_chat_message.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteOpenChatMessageDataSourceImpl
    implements RemoteOpenChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteOpenChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<String> createChatMessage(OpenChatMessageModel chat) async {
    try {
      return await _client.rest
          .from(TableName.openChatMessage.name)
          .insert(chat.toJson())
          .select()
          .limit(1)
          .then((fetched) => OpenChatMessageModel.fromJson(fetched.first).id);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<String> deleteChatMessageById(String messageId) async {
    try {
      return await _client.rest
          .from(TableName.openChatMessage.name)
          .delete()
          .eq('id', messageId)
          .then((_) => messageId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Stream<List<OpenChatMessageModel>> getChatMessageStream(String chatId) {
    try {
      return _client
          .from(TableName.openChatMessage.name)
          .stream(primaryKey: ['id'])
          .eq('chat_id', chatId)
          .order('created_at', ascending: true)
          .asyncMap(
              (data) async => data.map(OpenChatMessageModel.fromJson).toList());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
