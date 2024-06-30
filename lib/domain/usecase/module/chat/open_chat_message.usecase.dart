import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/exception/failure.dart';
import '../../../../data/entity/chat/chat_message/open_chat_message.entity.dart';
import '../../../../data/repository_impl/chat/open_chat/open_chat_message.reopsitory_impl.dart';

part '../../case/chat/open_chat_message/send_open_chat_message.usecase.dart';

part '../../case/chat/open_chat_message/delete_open_chat_message.usecase.dart';

part '../../case/chat/open_chat_message/get_open_chat_message_channel.usecase.dart';

@lazySingleton
class OpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  OpenChatMessageUseCase(this._repository);

  SendOpenChatMessageUseCase get sendMessage =>
      SendOpenChatMessageUseCase(_repository);

  DeleteOpenChatMessageUseCase get deleteMessage =>
      DeleteOpenChatMessageUseCase(_repository);

  GetOpenChatMessageChannelUseCase get getMessageChannel =>
      GetOpenChatMessageChannelUseCase(_repository);
}
