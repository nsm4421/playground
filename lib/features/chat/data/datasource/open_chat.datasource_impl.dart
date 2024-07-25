import 'package:portfolio/features/chat/data/datasource/open_chat.datasource.dart';
import 'package:portfolio/features/chat/data/model/open_chat.model.dart';
import 'package:portfolio/features/main/core/constant/supabase_constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class OpenChatDataSourceImpl implements OpenChatDataSource {
  final SupabaseClient _client;

  OpenChatDataSourceImpl(this._client);

  @override
  OpenChatModel audit(OpenChatModel model) {
    return model.copyWith(
        id: const Uuid().v4(),
        created_at: DateTime.now().toUtc(),
        created_by: _client.auth.currentUser!.id);
  }

  @override
  Stream<Iterable<OpenChatModel>> get chatStream => _client
      .from(TableName.openChatRoom.name)
      .stream(primaryKey: ["id"])
      .order("created_at")
      .asyncMap((event) => event.map(OpenChatModel.fromJson));

  @override
  Future<void> createChat(OpenChatModel chatRoom) async {
    await _client.rest
        .from(TableName.openChatRoom.name)
        .insert(audit(chatRoom).toJson());
  }
}
