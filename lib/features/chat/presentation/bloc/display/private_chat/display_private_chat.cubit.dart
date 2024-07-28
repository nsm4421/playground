import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main/core/constant/status.dart';
import '../../../../domain/entity/private_chat_message.entity.dart';
import '../../../../domain/usecase/chat.usecase_module.dart';
import '../../chat.bloc_module.dart';

part "display_private_chat.state.dart";

class DisplayPrivateChatCubit extends Cubit<DisplayPrivateChatState> {
  DisplayPrivateChatCubit(this._useCase) : super(DisplayPrivateChatState());

  final ChatUseCase _useCase;

  Future<void> initStatus({Status status = Status.initial}) async {
    emit(state.copyWith(status: status));
  }

  Future<void> onNewMessage(PrivateChatMessageEntity newMessage) async {
    List<PrivateChatMessageEntity> messages = [...state.chatMessages];
    final isNew = messages.map((e) => e.id).contains(newMessage.id);
    emit(state.copyWith(
        chatMessages: isNew
            ? [newMessage, ...messages]
            : messages
                .map((e) => e.id == newMessage.id ? newMessage : e)
                .toList()));
  }

  Future<void> onDeleteMessage(PrivateChatMessageEntity deleted) async {
    List<PrivateChatMessageEntity> messages = [...state.chatMessages];
    emit(state.copyWith(
        chatMessages: messages
            .map((e) => e.id == deleted.id
                ? deleted.copyWith(content: 'deleted message')
                : e)
            .toList()));
  }

  Future<void> fetchMessages(DateTime? beforeAt) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase
          .fetchLatestChatMessages(beforeAt ?? DateTime.now().toUtc());
      if (res.ok) {
        emit(state.copyWith(status: Status.success, chatMessages: res.data));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: 'fetching latest message fails'));
    }
  }
}
