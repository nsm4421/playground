import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/data/model/chat/fetch_chat_message.dart';
import 'package:travel/data/model/chat/fetch_chat_room.dart';

import '../../../model/chat/create_chat_room.dart';

part 'datasource_impl.dart';

abstract interface class PrivateChatRoomDataSource {
  Future<void> createChatRoom(CreatePrivateChatModel model);

  Future<Iterable<FetchPrivateChatModel>> fetchChatRooms(DateTime beforeAt,
      {int take = 20});

  Future<void> deleteChatRoom(String opponentUid);
}

abstract interface class PrivateChatMessageDataSource {
  Future<Iterable<FetchPrivateChatMessageModel>> fetchMessages(
      {required String chatId, required DateTime beforeAt, int take = 20});
}
