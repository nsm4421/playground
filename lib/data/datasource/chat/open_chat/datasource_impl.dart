part of 'datasource.dart';

class OpenChatRoomDataSourceImpl implements OpenChatRoomDataSource {
  final SupabaseClient _supabaseClient;

  OpenChatRoomDataSourceImpl(this._supabaseClient);

  @override
  Future<String> createChatRoom(CreateOpenChatModel model) async {
    final id = const Uuid().v4();
    return await _supabaseClient.rest.from(Tables.openChatRooms.name).insert({
      ...model.toJson(),
      'id': id,
      'created_at': customUtil.now,
      'last_message_created_at': customUtil.now,
      'created_by': _supabaseClient.auth.currentUser!.id,
    }).then((_) => id);
  }

  @override
  Future<Iterable<FetchOpenChatModel>> fetchChatRooms(DateTime beforeAt,
      {int take = 20}) async {
    // TODO : RPC 함수 구현
    return await _supabaseClient
        .rpc<List<Map<String, dynamic>>>(RpcFns.fetchOpenChats.name, params: {
      'before_at': beforeAt,
      'take': take
    }).then((res) => res.map(FetchOpenChatModel.fromJson));
  }

  @override
  Future<void> editChatRoom(EditOpenChatModel model) async {
    return await _supabaseClient.rest.from(Tables.openChatRooms.name).update({
      if (model.title != null) 'title': model.title,
      if (model.hashtags != null) 'hashtags': model.hashtags
    }).eq('id', model.id);
  }

  @override
  Future<void> editChatRoomMetaData(EditOpenChatMetaDataModel model) async {
    return await _supabaseClient.rest.from(Tables.openChatRooms.name).update({
      'last_message_content': model.last_message_content,
      if (model.last_message_created_at != null)
        'last_message_created_at': model.last_message_created_at
    }).eq('id', model.id);
  }

  @override
  Future<void> deleteChatRoom(String id) async {
    return await _supabaseClient.rest
        .from(Tables.openChatRooms.name)
        .delete()
        .eq('id', id);
  }
}

class OpenChatMessageDataSourceImpl implements OpenChatMessageDataSource {
  final SupabaseClient _supabaseClient;

  OpenChatMessageDataSourceImpl(this._supabaseClient);

  @override
  Future<String> createChatMessage(CreateOpenChatMessageModel model) async {
    final id = const Uuid().v4();
    return await _supabaseClient.rest
        .from(Tables.openChatMessages.name)
        .insert({
      ...model.toJson(),
      'id': id,
      'created_at': customUtil.now,
      'created_by': _supabaseClient.auth.currentUser!.id,
      'removed_at': null,
    }).then((_) => id);
  }

  @override
  Future<Iterable<FetchOpenChatMessageModel>> fetchChatMessages(
      {required String chatId,
      required DateTime beforeAt,
      int take = 20}) async {
    // TODO : RPC 함수 구현
    return await _supabaseClient.rpc<List<Map<String, dynamic>>>(
        RpcFns.fetchOpenChatMessages.name,
        params: {
          'chat_id': chatId,
          'before_at': beforeAt,
          'take': take
        }).then((res) => res.map(FetchOpenChatMessageModel.fromJson));
  }

  @override
  Future<void> softDeleteChatMessage(String messageId) async {
    return await _supabaseClient.rest
        .from(Tables.openChatMessages.name)
        .update({'removed_at': customUtil.now}); // soft delete
  }
}
