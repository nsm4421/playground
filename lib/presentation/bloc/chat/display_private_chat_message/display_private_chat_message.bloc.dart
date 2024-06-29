import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';

import '../../../../core/constant/error_code.dart';
import '../../../../core/exception/custom_exception.dart';
import '../../../../domain/usecase/module/chat/private_chat_message.usecase.dart';

part 'display_private_chat_message.event.dart';

part 'display_private_chat_message.state.dart';

class DisplayPrivateChatMessageBloc extends Bloc<DisplayPrivateChatMessageEvent,
    DisplayPrivateChatMessageState> {
  final PrivateChatMessageUseCase _useCase;

  DisplayPrivateChatMessageBloc(this._useCase)
      : super(InitialPrivateChatMessageState()) {
    on<InitPrivateChatMessageEvent>(_onInit);
  }

  List<PrivateChatMessageEntity> _latestMessages = [];

  List<PrivateChatMessageEntity> get latestMessages => _latestMessages;

  Future<void> _onInit(InitPrivateChatMessageEvent event,
      Emitter<DisplayPrivateChatMessageState> emit) async {
    try {
      emit(PrivateChatMessageLoadingState());
      await _useCase.fetchLatest().then((res) => res.fold(
              // 실패시
              (l) => throw CustomException(
                  errorCode: ErrorCode.databaseError,
                  message: '로컬 DB에서 메세지 가져오기 실패'),
              // 성공시
              (r) {
            _latestMessages = r;
            emit(PrivateChatMessageSuccessState());
          }));
    } catch (error) {
      log(error.toString());
      emit(PrivateChatMessageFailureState(
          (error is CustomException) ? error.message : '알 수 없는 오류 발생'));
    }
  }
}
