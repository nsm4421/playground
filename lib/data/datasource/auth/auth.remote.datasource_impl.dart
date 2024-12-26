part of '../export.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final Logger _logger;

  AuthRemoteDataSourceImpl({required Dio dio, required Logger logger})
      : _dio = dio,
        _logger = logger;

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    // sign in request
    final res = await _dio.post(
      ApiEndPoint.signIn,
      data: {"email": email, "password": password},
    );

    // parse jwt from cookie
    final cookies = res.headers.map['set-cookie'];
    if (cookies == null) {
      throw CustomException(
          code: StatusCode.invalidCrendential, message: 'cookie not found');
    }
    final token =
        cookies.firstWhere((item) => item.startsWith("jwt="), orElse: () => '');
    if (token.isEmpty) {
      throw CustomException(
          code: StatusCode.invalidCrendential,
          message: 'jwt not found in cookie');
    }

    final payload = SignInSuccessResDto.fromJson(res.data).payload;
    return UserModel.from(dto: payload, token: token);
  }

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String username}) async {
    await _dio.post(ApiEndPoint.signUp, data: {
      "email": email,
      "password": password,
      "username": username
    }).then((res) {
      _logger.d(res.data);
    });
  }
}
