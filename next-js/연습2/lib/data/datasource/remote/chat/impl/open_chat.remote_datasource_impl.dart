import 'package:logger/logger.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/constant/supabase_constant.dart';
import '../../../../model/chat/open_chat/open_chat.model.dart';
import '../../../base/remote_datasource.dart';

part "../abstract/open_chat.remote_datasource.dart";

class OpenChatRemoteDataSourceImpl implements OpenChatRemoteDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  OpenChatRemoteDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  OpenChatModel audit(OpenChatModel model) {
    return model.copyWith(
        id: model.id.isNotEmpty ? model.id : const Uuid().v4(),
        created_at: model.created_at ?? DateTime.now().toUtc(),
        created_by: model.created_by.isNotEmpty
            ? model.created_by
            : _client.auth.currentUser!.id);
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
    try {
      final audited = audit(chatRoom);
      _logger.d(audited);
      await _client.rest.from(tableName).insert(audited.toJson());
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage}) async {
    try {
      _logger.d('deleted id:$chatId}');
      await _client.rest.from(tableName).update({
        "last_message": lastMessage,
        "last_talk_at": DateTime.now().toUtc().toIso8601String()
      }).eq("id", chatId);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }

  @override
  Future<void> deleteChatById(String chatId) async {
    try {
      _logger.d('deleted id:$chatId}');
      return await _client.rest.from(tableName).delete().eq("id", chatId);
    } catch (e) {
      throw CustomException.from(e, logger: _logger);
    }
  }
}
