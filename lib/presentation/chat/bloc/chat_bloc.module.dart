import 'package:hot_place/domain/usecase/chat/open_chat/open_chat_messsage.usecase.dart';
import 'package:hot_place/presentation/chat/bloc/open_chat/open_chat_message.bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/di/dependency_injection.dart';

@lazySingleton
class ChatBlocModule {
  @injectable
  OpenChatMessageBloc openChatMessageBloc(@factoryParam String chatId) =>
      OpenChatMessageBloc(chatId: chatId, useCase: getIt<ChatMessageUseCase>());
}
