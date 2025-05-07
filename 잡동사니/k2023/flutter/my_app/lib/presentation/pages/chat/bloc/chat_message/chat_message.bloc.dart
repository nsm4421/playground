import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/usecase/chat/chat_message/get_chat_messages.usecase.dart';
import 'package:my_app/domain/usecase/chat/chat_message/send_chat_message.usecase.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_message/chat_message.state.dart';

import '../../../../../core/constant/enums/status.enum.dart';
import '../../../../../core/utils/exception/custom_exception.dart';
import '../../../../../core/utils/logging/custom_logger.dart';
import '../../../../../domain/model/result/result.dart';
import '../../../../../domain/usecase/chat/chat.usecase.dart';
import 'chat_message.event.dart';

@injectable
class ChatBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatUseCase _chatUseCase;

  ChatBloc(this._chatUseCase) : super(const ChatMessageState()) {
    on<ChatMessageInitializedEvent>(_onChatMessageInitialized);
    on<ChatMessageSentEvent>(_chatMessageSent);
  }

  Future<Result<List<ChatMessageModel>>> _getChatMessages(
          String chatRoomId) async =>
      await _chatUseCase.execute(
          useCase: GetChatMessagesUseCase(chatRoomId: chatRoomId));

  Future<void> _onChatMessageInitialized(
      ChatMessageInitializedEvent event, Emitter<ChatMessageState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _getChatMessages(event.chatRoomId);
      response.when(success: (messages) {
        emit(state.copyWith(status: Status.success, messages: messages));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(err)));
    }
  }

  Future<void> _chatMessageSent(
      ChatMessageSentEvent event, Emitter<ChatMessageState> emit) async {
    try {
      final response = await _chatUseCase.execute(
          useCase: SendChatMessageUseCase(
              chatRoomId: event.chatRoomId, message: event.message));
      response.when(success: (chatMessage) {
        emit(state.copyWith(
            status: Status.success,
            messages: [...state.messages, chatMessage]));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(err)));
    }
  }
}
