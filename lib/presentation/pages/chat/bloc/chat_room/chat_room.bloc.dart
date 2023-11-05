import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';
import 'package:my_app/domain/usecase/chat/chat_room/create_chat_room.usecase.dart';
import 'package:my_app/domain/usecase/chat/chat_room/get_chat_rooms.usecase.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.event.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.state.dart';

import '../../../../../core/constant/enums/status.enum.dart';
import '../../../../../core/utils/exception/custom_exception.dart';
import '../../../../../domain/model/result/result.dart';
import '../../../../../domain/usecase/chat/chat.usecase.dart';

@injectable
class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatUseCase _chatUseCase;

  ChatRoomBloc(this._chatUseCase) : super(const ChatRoomState()) {
    on<ChatRoomInitializedEvent>(_onChatRoomInitialized);
    on<ChatRoomCreateEvent>(_onChatRoomCreated);
  }

  Future<Result<List<ChatRoomModel>>> _getChatRooms() async =>
      await _chatUseCase.execute(useCase: GetChatRoomsUseCase());

  Future<void> _onChatRoomInitialized(
      ChatRoomInitializedEvent event, Emitter<ChatRoomState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _getChatRooms();
      response.when(success: (chatRooms) {
        emit(state.copyWith(status: Status.success, chatRooms: chatRooms));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(err)));
    }
  }

  Future<void> _onChatRoomCreated(
      ChatRoomCreateEvent event, Emitter<ChatRoomState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final response = await _chatUseCase.execute(
          useCase: CreateChatRoomUseCase(
              chatRoomName: event.chatRoomName, hashtags: event.hashtags));
      response.when(success: (chatRoomId) {
        emit(state.copyWith(status: Status.success));
      }, failure: (err) {
        emit(state.copyWith(status: Status.error, error: err));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(err)));
    }
  }
}
