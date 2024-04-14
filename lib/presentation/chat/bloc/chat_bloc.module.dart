import 'package:hot_place/presentation/chat/bloc/message/chat_message.bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../domain/usecase/chat/message/create_chat_message.usecase.dart';
import '../../../domain/usecase/chat/message/delete_chat_message.usecase.dart';
import '../../../domain/usecase/chat/message/get_message_stream.usecase.dart';

@lazySingleton
class ChatBlocModule {
  @injectable
  ChatMessageBloc chatMessageBloc(@factoryParam String chatId) =>
      ChatMessageBloc(
          chatId: chatId,
          getMessageStreamUseCase: getIt<GetMessageStreamUseCase>(),
          sendChatMessageUseCase: getIt<SendChatMessageUseCase>(),
          deleteChatMessageUseCase: getIt<DeleteChatMessageUseCase>());
}
