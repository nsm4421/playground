part of 'export.datasource.dart';

@module
abstract class DataSource with LoggerUtil {
  final _storage = const FlutterSecureStorage();

  final _dio = Dio(BaseOptions(
      baseUrl: ApiEndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));

  @lazySingleton
  AuthLocalDataSource get authLocal =>
      AuthLocalDataSourceImpl(storage: _storage, logger: logger);

  @lazySingleton
  AuthRemoteDataSource get authRemote =>
      AuthRemoteDataSourceImpl(dio: _dio, logger: logger);

  @lazySingleton
  FeedRemoteDataSource get feedRemote =>
      FeedRemoteDataSourceImpl(dio: _dio, logger: logger);
}
