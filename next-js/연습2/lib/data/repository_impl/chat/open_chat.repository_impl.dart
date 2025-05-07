import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/entity/chat/open_chat.entity.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/util/exception.util.dart';
import '../../datasource/remote/chat/impl/open_chat.remote_datasource_impl.dart';
import '../../model/chat/open_chat/open_chat.model.dart';

part '../../../domain/repository/chat/open_chat.repository.dart';

@LazySingleton(as: OpenChatRepository)
class OpenChatRepositoryImpl implements OpenChatRepository {
  final OpenChatRemoteDataSource _dataSource;

  OpenChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<OpenChatEntity>> get chatStream => _dataSource.chatStream
      .asyncMap((event) => event.map(OpenChatEntity.fromModel).toList());

  @override
  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat) async {
    try {
      await _dataSource.createChat(OpenChatModel.fromEntity(chat));
      return ResponseWrapper.success(null);
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> updateLastMessage(
      {required String chatId, required String lastMessage}) async {
    try {
      await _dataSource.updateLastMessage(
          chatId: chatId, lastMessage: lastMessage);
      return ResponseWrapper.success(null);
    } catch (error) {
      throw CustomException.from(error);
    }
  }
}
