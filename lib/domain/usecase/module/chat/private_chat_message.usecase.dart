import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:my_app/data/repository_impl/chat/private_chat/private_chat_message_repository_impl.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/exception/failure.dart';

part '../../case/chat/private_chat_message/fetch_latest_messages.usecase.dart';

part '../../case/chat/private_chat_message/fetch_private_chat_messages_by_user.usecase.dart';

part '../../case/chat/private_chat_message/send_private_chat_message.usecase.dart';

part '../../case/chat/private_chat_message/delete_private_chat_message.usecase.dart';

@lazySingleton
class PrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  PrivateChatMessageUseCase(this._repository);

  FetchLatestMessagesUseCase get fetchLatest =>
      FetchLatestMessagesUseCase(_repository);

  FetchPrivateChatMessagesByUserUseCase get fetchByUser =>
      FetchPrivateChatMessagesByUserUseCase(_repository);

  SendPrivateChatMessageUseCase get sendMessage =>
      SendPrivateChatMessageUseCase(_repository);

  DeletePrivateChatMessageUseCase get deleteMessage =>
      DeletePrivateChatMessageUseCase(_repository);
}
