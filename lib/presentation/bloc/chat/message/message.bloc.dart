import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/chat/base/chat.entity.dart';

import '../../../../data/entity/chat/message/chat_message.entity.dart';
import '../../../../domain/usecase/module/chat/chat.usecase.dart';
import '../../../../domain/usecase/module/chat/chat_message.usecase.dart';

part 'message.event.dart';

part 'message.state.dart';

@injectable
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatEntity _chat;
  final ChatMessageUseCase _useCase;

  Stream<List<ChatMessageEntity>> get messageStream =>
      _useCase.messageStream.call(_chat.id!);

  MessageBloc(@factoryParam this._chat, {required ChatMessageUseCase useCase})
      : _useCase = useCase,
        super(InitialMessageState()) {
    on<SendMessageEvent>(_onSend);
    on<DeleteChatEvent>(_onDeleteChat);
    on<DeleteMessageEvent>(_onDeleteMessage);
  }

  Future<void> _onSend(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoadingState());
      await _useCase.sendChatMessage(event._message).then((res) => res.fold(
          (l) => emit(MessageFailureState(l.message ?? '메세지 보내기 실패')),
          (_) => emit(MessageSuccessState())));
    } catch (err) {
      log(err.toString());
      emit(MessageFailureState('메세지 보내기 실패'));
    }
  }

  Future<void> _onDeleteChat(
          DeleteChatEvent event, Emitter<MessageState> emit) async =>
      throw UnimplementedError();

  Future<void> _onDeleteMessage(
      DeleteMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessageLoadingState());
      await _useCase.deleteChatMessage(event._message).then((res) => res.fold(
          (l) => emit(MessageFailureState(l.message ?? '메세지 삭제하기 실패')),
          (_) => emit(MessageSuccessState())));
    } catch (err) {
      log(err.toString());
      emit(MessageFailureState('메세지 삭제하기 실패'));
    }
  }
}
