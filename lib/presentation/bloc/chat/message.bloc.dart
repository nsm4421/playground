import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/chat.entity.dart';

import '../../../data/entity/chat/chat_message.entity.dart';
import '../../../domain/usecase/module/chat/chat.usecase.dart';

part 'message.event.dart';

part 'message.state.dart';

@injectable
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatEntity _chat;
  final ChatUseCase _chatUseCase;

  Stream<List<ChatMessageEntity>> get messageStream =>
      _chatUseCase.messageStream.call(_chat.id!);

  MessageBloc(@factoryParam this._chat, {required ChatUseCase chatUseCase})
      : _chatUseCase = chatUseCase,
        super(InitialMessageState()) {
    on<SendMessageEvent>(_onSend);
    on<DeleteChatEvent>(_onDeleteChat);
    on<DeleteMessageEvent>(_onDeleteMessage);
  }

  Future<void> _onSend(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoadingState());
      await _chatUseCase.sendChatMessage(event._message).then((res) => res.fold(
          (l) => emit(MessageFailureState(l.message ?? '메세지 보내기 실패')),
          (_) => emit(MessageSuccessState())));
    } catch (err) {
      log(err.toString());
      emit(MessageFailureState('메세지 보내기 실패'));
    }
  }

  Future<void> _onDeleteChat(
      DeleteChatEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoadingState());
      await _chatUseCase.deleteChat(event._chat).then((res) => res.fold(
          (l) => emit(MessageFailureState(l.message ?? '채팅방 폭파 실패')),
          (_) => emit(MessageSuccessState())));
    } catch (err) {
      log(err.toString());
      emit(MessageFailureState('채팅방 폭파 실패'));
    }
  }

  Future<void> _onDeleteMessage(
      DeleteMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoadingState());
      await _chatUseCase.deleteChatMessage(event._message).then((res) =>
          res.fold((l) => emit(MessageFailureState(l.message ?? '메세지 삭제하기 실패')),
              (_) => emit(MessageSuccessState())));
    } catch (err) {
      log(err.toString());
      emit(MessageFailureState('메세지 삭제하기 실패'));
    }
  }
}
