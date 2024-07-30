import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio/features/chat/domain/entity/private_chat_message.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../main/core/constant/status.dart';
import '../../../../domain/usecase/chat.usecase_module.dart';
import '../../chat.bloc_module.dart';

part "display_private_chat.state.dart";

part "display_private_chat.event.dart";

class DisplayPrivateChatBloc
    extends Bloc<DisplayPrivateChatEvent, DisplayPrivateChatState> {
  final ChatUseCase _useCase;

  DisplayPrivateChatBloc(this._useCase)
      : super(DisplayPrivateChatState()) {
    on<FetchPrivateChatEvent>(_onFetch);
    on<AwareNewPrivateChatEvent>(_onNewMessage);
    on<AwarePrivateChatDeletedEvent>(_onDeletedMessage);
  }

  RealtimeChannel getConversationChannel({
    required void Function(PrivateChatMessageEntity entity) onInsert,
    required void Function(PrivateChatMessageEntity entity) onDelete,
  }) =>
      _useCase.lastChatChannel(onInsert: onInsert, onDelete: onDelete);

  // 최신 메세지 가져오기
  Future<void> _onFetch(
      FetchPrivateChatEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res =
          await _useCase.fetchLatestChatMessages(DateTime.now().toUtc());
      if (res.ok) {
        emit(state.copyWith(
            status: Status.success,
            lastMessages: event.isAppend
                ? [...state.lastMessages, ...(res.data ?? [])]
                : (res.data ?? [])));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  // 새로운 메세지가 도착한 경우
  Future<void> _onNewMessage(
      AwareNewPrivateChatEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          lastMessages: state.lastMessages
              .map(
                  (e) => (e.chatId == event.message.chatId) ? event.message : e)
              .toList()));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  // 메세지가 삭제된 경우 -> 메세지 본문 변경
  Future<void> _onDeletedMessage(AwarePrivateChatDeletedEvent event,
      Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          lastMessages: state.lastMessages
              .map((e) => (e.id == event.message.id)
                  ? event.message
                      .copyWith(content: "Removed Message", isRemoved: true)
                  : e)
              .toList()));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
