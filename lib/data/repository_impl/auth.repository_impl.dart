import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/data_source/remote/auth/auth.api.dart';

import '../../core/constant/enums/status.enum.dart';
import '../../core/utils/response_wrappper/response_wrapper.dart';
import '../../domain/repository/auth.repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  Future<ResponseWrapper<UserCredential>> signInWithGoogle() async {
    try {
      final credential = await _authApi.signInWithGoogle();
      return ResponseWrapper<UserCredential>(
          status: ResponseStatus.success, data: credential);
    } catch (err) {
      return const ResponseWrapper<UserCredential>(
          status: ResponseStatus.error);
    }
  }

  @override
  Future<bool> checkNicknameDuplicated(String nickname) async =>
      await _authApi.checkNicknameDuplicated(nickname);
}
