import 'package:logger/logger.dart';
import 'package:my_app/domain/model/chat/message/chat_message.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_message.datasource.dart';

class LocalChatMessageDataSourceImpl implements LocalChatMessageDataSource {}

class RemoteChatMessageDataSourceImpl implements RemoteChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const orderByForMessage = "createdAt";

  RemoteChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<Iterable<ChatMessageModel>> getChatMessageStream(String chatId) =>
      throw UnimplementedError();

  @override
  Future<void> saveChatMessage(ChatMessageModel model) async =>
      throw UnimplementedError();

  @override
  Future<void> deleteChatMessage(ChatMessageModel model) async =>
      throw UnimplementedError();
}
