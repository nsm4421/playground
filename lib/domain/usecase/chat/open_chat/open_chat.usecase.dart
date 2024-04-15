import 'package:hot_place/domain/repository/chat/open_chat.repository.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/create_open_chat.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/delete_open_chat.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/modify_open_chat.usecase.dart';
import 'package:injectable/injectable.dart';

import 'case/get_open_chat_steram.usecase.dart';

@lazySingleton
class OpenChatUseCase {
  final OpenChatRepository _repository;

  OpenChatUseCase(this._repository);

  @injectable
  CreateOpenChatUseCase get createOpenChat =>
      CreateOpenChatUseCase(_repository);

  @injectable
  DeleteOpenChatUseCase get deleteOpenChat =>
      DeleteOpenChatUseCase(_repository);

  @injectable
  GetOpenChatStreamUseCase get openChatStream =>
      GetOpenChatStreamUseCase(_repository);

  @injectable
  ModifyOpenChatUseCase get modifyOpenChat =>
      ModifyOpenChatUseCase(_repository);
}
