part of 'datasource.dart';

class PrivateChatDataSourceImpl
    with CustomLogger
    implements PrivateChatDataSource {
  final SupabaseClient _supabaseClient;

  PrivateChatDataSourceImpl(this._supabaseClient);

  String get _table => Tables.privateChats.name;

  @override
  Future<void> create(
      {required String chatId, required CreatePrivateChatDto dto}) async {
    return await _supabaseClient.rest.from(_table).insert({
      ...dto.toJson(),
      'id': chatId,
      'user_id': _supabaseClient.auth.currentUser!.id,
      'created_at': now,
      'updated_at': now,
      'deleted_at': null
    });
  }

  @override
  Future<Iterable<FetchPrivateChatDto>> fetch(
      {required String beforeAt, int take = 20}) async {
    return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
        // TODO : RPC 함수 구현하기
        RpcFns.fetchPrivateChats.name,
        params: {
          '_before_at': beforeAt,
          '_take': take,
          '_id': _supabaseClient.auth.currentUser!.id
        }).then((res) => res.map(FetchPrivateChatDto.fromJson));
  }

  @override
  Future<void> update(
      {required String chatId, required String lastMessage}) async {
    return await _supabaseClient.rest.from(_table).update({
      'last_message': lastMessage,
      'updated_at': now,
    }).eq('id', chatId);
  }

  @override
  Future<void> delete(String chatId) async {
    return await _supabaseClient.rest
        .from(_table)
        .update({'deleted_at': now}).eq('id', chatId);
  }
}

class PrivateMessageDataSourceImpl
    with CustomLogger
    implements PrivateMessageDataSource {
  final SupabaseClient _supabaseClient;

  PrivateMessageDataSourceImpl(this._supabaseClient);

  String get _table => Tables.privateMessages.name;

  @override
  Future<void> create(
      {required String id, required CreatePrivateMessageDto dto}) async {
    return await _supabaseClient.rest.from(_table).insert({
      ...dto.toJson(),
      'id': id,
      'sender_id': _supabaseClient.auth.currentUser!.id,
      'created_at': now,
      'updated_at': now,
      'deleted_at': null
    });
  }

  @override
  Future<Iterable<FetchPrivateMessageDto>> fetch(
      {required String beforeAt, required String chatId, int take = 20}) async {
    return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
        // TODO : RPC 함수 구현하기
        RpcFns.fetchPrivateChats.name,
        params: {
          '_before_at': beforeAt,
          '_take': take,
          '_chat_id': chatId
        }).then((res) => res.map(FetchPrivateMessageDto.fromJson));
  }

  @override
  Future<void> delete(String messageId) async {
    return await _supabaseClient.rest
        .from(_table)
        .update({'deleted_at': now}).eq('id', messageId);
  }
}
