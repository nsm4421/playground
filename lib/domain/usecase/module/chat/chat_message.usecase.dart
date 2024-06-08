import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/entity/chat/message/chat_message.entity.dart';
import '../../../../data/repository_impl/chat/chat_message.repository_impl.dart';

part '../../case/chat/message/get_chat_message_stream.usecase.dart';

part '../../case/chat/message/send_chat_message.usecase.dart';

part '../../case/chat/message/delete_chat_message.usecase.dart';

@lazySingleton
class ChatMessageUseCase {
  final ChatMessageRepository _repository;

  ChatMessageUseCase(this._repository);

  @injectable
  GetChatMessageStreamUseCase get messageStream =>
      GetChatMessageStreamUseCase(_repository);

  @injectable
  SendChatMessageUseCase get sendChatMessage =>
      SendChatMessageUseCase(_repository);

  @injectable
  DeleteChatMessageUseCase get deleteChatMessage =>
      DeleteChatMessageUseCase(_repository);
}
