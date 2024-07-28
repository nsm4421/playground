part of "chat_message.datasource.dart";

class PrivateChatMessageDataSourceImpl implements PrivateChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  PrivateChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  String get tableName => TableName.privateChatMessage.name;

  @override
  String getChatId(String receiver, {String? sender}) {
    return ([sender ?? _client.auth.currentUser!.id, receiver]..sort())
        .join("_");
  }

  @override
  PrivateChatMessageModel audit(PrivateChatMessageModel model) {
    return model.copyWith(
        id: const Uuid().v4(),
        created_at: DateTime.now().toUtc(),
        chat_id: getChatId(model.receiver, sender: model.sender));
  }

  @override
  Future<void> createChatMessage(PrivateChatMessageModel model) async {
    return await _client.rest.from(tableName).insert(audit(model).toJson());
  }

  @override
  Future<void> deleteChatMessageById(String messageId) async {
    return await _client.rest.from(tableName).delete().eq("id", messageId);
  }

  @override
  Future<Iterable<PrivateChatMessageWithUserModelForRpc>> fetchLastMessages(
      DateTime afterAt) async {
    return await _client.rpc("get_latest_private_chat_messages", params: {
      "afterAt": afterAt.toUtc().toIso8601String()
    }).then((res) => (res as Iterable<Map<String, dynamic>>)
        .map(PrivateChatMessageWithUserModelForRpc.fromJson));
  }

  @override
  Future<Iterable<PrivateChatMessageWithUserModel>> fetchMessages(
      {required DateTime beforeAt,
      required String receiver,
      int take = 20,
      bool ascending = true}) async {
    return await _client.rest
        .from(tableName)
        .select(
            "id, chat_id, content, created_at, sender:${TableName.account.name}(*), receiver:${TableName.account.name}(*)")
        .eq("chat_id", getChatId(receiver))
        .lte("created_at", beforeAt)
        .order("created_at", ascending: ascending)
        .range(0, take)
        .then((res) => res.map(PrivateChatMessageWithUserModel.fromJson));
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(PrivateChatMessageModel newModel)? onInsert,
      void Function(PrivateChatMessageModel oldModel,
              PrivateChatMessageModel newModel)?
          onUpdate,
      void Function(PrivateChatMessageModel oldModel)? onDelete}) {
    final currentUid = _client.auth.currentUser!.id;
    final insertCallback = onInsert == null
        ? _logger.d
        : (PostgresChangePayload payload) {
            _logger.d(payload.newRecord);
            onInsert(PrivateChatMessageModel.fromJson(payload.newRecord));
          };
    final updateCallback = onUpdate == null
        ? _logger.d
        : (PostgresChangePayload payload) {
            _logger.d(payload.oldRecord, payload.newRecord);
            onUpdate(PrivateChatMessageModel.fromJson(payload.oldRecord),
                PrivateChatMessageModel.fromJson(payload.newRecord));
          };
    final deleteCallback = onDelete == null
        ? _logger.d
        : (PostgresChangePayload payload) {
            _logger.d(payload.oldRecord, payload.oldRecord);
            onDelete(PrivateChatMessageModel.fromJson(payload.oldRecord));
          };
    final senderFilter = PostgresChangeFilter(
      type: PostgresChangeFilterType.eq,
      column: "sender",
      value: currentUid,
    );
    final receiverFilter = PostgresChangeFilter(
      type: PostgresChangeFilterType.eq,
      column: "receiver",
      value: currentUid,
    );
    return _client
        .channel(key, opts: RealtimeChannelConfig(key: key))
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: tableName,
            filter: senderFilter,
            callback: insertCallback)
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: tableName,
            filter: receiverFilter,
            callback: insertCallback)
        .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: tableName,
            filter: senderFilter,
            callback: updateCallback)
        .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: tableName,
            filter: receiverFilter,
            callback: updateCallback)
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: tableName,
            filter: senderFilter,
            callback: deleteCallback)
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: tableName,
            filter: receiverFilter,
            callback: deleteCallback);
  }
}
