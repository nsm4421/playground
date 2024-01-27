import 'package:injectable/injectable.dart';
import 'package:my_app/core/enums/response_status.enum.dart';
import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/data/data_source/base/rest.api.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data_source/base/auth.api.dart';
import '../../data_source/base/storage.api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;
  final RestApi _restApi;
  final StorageApi _storageApi;

  AuthRepositoryImpl(
      {required AuthApi authApi,
      required RestApi restApi,
      required StorageApi storageApi})
      : _authApi = authApi,
        _restApi = restApi,
        _storageApi = storageApi;

  @override
  User? get currentUser => _authApi.currentUser;

  @override
  String? get currentUid => currentUser?.id;

  @override
  Stream<User?> get authStream => _authApi.authStream;

  @override
  Future<void> signOut() => _authApi.signOut();

  /// 이메일, 비밀번호 로그인
  @override
  Future<ResponseWrapper<void>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // 로그인 처리
      final user = await _authApi
          .signInWithEmailAndPassword(email: email, password: password)
          .then((res) => res.user);
      if (user == null) throw Exception('NOT_LOGIN');

      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  /// 이메일, 비밀번호 회원가입
  @override
  Future<ResponseWrapper<void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // 회원가입 처리
      final user = await _authApi
          .signUpWithEmailAndPassword(email: email, password: password)
          .then((res) => res.user);

      // 유저정보 업로드
      await _restApi.insertUser(UserDto(uid: user!.id, email: email));

      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }
}
