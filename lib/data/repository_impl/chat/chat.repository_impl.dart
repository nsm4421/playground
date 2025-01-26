part of '../export.repository_impl.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl with LoggerUtil implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;
  final SocketRemoteDataSource _socketRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  late StreamController<MessageEntity> _messageController; // 메세지 수신할 controller

  ChatRepositoryImpl(
      {required ChatRemoteDataSource chatRemoteDataSource,
      required SocketRemoteDataSource socketRemoteDataSource,
      required AuthLocalDataSource authLocalDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource,
        _socketRemoteDataSource = socketRemoteDataSource,
        _authLocalDataSource = authLocalDataSource {
    _messageController = StreamController<MessageEntity>.broadcast();
    _socketRemoteDataSource.onEvent(
        event: EventNames.receiveMessage,
        callback: (json) {
          _messageController.add(MessageEntity.from(MessageDto.fromJson(json)));
        });
  }

  @override
  String? get clientId => _socketRemoteDataSource.socket.id;

  @override
  Future<Either<ErrorResponse, SuccessResponse<Pageable<GroupChatEntity>>>>
      fetch({required int page, int pageSize = 20}) async {
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
  Stream<MessageEntity> get messageStream => _messageController.stream;

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required String title, required List<String> hashtags}) async {
    try {
      return await _chatRemoteDataSource
          .create(title: title, hashtags: hashtags)
          .then((data) => SuccessResponse(payload: null))
          .then(Right.new);
      ;
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Either<ErrorResponse, SuccessResponse<void>> joinChat(String chatId) {
    try {
      _socketRemoteDataSource
          .emit(event: EventNames.joinChat, json: {'chatId': chatId});
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Either<ErrorResponse, SuccessResponse<void>> sendMessage(
      {required String chatId,
      required String content,
      required String currentUid}) {
    try {
      _socketRemoteDataSource.emit(event: EventNames.sendMessage, json: {
        'chatId': chatId,
        'content': content,
        'token': _authLocalDataSource.token
      });
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
