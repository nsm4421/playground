import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/auth/remote_data_source.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/auth/auth.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final RemoteAuthDataSource _remoteAuthDataSource;

  AuthRepositoryImpl(RemoteAuthDataSource authDataSource)
      : _remoteAuthDataSource = authDataSource;

  @override
  Stream<AuthState> get authStream => _remoteAuthDataSource.authStream;

  @override
  Either<Failure, UserEntity> getCurrentUserOrElseThrow() {
    try {
      final user = _remoteAuthDataSource.getCurrentUserOrElseThrow();
      return right(UserEntity.fromModel(user));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _remoteAuthDataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .then((model) => UserEntity.fromModel(model));
      return right(user);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname,
      required String profileUrl}) async {
    try {
      // 회원 추가
      final user = await _remoteAuthDataSource.signUpWithEmailAndPassword(
          email: email,
          password: password,
          nickname: nickname,
          profileUrl: profileUrl);
      return right(UserEntity.fromModel(user));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteAuthDataSource.signOut();
      return right(null);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
