import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/domain/model/chat/open_chat/room/open_chat.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/util/exeption.util.dart';
import 'remote_data_source.dart';

class RemoteOpenChatDataSourceImpl implements RemoteOpenChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteOpenChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<List<OpenChatModel>> getChatStream() {
    try {
      return _client
          .from(TableName.openChat.name)
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: false)
          .asyncMap((event) =>
          event.map((json) => OpenChatModel.fromJson(json)).toList());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> createChat(OpenChatModel chat) async {
    try {
      return await _client.rest
          .from(TableName.openChat.name)
          .insert(chat.toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatById(String chatId) async {
    try {
      await _client.rest
          .from(TableName.openChat.name)
          .delete()
          .eq('id', chatId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<String> modifyChat(OpenChatModel chat) async {
    try {
      final s = await _client.rest
          .from(TableName.openChat.name)
          .update(chat.toJson())
          .eq('id', chat.id)
          .select()
          .then((json) =>
      OpenChatModel
          .fromJson(json.first)
          .id);
      return s;
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
