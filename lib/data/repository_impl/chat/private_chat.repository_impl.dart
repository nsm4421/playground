part of '../export.repository_impl.dart';

@LazySingleton(as: PrivateChatRepository)
class PrivateChatRepositoryImpl
    with LoggerUtil
    implements PrivateChatRepository {
  final PrivateChatRemoteDataSource _chatRemoteDataSource;
  final SocketRemoteDataSource _socketRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  late StreamController<PrivateChatMessageEntity>
      _messageController; // 메세지 수신할 controller

  PrivateChatRepositoryImpl(
      {required PrivateChatRemoteDataSource chatRemoteDataSource,
      required SocketRemoteDataSource socketRemoteDataSource,
      required AuthLocalDataSource authLocalDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource,
        _socketRemoteDataSource = socketRemoteDataSource,
        _authLocalDataSource = authLocalDataSource {
    _messageController = StreamController<PrivateChatMessageEntity>.broadcast();
  }

  @override
  void init() {
    // 소켓이 초기화 되지 않은 경우 초기화
    if (!_socketRemoteDataSource.initialized) {
      _socketRemoteDataSource.init(_authLocalDataSource.token!);
    }
    // 이벤트 수신 이벤트 추가
    _socketRemoteDataSource
      // 새로운 메시지가 도착한 경우
      ..onEvent(
          event: EventNames.receivePrivateChatMessage,
          callback: (json) {
            _messageController.add(PrivateChatMessageEntity.from(
                PrivateChatMessageDto.fromJson(json)));
          })
      // 메세지가 삭제된 경우
      ..onEvent(
          event: EventNames.deletePrivateChatMessage,
          callback: (json) {
            _messageController.add(PrivateChatMessageEntity.from(
                PrivateChatMessageDto.fromJson(json)));
          });
  }

  @override
  String? get clientId => _socketRemoteDataSource.socket.id;

  @override
  Future<Either<ErrorResponse, SuccessResponse<List<PrivateChatMessageEntity>>>>
      fetchLatestMessages(String currentUid) async {
    try {
      return await _chatRemoteDataSource
          .fetchLatestMessages()
          .then((res) => res.map((dto) => PrivateChatMessageEntity.from(dto)))
          .then((res) => SuccessResponse(payload: res.toList()))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<
      Either<ErrorResponse,
          SuccessResponse<Pageable<PrivateChatMessageEntity>>>> fetchMessages({
    required int lastMessageId,
    required String opponentUid,
    required int page,
    int pageSize = 20,
  }) async {
    try {
      return await _chatRemoteDataSource
          .fetchMessages(
              lastMessageId: lastMessageId,
              opponentUid: opponentUid,
              page: page,
              pageSize: page)
          .then((res) => res
              .convert<PrivateChatMessageEntity>(PrivateChatMessageEntity.from))
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Stream<PrivateChatMessageEntity> get messageStream =>
      _messageController.stream;

  @override
  Either<ErrorResponse, SuccessResponse<void>> createMessage(
      {required String content, required String receiverId}) {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.sendPrivateChatMessage, json: {
        'content': content,
        'receiverId': receiverId,
      });
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteMessage(
      String messageId) async {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.sendPrivateChatMessage, json: {
        'messageId': messageId,
      });
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
