part of 'datasource.dart';

class PrivateChatRoomDataSourceImpl implements PrivateChatRoomDataSource {
  final SupabaseClient _supabaseClient;

  PrivateChatRoomDataSourceImpl(this._supabaseClient);

  @override
  Future<void> createChatRoom(CreatePrivateChatModel model) {
    // TODO: implement createChatRoom
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChatRoom(String opponentUid) {
    // TODO: implement deleteChatRoom
    throw UnimplementedError();
  }

  @override
  Future<Iterable<FetchPrivateChatModel>> fetchChatRooms(DateTime beforeAt,
      {int take = 20}) {
    // TODO: implement fetchChatRooms
    throw UnimplementedError();
  }
}

class PrivateChatMessageDataSourceImpl implements PrivateChatMessageDataSource {
  final SupabaseClient _supabaseClient;

  PrivateChatMessageDataSourceImpl(this._supabaseClient);

  @override
  Future<Iterable<FetchPrivateChatMessageModel>> fetchMessages(
      {required String chatId, required DateTime beforeAt, int take = 20}) {
    // TODO: implement fetchMessages
    throw UnimplementedError();
  }
}
