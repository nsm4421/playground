part of '../export.repository_impl.dart';

@LazySingleton(as: GroupChatRepository)
class GroupChatRepositoryImpl with LoggerUtil implements GroupChatRepository {
  final GroupChatRemoteDataSource _chatRemoteDataSource;
  final SocketRemoteDataSource _socketRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  late StreamController<GroupChatMessageEntity>
      _messageController; // 메세지 수신할 controller

  GroupChatRepositoryImpl(
      {required GroupChatRemoteDataSource chatRemoteDataSource,
      required SocketRemoteDataSource socketRemoteDataSource,
      required AuthLocalDataSource authLocalDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource,
        _socketRemoteDataSource = socketRemoteDataSource,
        _authLocalDataSource = authLocalDataSource {
    _messageController = StreamController<GroupChatMessageEntity>.broadcast();
  }

  @override
  void init() {
    // 소켓이 초기화 되지 않은 경우 초기화
    if (!_socketRemoteDataSource.initialized) {
      _socketRemoteDataSource.init(_authLocalDataSource.token!);
    }
    // 이벤트 수신 이벤트 추가
    _socketRemoteDataSource.onEvent(
        event: EventNames.receiveGroupChatMessage,
        callback: (json) {
          logger.d(json);
          _messageController.add(
              GroupChatMessageEntity.from(GroupChatMessageDto.fromJson(json)));
        });
  }

  @override
  String? get clientId => _socketRemoteDataSource.socket.id;

  @override
  Future<Either<ErrorResponse, SuccessResponse<Pageable<GroupChatEntity>>>>
      fetchChats({required int page, int pageSize = 20}) async {
    try {
      return await _chatRemoteDataSource
          .fetch(page: page, pageSize: pageSize)
          .then((res) => res.convert<GroupChatEntity>(GroupChatEntity.from))
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Stream<GroupChatMessageEntity> get messageStream => _messageController.stream;

  @override
  Either<ErrorResponse, SuccessResponse<void>> joinChat(String chatId) {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.joinGroupChat, json: {'chatId': chatId});
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Either<ErrorResponse, SuccessResponse<void>> leaveChat(String chatId) {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.leaveGroupChat, json: {'chatId': chatId});
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> createChat(
      {required String title, required List<String> hashtags}) async {
    try {
      return await _chatRemoteDataSource
          .create(title: title, hashtags: hashtags)
          .then((data) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Either<ErrorResponse, SuccessResponse<void>> createMessage(
      {required String chatId, required String content}) {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.sendGroupChatMessage, json: {
        'chatId': chatId,
        'content': content,
      });
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteChat(
      String chatId) async {
    try {
      return await _chatRemoteDataSource
          .delete(chatId)
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
