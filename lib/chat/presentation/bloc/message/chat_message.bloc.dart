import 'dart:developer';

import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/chat/constant/chat_type.dart';
import 'package:flutter_app/chat/domain/entity/chat_message.entity.dart';
import 'package:flutter_app/chat/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';
import '../../../domain/entity/chat.entity.dart';

part 'chat_message.state.dart';

part 'chat_message.event.dart';

@injectable
class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatEntity _chat;
  final PresenceEntity _currentUser;
  final ChatUseCase _useCase;

  ChatEntity get chat => _chat;

  PresenceEntity get currentUser => _currentUser;

  PresenceEntity get opponent => _chat.opponent!;

  ChatMessageBloc(@factoryParam this._chat, @factoryParam this._currentUser,
      {required ChatUseCase useCase})
      : _useCase = useCase,
        super(ChatMessageState()) {
    on<FetchChatMessagesEvent>(_onFetch);
    on<DeleteChatMessageEvent>(_onDelete);
    on<SeeChatMessageEvent>(_onSeeMessage);
    on<OnNewMessageEvent>(_onNewMessageEvent);
    on<OnMessageDeletedEvent>(_onMessageDeletedEvent);
  }

  DateTime get beforeAt => state.messages.isEmpty
      ? DateTime.now().toUtc()
      : state.messages
          .map((item) => item.createdAt!)
          .reduce((r, l) => r.isBefore(l) ? r : l);

  Future<void> _onFetch(
      FetchChatMessagesEvent event, Emitter<ChatMessageState> emit) async {
    try {
      log('[ChatMessageBloc]_onFetch실행');
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchChatMessages(
              chatId: _chat.id!, beforeAt: beforeAt, take: event.take)
          .then((res) {
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              messages: [...state.messages, ...res.data!],
              isEnd: res.data!.length < event.take));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onDelete(
      DeleteChatMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      log('[ChatMessageBloc]_onDelete실행');
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.deleteChatMessage(event.messageId);
      if (!res.ok) {
        emit(state.copyWith(status: Status.error, errorMessage: res.message));
      }
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onSeeMessage(
      SeeChatMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      log('[ChatMessageBloc]_onRead실행');
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.seeChatMessage(event.messageId);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(status: Status.initial));
      }
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onNewMessageEvent(
      OnNewMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      log('[ChatMessageBloc]_onNewMessageEvent실행');
      final isSender = _currentUser.uid == event.senderUid;
      final newMessage = ChatMessageEntity(
        id: event.messageId,
        chatId: _chat.id!,
        content: event.content,
        type: event.type,
        isSeen: true,
        createdAt: event.createdAt,
        sender: isSender ? _currentUser : opponent,
        receiver: isSender ? opponent : _currentUser,
      );
      emit(state.copyWith(messages: [...state.messages, newMessage]));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onMessageDeletedEvent(
      OnMessageDeletedEvent event, Emitter<ChatMessageState> emit) async {
    try {
      emit(state.copyWith(
          messages: state.messages
              .map((item) => item.id == event.messageId
                  ? item.copyWith(content: '삭제된 메세지 입니다', isDeleted: true)
                  : item)
              .toList()));
    } catch (error) {
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }
}
