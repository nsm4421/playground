import 'package:portfolio/features/chat/data/datasource/open_chat.datasource.dart';
import 'package:portfolio/features/chat/data/model/open_chat.model.dart';
import 'package:portfolio/features/main/core/constant/supabase_constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpenChatDataSourceImpl implements OpenChatDataSource {
  final SupabaseClient _client;

  OpenChatDataSourceImpl(this._client);

  @override
  Future<void> createChat(OpenChatModel chatRoom) async {
    await _client.rest
        .from(TableName.openChatRoom.name)
        .insert(chatRoom.toJson());
  }
}
