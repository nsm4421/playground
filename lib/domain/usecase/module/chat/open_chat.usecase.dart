import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/data/repository_impl/chat/open_chat/open_chat.reopsitory_impl.dart';
import '../../../../core/exception/failure.dart';

part '../../case/chat/open_chat/create_open_chat.usecase.dart';

part '../../case/chat/open_chat/get_open_chat_stream.usecase.dart';

part '../../case/chat/open_chat/delete_open_chat.usecase.dart';

part '../../case/chat/open_chat/modify_open_chat.usecase.dart';

@lazySingleton
class OpenChatUseCase {
  final OpenChatRepository _repository;

  OpenChatUseCase(this._repository);

  CreateOpenChatUseCase get createChat => CreateOpenChatUseCase(_repository);

  ModifyOpenChatUseCase get modifyChat => ModifyOpenChatUseCase(_repository);

  GetOpenChatStreamUseCase get chatStream =>
      GetOpenChatStreamUseCase(_repository);

  DeleteOpenChatUseCase get delete => DeleteOpenChatUseCase(_repository);
}
