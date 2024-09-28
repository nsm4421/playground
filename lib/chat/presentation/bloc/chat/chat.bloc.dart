import 'dart:developer';

import 'package:flutter_app/chat/domain/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/shared.export.dart';
import '../../../domain/entity/chat.entity.dart';

part 'chat.state.dart';

part 'chat.event.dart';

@lazySingleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase _useCase;

  ChatBloc(this._useCase) : super(ChatState()) {
    on<FetchChatsEvent>(_onFetch);
    on<DeleteChatEvent>(_onDelete);
    on<OnNewMessageEvent>(_onNewMessage);
    on<OnMessageDeletedEvent>(_onMessageDeleted);
  }

  DateTime get beforeAt => state.chats.isEmpty
      ? DateTime.now().toUtc()
      : state.chats
          .map((item) => item.lastMessageCreatedAt!)
          .reduce((r, l) => r.isBefore(l) ? r : l);

  Future<ChatEntity?> findChatByUid(String opponentUid) async {
    final res = await _useCase.getChatByUid(opponentUid);
    return res.ok ? res.data! : null;
  }

  Future<void> _onFetch(FetchChatsEvent event, Emitter<ChatState> emit) async {
    try {
      log('[ChatBloc]_onFetch실행');
      if (state.isEnd) return;
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchChats(beforeAt: beforeAt, take: event.take)
          .then((res) {
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              chats: [...state.chats, ...res.data!],
              isEnd: res.data!.length < event.take));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      log('[ChatBloc]채팅방 목록 가져오는 중 오류 발생 ${error.toString()}');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onDelete(DeleteChatEvent event, Emitter<ChatState> emit) async {
    try {
      log('[ChatBloc]_onDelete실행');
      emit(state.copyWith(status: Status.loading));
      await _useCase.deleteChat(event.chatId).then((res) {
        if (res.ok) {
          emit(state.copyWith(
              status: Status.success,
              chats: state.chats
                  .where((item) => item.id != event.chatId)
                  .toList()));
        } else {
          emit(state.copyWith(status: Status.error, errorMessage: res.message));
        }
      });
    } catch (error) {
      log('[ChatBloc]채팅방 삭제 중 오류 발생 ${error.toString()}');
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onNewMessage(
      OnNewMessageEvent event, Emitter<ChatState> emit) async {
    try {
      log('[ChatBloc]_onNewMessage실행');
      emit(state.copyWith(status: Status.loading));
      // 채팅방 정보
      ChatEntity? chatToUpdate =
          state.chats.where((item) => item.id == event.chatId).firstOrNull;
      if (chatToUpdate == null) {
        final findChatRes = await _useCase.findChatById(event.chatId);
        if (!findChatRes.ok) throw Exception(findChatRes.message);
        chatToUpdate = findChatRes.data!;
      }
      // 채팅방 목록 변수 업데이트
      emit(state.copyWith(status: Status.success, chats: [
        chatToUpdate,
        ...state.chats.where((item) => item.id != event.chatId)
      ]));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }

  Future<void> _onMessageDeleted(
      OnMessageDeletedEvent event, Emitter<ChatState> emit) async {
    try {
      log('[ChatBloc]_onMessageDeleted실행');
      emit(state.copyWith(status: Status.loading));
      emit(state.copyWith(
          status: Status.success,
          chats: [...state.chats]
              .map((chat) => (chat.id == event.chatId &&
                      chat.lastMessageId == event.messageId)
                  ? chat.copyWith(lastMessageContent: '삭제된 메세지 입니다')
                  : chat)
              .toList()));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error,
          errorMessage:
              error is CustomException ? error.message : '알수 없는 오류가 발생하였습니다'));
    }
  }
}
