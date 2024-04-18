import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';

import '../../../../../domain/model/chat/private_chat/room/private_chat.local_model.dart';

abstract interface class LocalPrivateChatDataSource {
  Future<void> saveChat(LocalPrivateChatModel chat);

  Future<void> deleteChat(String chatId);
}

abstract interface class RemotePrivateChatDataSource {
  Stream<List<PrivateChatModel>> getChatStream(String userId);

  Future<void> createChat(PrivateChatModel chat);

  Future<void> deleteChat(String chatId);
}
