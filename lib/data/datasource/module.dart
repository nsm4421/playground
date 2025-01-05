part of 'export.datasource.dart';

@module
abstract class DataSource with LoggerUtil {
  final _storage = const FlutterSecureStorage();

  final _dio = Dio(BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));

  final _socket = io(ApiEndPoint.socketUrl,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build())
    ..connect();

  @lazySingleton
  AuthLocalDataSource get authLocal => AuthLocalDataSourceImpl();

  @lazySingleton
  AuthRemoteDataSource get authRemote =>
      AuthRemoteDataSourceImpl(dio: _dio, logger: logger);

  @lazySingleton
  FeedRemoteDataSource get feedRemote =>
      FeedRemoteDataSourceImpl(dio: _dio, logger: logger);

  @lazySingleton
  ChatRemoteDataSource get chatRemote =>
      ChatRemoteDataSourceImpl(dio: _dio, logger: logger);

  @lazySingleton
  SocketRemoteDataSource get socketRemote =>
      SocketRemoteDataSourceImpl(socket: _socket, logger: logger);

  @lazySingleton
  StorageLocalDataSource get storageLocal =>
      StorageLocalDataSourceImpl(storage: _storage, logger: logger);
}
