import 'package:injectable/injectable.dart';
import 'package:my_app/api/auth/auth.api.dart';

import '../../core/response/response.dart';
import 'auth.repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  Future<Response<void>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _authApi.signInWithEmailAndPassword(email, password);
      return const Response<void>(status: Status.success, message: 'login success');
    } catch (err) {
      return Response<void>(status: Status.error, message: err.toString());
    }
  }
}
