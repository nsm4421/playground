part of '../export.bloc.dart';

@injectable
class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState>
    with LoggerUtil {
  final GroupChatUseCase _useCase;
  final String _chatId;

  late Stream<GroupChatMessageEntity> _messageStream;
  late String _clientId;

  Stream<GroupChatMessageEntity> get messageStream => _messageStream;

  String get clientId => _clientId;

  GroupChatBloc(@factoryParam this._chatId, {required GroupChatUseCase useCase})
      : _useCase = useCase,
        super(GroupChatState()) {
    _messageStream =
        _useCase.messageStream.where((item) => item.chatId == _chatId);
    on<InitGroupChatEvent>(_onInit);
    on<JoinGroupChatEvent>(_onJoin);
    on<SendMessageEvent>(_sendMessage);
    _clientId = _useCase.clientId!;
  }

  Future<void> _onInit(
      InitGroupChatEvent event, Emitter<GroupChatState> emit) async {
    emit(
        state.copyWith(status: event.status, errorMessage: event.errorMessage));
  }

  Future<void> _onJoin(
      JoinGroupChatEvent event, Emitter<GroupChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      _useCase.join(_chatId).fold(
          (l) => emit(
              state.copyWith(status: Status.error, errorMessage: l.message)),
          (r) =>
              emit(state.copyWith(status: Status.success, errorMessage: '')));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, errorMessage: 'join fails'));
    }
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<GroupChatState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      _useCase.sendMessage.call(chatId: _chatId, content: event.content).fold(
          (l) => emit(
              state.copyWith(status: Status.error, errorMessage: l.message)),
          (r) =>
              emit(state.copyWith(status: Status.success, errorMessage: '')));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: 'send message fails'));
    }
  }
}
