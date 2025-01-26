part of 'export.datasource.dart';

@module
abstract class DataSource with LoggerUtil {
  /// instance
  final _storage = const FlutterSecureStorage();

  final _dio = Dio(BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));

  final _socket = io(ApiEndPoint.socketUrl,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build())
    ..connect();

  final _showLog = true; // on debug

  /// auth
  @lazySingleton
  AuthLocalDataSource get authLocal =>
      AuthLocalDataSourceImpl(logger: logger, showLog: _showLog);

  @lazySingleton
  AuthRemoteDataSource get authRemote =>
      AuthRemoteDataSourceImpl(dio: _dio, logger: logger, showLog: _showLog);

  /// feed
  @lazySingleton
  FeedRemoteDataSource get feedRemote =>
      FeedRemoteDataSourceImpl(dio: _dio, logger: logger, showLog: _showLog);

  @lazySingleton
  FeedReactionRemoteDataSource get feedReactionRemote =>
      FeedReactionRemoteDataSourceImpl(
          dio: _dio, logger: logger, showLog: _showLog);

  @lazySingleton
  FeedCommentRemoteDataSource get feedCommentRemote =>
      FeedCommentRemoteDataSourceImpl(
          dio: _dio, logger: logger, showLog: _showLog);

  /// chat
  @lazySingleton
  ChatRemoteDataSource get chatRemote =>
      ChatRemoteDataSourceImpl(dio: _dio, logger: logger, showLog: _showLog);

  /// socket
  @lazySingleton
  SocketRemoteDataSource get socketRemote => SocketRemoteDataSourceImpl(
      socket: _socket, logger: logger, showLog: _showLog);

  /// local storage
  @lazySingleton
  StorageLocalDataSource get storageLocal =>
      StorageLocalDataSourceImpl(storage: _storage, logger: logger);
}
