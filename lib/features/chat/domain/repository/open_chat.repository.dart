part of 'package:portfolio/features/chat/data/repository_impl/open_chat.repository_impl.dart';

abstract class OpenChatRepository {
  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat);
}
