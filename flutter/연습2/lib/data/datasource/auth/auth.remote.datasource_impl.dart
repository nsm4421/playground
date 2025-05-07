part of '../export.datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final Logger _logger;
  final bool _showLog;

  AuthRemoteDataSourceImpl(
      {required Dio dio, required Logger logger, required bool showLog})
      : _dio = dio,
        _logger = logger,
        _showLog = showLog;

  String get _endPointPrefix => ApiEndPoint.auth;

  @override
  Future<String> signIn(
      {required String username, required String password}) async {
    if (_showLog) _logger.t('signIn|username:$username');
    return await _dio
        .post('$_endPointPrefix/sign-in',
            data: {"username": username, "password": password})
        .then((res) => SignInSuccessResDto.fromJson(res.data))
        .then((dto) => dto.payload.access_token)
        .then((data) {
          if (_showLog) _logger.t(data);
          return data;
        });
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String nickname,
    required File profileImage,
  }) async {
    if (_showLog) {
      _logger.t('signUp|email:$email/username:$username/nickname:$nickname');
    }
    return await _dio
        .post('$_endPointPrefix/sign-up',
            data: SignUpReqDto(
              email: email,
              password: password,
              username: username,
              nickname: nickname,
            ).toFormData(await MultipartFile.fromFile(profileImage.path)))
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }

  @override
  Future<UserModel> getUser(String accessToken) async {
    if (_showLog) _logger.t('getUser');
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
        .get(_endPointPrefix)
        .then((res) => GetUserDto.fromJson(res.data).payload)
        .then((data) {
      if (_showLog) _logger.t(data);
      return data;
    });
  }

  @override
  Future<void> editProfile(
      {required String nickname, File? profileImage}) async {
    if (_showLog) _logger.t('editProfile|nickname:$nickname');
    await _dio
        .post('$_endPointPrefix/edit-profile',
            data: FormData.fromMap({
              if (profileImage != null)
                'file': await MultipartFile.fromFile(profileImage.path),
              'nickname': nickname
            }))
        .then((res) => res.data)
        .then((data) {
      if (_showLog) _logger.t(data);
    });
  }
}
