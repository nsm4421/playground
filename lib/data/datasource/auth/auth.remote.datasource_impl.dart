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
    return await _dio
        .post(
          ApiEndPoint.signIn,
          data: SignInReqDto(
            email: email,
            password: password,
          ).toJson(),
        )
        .then((res) => SignInSuccessResDto.fromJson(res.data))
        .then((dto) {
      _logger.d(dto);
      return dto.payload;
    });
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
