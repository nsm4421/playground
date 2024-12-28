part of '../export.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final Logger _logger;

  AuthRemoteDataSourceImpl({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger;

  @override
  Future<String> signIn(
      {required String username, required String password}) async {
    final res = await _dio.post(
      ApiEndPoint.signIn,
      data: {"username": username, "password": password},
    ).then((res) => SignInSuccessResDto.fromJson(res.data));
    _logger.d(res.message);
    return res.payload.access_token;
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String nickname,
  }) async {
    await _dio.post(ApiEndPoint.signUp, data: {
      "email": email,
      "password": password,
      "username": username,
      "nickname": nickname,
    }).then((res) {
      _logger.d(res.data);
    });
  }

  @override
  Future<UserModel> getUser(String accessToken) async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioError e, handler) {
        _dio.options.headers['Authorization'] = '';
        return handler.next(e);
      },
    ));
    return await _dio
        .get(ApiEndPoint.getUser)
        .then((res) => GetUserDto.fromJson(res.data).payload);
  }
}
