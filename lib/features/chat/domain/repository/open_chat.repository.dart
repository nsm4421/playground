part of 'package:portfolio/features/chat/data/repository_impl/open_chat.repository_impl.dart';

abstract class OpenChatRepository {
  Stream<List<OpenChatEntity>> get chatStream;

  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat);
}
