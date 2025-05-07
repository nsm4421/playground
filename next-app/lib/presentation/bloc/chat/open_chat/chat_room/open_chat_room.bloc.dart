import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../domain/entity/chat/open_chat_message.entity.dart';
import '../../../../../domain/usecase/chat/chat.usecase_module.dart';
import '../../chat.bloc_module.dart';

part "open_chat_room.state.dart";

part "open_chat_room.event.dart";

class OpenChatRoomBloc extends Bloc<OpenChatRoomEvent, OpenChatRoomState> {
  final ChatUseCase _useCase;
  final String _chatId;

  String get chatId => _chatId;

  OpenChatRoomBloc(this._useCase, {@factoryParam required String chatId})
      : _chatId = chatId,
        super(OpenChatRoomState(chatId)) {
    on<InitOpenChatRoomEvent>(_onInit);
    on<SendOpenChatMessageEvent>(_onSend);
    on<NewOpenChatMessageEvent>(_onNewMessage);
    on<FetchOpenChatMessageEvent>(_onFetch);
  }

  RealtimeChannel getOpenChatMessageChannel(
          void Function(OpenChatMessageEntity entity) onInsert) =>
      _useCase.openChatMessageChannel(chatId: _chatId, onInsert: onInsert);

  Future<void> _onInit(
      InitOpenChatRoomEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          status: event.status, message: event.message ?? state.message));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, message: event.message ?? state.message));
    }
  }

  // 오픈 채팅 메시지 보내기
  Future<void> _onSend(
      SendOpenChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.sendOpenChatMessage
          .call(chatId: _chatId, content: event.content);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  // 새로운 채팅 메시지를 수신한 경우
  Future<void> _onNewMessage(
      NewOpenChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(
          state.copyWith(chatMessages: [...state.chatMessages, event.message]));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onFetch(
      FetchOpenChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      const size = 20;
      final res = await _useCase.fetchOpenChatMessages(
          chatId: _chatId,
          page: event.page,
          beforeAt: state.beforeAt,
          size: size);
      if (res.ok) {
        final data = res.data ?? [];
        emit(state.copyWith(
            isEnd: data.length < size,
            chatMessages: [...(res.data ?? []), ...state.chatMessages]));
      } else {
        emit(state.copyWith(status: Status.error));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
