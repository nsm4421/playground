import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/chat.constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/domain/entity/chat/private_chat.dart';
import 'package:travel/domain/entity/chat/private_message.dart';
import 'package:travel/domain/repository/repository.dart';
import 'package:uuid/uuid.dart';

part 'get_chat.dart';

part 'send_message.dart';

part 'fetch.dart';

part 'update.dart';

part 'delete.dart';

@lazySingleton
class PrivateChatUseCase {
  final PrivateChatRepository _chatRepository;
  final PrivateMessageRepository _messageRepository;

  PrivateChatUseCase(
      {required PrivateChatRepository chatRepository,
      required PrivateMessageRepository messageRepository})
      : _chatRepository = chatRepository,
        _messageRepository = messageRepository;

  @lazySingleton
  GetChatUseCase get getChat => GetChatUseCase(_chatRepository);

  @lazySingleton
  SendMessageUseCase get sendMessage => SendMessageUseCase(
      chatRepository: _chatRepository, messageRepository: _messageRepository);

  @lazySingleton
  FetchMessagesUseCase get fetchMessages =>
      FetchMessagesUseCase(_messageRepository);

  @lazySingleton
  UpdateLastSeenUseCase get updateLastSeen =>
      UpdateLastSeenUseCase(_chatRepository);

  @lazySingleton
  DeleteChatUseCase get deleteChat => DeleteChatUseCase(_chatRepository);

  @lazySingleton
  DeleteMessageUseCase get deleteMessage =>
      DeleteMessageUseCase(_messageRepository);
}
