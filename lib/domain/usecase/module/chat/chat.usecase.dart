import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/chat_message.entity.dart';
import 'package:my_app/domain/repository/chat/chat.repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/entity/chat/chat.entity.dart';

part '../../case/chat/get_chat_stream.usecase.dart';

part '../../case/chat/get_chat_message_stream.usecase.dart';

part '../../case/chat/send_chat_message.usecase.dart';

part '../../case/chat/delete_chat_message.usecase.dart';

part '../../case/chat/delete_chat.usecase.dart';

@lazySingleton
class ChatUseCase {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  @injectable
  GetChatStreamUseCase get chatStream => GetChatStreamUseCase(_repository);

  @injectable
  GetChatMessageStreamUseCase get messageStream =>
      GetChatMessageStreamUseCase(_repository);

  @injectable
  SendChatMessageUseCase get sendChatMessage =>
      SendChatMessageUseCase(_repository);

  @injectable
  DeleteChatUseCase get deleteChat => DeleteChatUseCase(_repository);

  @injectable
  DeleteChatMessageUseCase get deleteChatMessage =>
      DeleteChatMessageUseCase(_repository);
}
