import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/repository/chat/chat.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource _chatDataSource;

  ChatRepositoryImpl(this._chatDataSource);

  @override
  Future<void> createChat(ChatEntity chat) {
    // TODO: implement createChat
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement createMessage
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChat(ChatEntity chat) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage(MessageEntity message) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatEntity>> getChatStream(ChatEntity chat) {
    // TODO: implement getChatStream
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageEntity>> getMessageStream(MessageEntity message) {
    // TODO: implement getMessageStream
    throw UnimplementedError();
  }

  @override
  Future<void> seenMessageUpdate(MessageEntity message) {
    // TODO: implement seenMessageUpdate
    throw UnimplementedError();
  }
}
