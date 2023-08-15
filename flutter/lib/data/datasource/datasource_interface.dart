import 'package:flutter_prj/model/chat_model.dart';
import 'package:flutter_prj/model/local_message_model.dart';

abstract class IDataSource {
  /// create
  Future<void> addChat(Chat chat);

  Future<void> addMessage(LocalMessage message);

  /// read
  Future<Chat> findChat(String chatId);

  Future<List<Chat>> findAllChat();

  Future<List<LocalMessage>> findMessages(String chatId);

  /// update
  Future<void> updateMessage(LocalMessage message);

  /// delete
  Future<void> deleteChat(String chatId);
}
