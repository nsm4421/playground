part of '../export.repository_impl.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl with LoggerUtil implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;
  final SocketRemoteDataSource _socketRemoteDataSource;
  late StreamController<MessageEntity> _messageController; // 메세지 수신할 controller

  ChatRepositoryImpl(
      {required ChatRemoteDataSource chatRemoteDataSource,
      required SocketRemoteDataSource socketRemoteDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource,
        _socketRemoteDataSource = socketRemoteDataSource {
    _messageController = StreamController<MessageEntity>.broadcast();
    _socketRemoteDataSource.onEvent(
        event: EventNames.receiveMessage,
        callback: (json) =>
            _messageController.add(MessageEntity.fromJson(json)));
  }

  @override
  Stream<MessageEntity> get messageStream => _messageController.stream;

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required String title, required List<String> hashtags}) async {
    try {
      await _chatRemoteDataSource.create(title: title, hashtags: hashtags);
      return Right(SuccessResponse(payload: null));
    } catch (error) {
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
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Either<ErrorResponse, SuccessResponse<void>> sendMessage(
      {required String chatId, required String message}) {
    try {
      // TODO : 서버에 메세지 내용 저장하기
      _socketRemoteDataSource.emit(
          event: EventNames.sendMessage,
          json: {'chatId': chatId, 'message': message});
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
