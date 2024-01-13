import 'package:injectable/injectable.dart';
import 'package:my_app/core/enums/response_status.enum.dart';
import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/data/dto/auth/user/user_metadata.dto.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data_source/base/auth.api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  User? getCurrentUer() => _authApi.getCurrentUer();

  @override
  Stream<User?> getCurrentUserStream() => _authApi.getCurrentUserStream();

  @override
  Future<void> signOut() => _authApi.signOut();

  @override
  Future<ResponseWrapper<void>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _authApi.signInWithEmailAndPassword(
          email: email, password: password);
      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  @override
  Future<ResponseWrapper<void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      // sign up
      final user = await _authApi
          .signUpWithEmailAndPassword(email: email, password: password)
          .then((res) => res.user);
      if (user?.id == null) throw Exception('uid is null');

      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }

  @override
  Future<ResponseWrapper<void>> updateMetaData(UserMetaDataDto metaData) async {
    try {
      await _authApi.updateMetaData(metaData);
      return const ResponseWrapper<void>(status: ResponseStatus.success);
    } catch (err) {
      return ResponseWrapper<void>(
          status: ResponseStatus.error, message: err.toString());
    }
  }
}
