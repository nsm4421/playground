import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/auth/auth.repository.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(
      {required String email,
      required String password,
      required String nickname,
      required String profileUrl}) async {
    return await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        nickname: nickname,
        profileUrl: profileUrl);
  }
}
