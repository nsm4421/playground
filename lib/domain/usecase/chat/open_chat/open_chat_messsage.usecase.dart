import 'package:hot_place/domain/repository/chat/message/open_chat_message.repository.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/delete_chat_message.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/get_local_chat_messages.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/get_message_stream.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/save_chat_messages_in_local.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/send_chat_message.usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  ChatMessageUseCase(this._repository);

  @injectable
  SendChatMessageUseCase get sendChatMessage =>
      SendChatMessageUseCase(_repository);

  @injectable
  GetMessageStreamUseCase get getChatMessageStream =>
      GetMessageStreamUseCase(_repository);

  @injectable
  DeleteChatMessageUseCase get deleteChatMessage =>
      DeleteChatMessageUseCase(_repository);

  @injectable
  SaveChatMessagesInLocal get saveMessagesInLocal =>
      SaveChatMessagesInLocal(_repository);

  @injectable
  GetLocalChatMessagesUseCase get getLocalChatMessages =>
      GetLocalChatMessagesUseCase(_repository);
}
