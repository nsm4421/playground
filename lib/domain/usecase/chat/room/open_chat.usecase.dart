import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/repository/chat/room/open_chat.repository.dart';
import 'package:hot_place/domain/usecase/chat/room/case/create_open_chat.usecase.dart';
import 'package:hot_place/domain/usecase/chat/room/case/delete_chat.usecase.dart';
import 'package:hot_place/domain/usecase/chat/room/case/modify_open_chat.usecase.dart';
import 'package:injectable/injectable.dart';

import 'case/get_chat_stream.usecase.dart';

@lazySingleton
class OpenChatUseCase {
  final OpenChatRepository _repository;

  OpenChatUseCase(this._repository);

  @injectable
  CreateOpenChatUseCase get createChat => CreateOpenChatUseCase(_repository);

  @injectable
  DeleteChatUseCase<OpenChatRepository> get deleteChat =>
      DeleteChatUseCase<OpenChatRepository>(_repository);

  @injectable
  GetChatStreamUseCase<OpenChatRepository, OpenChatEntity> get chatStream =>
      GetChatStreamUseCase<OpenChatRepository, OpenChatEntity>(_repository);

  @injectable
  ModifyOpenChatUseCase get modifyOpenChat =>
      ModifyOpenChatUseCase(_repository);
}
