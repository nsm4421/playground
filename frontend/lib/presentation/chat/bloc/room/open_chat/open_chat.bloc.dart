import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/usecase/chat/room/open_chat.usecase.dart';

part 'open_chat.state.dart';

part 'open_chat.event.dart';

class OpenChatBloc extends Bloc<OpenChatEvent, OpenChatState> {
  final OpenChatUseCase _useCase;

  OpenChatBloc({required OpenChatUseCase useCase})
      : _useCase = useCase,
        super(InitialOpenChatState()) {
    on<InitOpenChatEvent>(_onInit);
    on<GetOpenChatStreamEvent>(_onGetStream);
    on<CreateOpenChatEvent>(_onCreate);
  }

  late Stream<List<OpenChatEntity>> _chatStream;

  Stream<List<OpenChatEntity>> get chatStream => _chatStream;

  Future<void> _onInit(
      InitOpenChatEvent event, Emitter<OpenChatState> emit) async {
    emit(InitialOpenChatState());
  }

  Future<void> _onGetStream(
      GetOpenChatStreamEvent event, Emitter<OpenChatState> emit) async {
    try {
      _chatStream = _useCase.chatStream.call();
    } catch (err) {
      debugPrint(err.toString());
      emit(OpenChatFailureState('채팅방 목록 가져오는데 실패하였습니다'));
    }
  }

  Future<void> _onCreate(
      CreateOpenChatEvent event, Emitter<OpenChatState> emit) async {
    try {
      emit(OpenChatLoadingState());
      await _useCase.createChat
          .call(
              title: event.title,
              hashtags: event.hashtags,
              currentUser: event.currentUser,
              createdAt: DateTime.now())
          .then((res) => res.fold(
              (l) =>
                  emit(OpenChatFailureState(l.message ?? '알수 없는 오류가 발생했습니다')),
              (r) => emit(OpenChatSuccessState())));
    } catch (err) {
      debugPrint(err.toString());
      emit(OpenChatFailureState('알수 없는 오류가 발생했습니다'));
    }
  }
}
