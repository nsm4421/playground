import 'package:hot_place/domain/repository/chat/message/private_chat_message.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import 'case/delete_chat_message.usecase.dart';
import 'case/get_message_stream.usecase.dart';
import 'case/get_messages_from_local.usecase.dart';
import 'case/save_chat_messages_in_local.usecase.dart';
import 'case/send_private_chat_message.usecase.dart';

@lazySingleton
class PrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  PrivateChatMessageUseCase(this._repository);

  @injectable
  SendPrivateChatMessageUseCase get sendChatMessage =>
      SendPrivateChatMessageUseCase(_repository);

  @injectable
  GetMessageStreamUseCase<PrivateChatMessageRepository,
          PrivateChatMessageEntity>
      get getChatMessageStream => GetMessageStreamUseCase<
          PrivateChatMessageRepository, PrivateChatMessageEntity>(_repository);

  @injectable
  DeleteChatMessageUseCase<PrivateChatMessageRepository,
          PrivateChatMessageEntity>
      get deleteChatMessage => DeleteChatMessageUseCase<
          PrivateChatMessageRepository, PrivateChatMessageEntity>(_repository);

  @injectable
  SaveChatMessagesInLocal<PrivateChatMessageRepository,
          PrivateChatMessageEntity>
      get saveMessagesInLocal => SaveChatMessagesInLocal<
          PrivateChatMessageRepository, PrivateChatMessageEntity>(_repository);

  @injectable
  GetMessagesFromLocal<PrivateChatMessageRepository, PrivateChatMessageEntity>
      get getLocalChatMessages => GetMessagesFromLocal<
          PrivateChatMessageRepository, PrivateChatMessageEntity>(_repository);
}
