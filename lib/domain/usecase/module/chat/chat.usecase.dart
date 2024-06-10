import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/entity/chat/base/chat.entity.dart';
import '../../../../data/repository_impl/chat/chat.repository_impl.dart';

part '../../case/chat/get_chat_stream.usecase.dart';

part '../../case/chat/delete_chat.usecase.dart';

@lazySingleton
class ChatUseCase {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  @injectable
  GetChatStreamUseCase get chatStream => GetChatStreamUseCase(_repository);

  @injectable
  DeleteChatUseCase get deleteChat => DeleteChatUseCase(_repository);
}
