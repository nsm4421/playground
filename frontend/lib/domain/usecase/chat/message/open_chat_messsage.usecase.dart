import 'package:hot_place/data/entity/chat/open_chat/message/open_chat_message.entity.dart';
import 'package:hot_place/domain/repository/chat/message/open_chat_message.repository.dart';
import 'package:hot_place/domain/usecase/chat/message/case/save_chat_messages_in_local.usecase.dart';
import 'package:hot_place/domain/usecase/chat/message/case/send_open_chat_message.usecase.dart';
import 'package:injectable/injectable.dart';

import 'case/delete_chat_message.usecase.dart';
import 'case/get_message_stream.usecase.dart';
import 'case/get_messages_from_local.usecase.dart';

@lazySingleton
class OpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  OpenChatMessageUseCase(this._repository);

  @injectable
  SendOpenChatMessageUseCase get sendChatMessage =>
      SendOpenChatMessageUseCase(_repository);

  @injectable
  GetMessageStreamUseCase<OpenChatMessageRepository, OpenChatMessageEntity>
      get getChatMessageStream => GetMessageStreamUseCase<
          OpenChatMessageRepository, OpenChatMessageEntity>(_repository);

  @injectable
  DeleteChatMessageUseCase<OpenChatMessageRepository, OpenChatMessageEntity>
      get deleteChatMessage => DeleteChatMessageUseCase<
          OpenChatMessageRepository, OpenChatMessageEntity>(_repository);

  @injectable
  SaveChatMessagesInLocal<OpenChatMessageRepository, OpenChatMessageEntity>
      get saveMessagesInLocal => SaveChatMessagesInLocal<
          OpenChatMessageRepository, OpenChatMessageEntity>(_repository);

  @injectable
  GetMessagesFromLocal<OpenChatMessageRepository, OpenChatMessageEntity>
      get getLocalChatMessages => GetMessagesFromLocal<
          OpenChatMessageRepository, OpenChatMessageEntity>(_repository);
}
