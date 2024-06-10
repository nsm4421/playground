import 'package:logger/logger.dart';
import 'package:my_app/core/constant/error_code.dart';
import 'package:my_app/domain/model/chat/base/chat.model.dart';
import 'package:my_app/domain/model/chat/message/chat_message.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constant/supabase.constant.dart';
import '../../../../core/exception/custom_exception.dart';

part 'chat.datasource.dart';

class LocalChatDataSourceImpl implements LocalChatDataSource {}

class RemoteChatDataSourceImpl implements RemoteChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const bucketName = "chats";
  static const orderByField = "lastTalkAt";
  static const orderByForMessage = "createdAt";

  RemoteChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<Iterable<ChatModel>> getChatStream() {
    try {
      return _client
          .from(TableName.chat.name)
          .stream(primaryKey: ['id'])
          .order(orderByField, ascending: false)
          .asyncMap((event) => event.map(ChatModel.fromJson));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveChat(ChatModel model) async => UnimplementedError();

  @override
  Future<void> updateLastMessage(ChatMessageModel model) async =>
      UnimplementedError();

  @override
  Future<void> deleteChat(ChatModel model) async => UnimplementedError();
}
