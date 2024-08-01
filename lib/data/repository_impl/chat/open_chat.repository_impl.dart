import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:portfolio/domain/entity/chat/open_chat.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../datasource/chat/impl/open_chat.datasource_impl.dart';
import '../../model/chat/open_chat/open_chat.model.dart';

part '../../../domain/repository/chat/open_chat.repository.dart';

@LazySingleton(as: OpenChatRepository)
class OpenChatRepositoryImpl implements OpenChatRepository {
  final OpenChatDataSource _dataSource;
  final _logger = Logger();

  OpenChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<OpenChatEntity>> get chatStream => _dataSource.chatStream
      .asyncMap((event) => event.map(OpenChatEntity.fromModel).toList());

  @override
  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat) async {
    try {
      await _dataSource.createChat(OpenChatModel.fromEntity(chat));
      return ResponseWrapper.success(null);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error("create open chat fail");
    }
  }

  @override
  Future<ResponseWrapper<void>> updateLastMessage(
      {required String chatId, required String lastMessage}) async {
    try {
      await _dataSource.updateLastMessage(
          chatId: chatId, lastMessage: lastMessage);
      return ResponseWrapper.success(null);
    } on PostgrestException catch (error) {
      _logger.e(error);
      return ResponseWrapper.error(error.message);
    } catch (error) {
      _logger.e(error);
      return ResponseWrapper.error("update last message fail");
    }
  }
}
