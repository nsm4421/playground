import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/usecase/chat/delete_message.usecase.dart';
import 'package:hot_place/domain/usecase/chat/find_chat_by_id.usecase.dart';
import 'package:hot_place/domain/usecase/chat/get_message_stream.usecase.dart';
import 'package:hot_place/domain/usecase/chat/seen_message_update.usecase.dart';
import 'package:hot_place/domain/usecase/chat/send_message.usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/constant/response.constant.dart';
import 'chat_room.event.dart';
import 'chat_room.state.dart';

@injectable
class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc({
    required GetChatByIdUseCase getChatByIdUseCase,
    required GetMessageStreamUseCase getMessageStreamUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required SeenMessageUpdateUseCase seenMessageUpdateUseCase,
    required DeleteMessageUseCase deleteMessageUseCase,
  })  : _getChatByIdUseCase = getChatByIdUseCase,
        _getMessageStreamUseCase = getMessageStreamUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        _seenMessageUpdateUseCase = seenMessageUpdateUseCase,
        _deleteMessageUseCase = deleteMessageUseCase,
        super(const ChatRoomState()) {
    on<InitChatRoom>(_onInit);
    on<SendMessage>(_onSend);
  }

  final GetChatByIdUseCase _getChatByIdUseCase;
  final GetMessageStreamUseCase _getMessageStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SeenMessageUpdateUseCase _seenMessageUpdateUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase;
  final _logger = Logger();

  Future<void> _onInit(
    InitChatRoom event,
    Emitter<ChatRoomState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      // 채팅 조회
      (await _getChatByIdUseCase(event.chatId)).when(success: (data) {
        emit(state.copyWith(chatId: data.id!, opponent: data.opponent!));
      }, failure: (code, description) {
        throw Exception('채팅 조회 실패');
      });

      // 메세지 stream 조회
      (await _getMessageStreamUseCase(event.chatId)).when(
          success: (Stream<List<MessageEntity>> data) {
        emit(state.copyWith(
            chatId: event.chatId, stream: data, status: Status.success));
      }, failure: (code, description) {
        throw Exception('메세지 스트림 가져오기 실패');
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSend(
    SendMessage event,
    Emitter<ChatRoomState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      // 전송할 메시지 전송
      (await _sendMessageUseCase(MessageEntity(
              chatId: state.chatId,
              receiver: state.opponent,
              content: event.content,
              messageType: event.type,
              createdAt: DateTime.now())))
          .when(success: (data) {
        emit(state.copyWith(status: Status.success));
      }, failure: (code, description) {
        throw Exception('메세지 전송 실패');
      });
    } catch (err) {
      _logger.e(err);
      emit(state.copyWith(status: Status.error));
    }
  }
}
