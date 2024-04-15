import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecase/chat/message/chat_messsage.usecase.dart';

part 'chat_message.event.dart';

part 'chat_message.state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final String _chatId;
  final ChatMessageUseCase _useCase;

  ChatMessageBloc(
      {@factoryParam required String chatId,
      required ChatMessageUseCase useCase})
      : _chatId = chatId,
        _useCase = useCase,
        super(InitialChatMessageState()) {
    on<InitChatMessageEvent>(_onInit);
    on<SendChatMessageEvent>(_onSendMessage);
    on<DeleteChatMessageEvent>(_onDeleteMessage);
  }

  Stream<List<ChatMessageEntity>> get messageStream =>
      _useCase.getChatMessageStream(_chatId);

  Future<void> _onInit(
      InitChatMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      emit(InitialChatMessageState());
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('Error...'));
    }
  }

  Future<void> _onSendMessage(
      SendChatMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      emit(ChatMessageLoadingState());
      final res = await _useCase.sendChatMessage(
          chatId: event.chatId,
          content: event.content,
          currentUser: event.currentUser);
      res.fold((l) => emit(ChatMessageFailureState(l.message ?? '메세지 전송 실패')),
          (r) => emit(ChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('메세지 전송 실패'));
    }
  }

  Future<void> _onDeleteMessage(
      DeleteChatMessageEvent event, Emitter<ChatMessageState> emit) async {
    try {
      emit(ChatMessageLoadingState());
      final res = await _useCase.deleteChatMessage(event.messageId);
      res.fold(
          (l) => emit(
              ChatMessageFailureState(l.message ?? l.message ?? '메세지 삭제 실패')),
          (r) => emit(ChatMessageSuccessState()));
    } catch (err) {
      debugPrint(err.toString());
      emit(ChatMessageFailureState('메세지 삭제 실패'));
    }
  }
}
