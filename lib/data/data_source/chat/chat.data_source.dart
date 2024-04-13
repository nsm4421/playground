import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';

abstract class ChatDataSource {
  Stream<List<OpenChatModel>> get openChatStream;

  Future<OpenChatModel> createOpenChat(OpenChatModel chat);

  Future<String> modifyOpenChat(OpenChatModel chat);

  Future<void> deleteOpenChatById(String openChatId);
}
