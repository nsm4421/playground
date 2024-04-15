import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/auth/auth.repository.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(
      {required String email, required String password}) async {
    return await _repository.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
