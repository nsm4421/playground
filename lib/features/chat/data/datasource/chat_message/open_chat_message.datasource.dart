part of "chat_message.datasource.dart";

class OpenChatMessageDataSourceImpl implements OpenChatMessageDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  OpenChatMessageDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  ChatMessageModel audit(ChatMessageModel model) {
    return model.copyWith(
        id: const Uuid().v4(),
        created_at: DateTime.now().toUtc(),
        created_by: _client.auth.currentUser!.id);
  }

  @override
  String get tableName => TableName.openChatMessage.name;

  @override
  Future<Iterable<ChatMessageWithUserModel>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true}) async {
    return await _client.rest
        .from(tableName)
        .select("*, user:${TableName.account.name}(*)")
        .eq("chat_id", chatId)
        .lte("created_at", beforeAt)
        .order("created_at", ascending: ascending)
        .range(from, to)
        .then((res) => res.map(ChatMessageWithUserModel.fromJson));
  }

  @override
  Future<void> createChatMessage(ChatMessageModel model) async {
    final audited = audit(model);
    await _client.rest.from(tableName).insert(audited.toJson());
  }

  @override
  RealtimeChannel getMessageChannel(
      {required String key,
      void Function(ChatMessageModel newModel)? onInsert,
      void Function(ChatMessageModel oldModel, ChatMessageModel newModel)?
          onUpdate,
      void Function(ChatMessageModel oldModel)? onDelete}) {
    return _client
        .channel(key, opts: RealtimeChannelConfig(key: key))
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: tableName,
            callback: onInsert == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.newRecord);
                    onInsert(ChatMessageModel.fromJson(payload.newRecord));
                  })
        .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: tableName,
            callback: onUpdate == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.oldRecord, payload.newRecord);
                    onUpdate(ChatMessageModel.fromJson(payload.oldRecord),
                        ChatMessageModel.fromJson(payload.newRecord));
                  })
        .onPostgresChanges(
            event: PostgresChangeEvent.delete,
            schema: 'public',
            table: tableName,
            callback: onDelete == null
                ? _logger.d
                : (PostgresChangePayload payload) {
                    _logger.d(payload.oldRecord, payload.oldRecord);
                    onDelete(ChatMessageModel.fromJson(payload.oldRecord));
                  });
  }

  @override
  Future<void> deleteChatMessageById(String messageId) async {
    await _client.rest.from(tableName).delete().eq("id", messageId);
  }
}
