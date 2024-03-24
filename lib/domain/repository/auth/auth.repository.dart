import 'package:fpdart/fpdart.dart';
import '../../../core/error/failure.constant.dart';
import '../../../data/entity/user/user.entity.dart';

abstract class AuthRepository {
  /// 이메일, 비밀번호로 회원가입
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String nickname,
  });

  /// 이메일, 비밀번호로 로그인
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
