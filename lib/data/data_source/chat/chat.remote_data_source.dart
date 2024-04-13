import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat.model.dart';
import 'package:hot_place/domain/model/chat/open_chat/open_chat_with_user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/custom_exception.dart';
import '../../../core/error/failure.constant.dart';

class RemoteChatDataSource extends ChatDataSource {
  final GoTrueClient _auth;
  final PostgrestClient _db;
  final SupabaseStorageClient _storage;

  RemoteChatDataSource(
      {required GoTrueClient auth,
      required PostgrestClient db,
      required SupabaseStorageClient storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final _logger = Logger();

  @override
  Stream<List<OpenChatWithUserModel>> get openChatStream {
    return _db
        .from(TableName.openChat.name)
        .select("*, host:${TableName.user.name}(*)")
        .order('created_at', ascending: false)
        .asStream()
        .map((data) =>
            data.map((json) => OpenChatWithUserModel.fromJson(json)).toList());
  }

  @override
  Future<OpenChatModel> createOpenChat(OpenChatModel chat) async {
    try {
      return await _db
          .from(TableName.openChat.name)
          .insert(chat.toJson())
          .select()
          .then((json) => OpenChatModel.fromJson(json.first));
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Future<void> deleteOpenChatById(String openChatId) async {
    try {
      await _db.from(TableName.openChat.name).delete().eq('id', openChatId);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }

  @override
  Future<String> modifyOpenChat(OpenChatModel chat) async {
    try {
      return await _db
          .from(TableName.openChat.name)
          .update(chat.toJson())
          .eq('id', chat.id)
          .select()
          .then((json) => OpenChatModel.fromJson(json.first).id);
    } on PostgrestException catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.postgresError, message: err.message);
    } catch (err) {
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.toString());
    }
  }
}
