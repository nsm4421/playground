import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/constant/status.dart';
import '../../../../../domain/entity/chat/private_chat_message.entity.dart';
import '../../../../../domain/usecase/chat/chat.usecase_module.dart';
import '../../chat.bloc_module.dart';

part "private_chat_room.state.dart";

part "private_chat_room.event.dart";

class PrivateChatRoomBloc
    extends Bloc<PrivateChatRoomEvent, PrivateChatRoomState> {
  final ChatUseCase _useCase;
  final String _chatId;

  String get chatId => _chatId;

  PrivateChatRoomBloc(this._useCase, {@factoryParam required String chatId})
      : _chatId = chatId,
        super(PrivateChatRoomState(chatId, beforeAt: DateTime.now().toUtc())) {
    on<InitPrivateChatRoomEvent>(_onInit);
    on<SendPrivateChatMessageEvent>(_onSend);
    on<DeletePrivateChatMessageEvent>(_onDelete);
    on<AwareNewPrivateChatMessageEvent>(_onNewMessage);
    on<AwarePrivateChatMessageDeletedEvent>(_onDeletedMessage);
    on<FetchPrivateChatMessageEvent>(_onFetch);
  }

  RealtimeChannel getPrivateChatMessageChannel({
    required void Function(PrivateChatMessageEntity entity) onInsert,
    required void Function(PrivateChatMessageEntity entity) onDelete,
  }) =>
      _useCase.conversationChannel(
          chatId: _chatId, onInsert: onInsert, onDelete: onDelete);

  Future<void> _onInit(
      InitPrivateChatRoomEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          status: event.status, message: event.message ?? state.message));
    } catch (error) {
      log("getPrivateChatMessageChannel ${error.toString()}");
      emit(state.copyWith(
          status: Status.error, message: event.message ?? state.message));
    }
  }

  Future<void> _onSend(
      SendPrivateChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.sendPrivateChatMessage
          .call(receiver: event.receiver, content: event.content);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log("_onSend ${error.toString()}");
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onDelete(
      DeletePrivateChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.deletePrivateChatMessage.call(event.messageId);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.error, message: res.message));
      }
    } catch (error) {
      log("_onDelete ${error.toString()}");
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onNewMessage(
      AwareNewPrivateChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(chatMessages: [
        event.message,
        ...state.chatMessages,
      ]));
    } catch (error) {
      log("_onNewMessage ${error.toString()}");
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onDeletedMessage(AwarePrivateChatMessageDeletedEvent event,
      Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          chatMessages: state.chatMessages
              .map((e) => (e.id == event.message.id)
                  ? e.copyWith(content: "Removed Message", isRemoved: true)
                  : e)
              .toList()));
    } catch (error) {
      log("_onDeletedMessage ${error.toString()}");
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }

  Future<void> _onFetch(
      FetchPrivateChatMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final res = await _useCase.fetchPrivateChatMessages(
          chatId: _chatId, beforeAt: state.beforeAt, take: event.take);
      if (res.ok) {
        final data = res.data ?? [];
        final beforeAt = data.isEmpty
            ? DateTime.now().toUtc()
            : data
                .reduce((r, l) => r.createdAt!.isBefore(l.createdAt!) ? r : l)
                .createdAt;
        emit(state.copyWith(
            beforeAt: beforeAt,
            isEnd: data.length < event.take,
            chatMessages: [...data.reversed, ...state.chatMessages]));
      } else {
        emit(state.copyWith(status: Status.error));
      }
    } catch (error) {
      log("_onFetch ${error.toString()}");
      emit(state.copyWith(status: Status.error, message: 'error occurs'));
    }
  }
}
