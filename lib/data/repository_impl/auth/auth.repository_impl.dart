import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:hot_place/domain/repository/auth/auth.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _authDataSource
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
      required String nickname}) async {
    try {
      final user = await _authDataSource
          .signUpWithEmailAndPassword(
              email: email, password: password, nickname: nickname)
          .then((model) => UserEntity.fromModel(model));
      return right(user);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
