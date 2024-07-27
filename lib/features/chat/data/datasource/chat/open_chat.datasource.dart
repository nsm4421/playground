part of "chat.datasource.dart";

class OpenChatDataSourceImpl implements OpenChatDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  OpenChatDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  OpenChatModel audit(OpenChatModel model) {
    return model.copyWith(
        id: const Uuid().v4(),
        created_at: DateTime.now().toUtc(),
        created_by: _client.auth.currentUser!.id);
  }

  @override
  String get tableName => TableName.openChatRoom.name;

  @override
  Stream<Iterable<OpenChatModel>> get chatStream => _client
      .from(tableName)
      .stream(primaryKey: ["id"])
      .order("created_at")
      .asyncMap((event) => event.map(OpenChatModel.fromJson));

  @override
  Future<void> createChat(OpenChatModel chatRoom) async {
    final audited = audit(chatRoom);
    await _client.rest.from(tableName).insert(audited.toJson()).then((_) {
      _logger.d(audited);
    });
  }

  @override
  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage}) async {
    await _client.rest.from(tableName).update({
      "last_message": lastMessage,
      "last_talk_at": DateTime.now().toUtc().toIso8601String()
    }).eq("id", chatId);
  }
}
