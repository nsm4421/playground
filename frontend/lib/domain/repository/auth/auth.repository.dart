import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/error/failure.constant.dart';
import '../../../data/entity/user/user.entity.dart';

abstract class AuthRepository {
  /// 인증상태 stream
  Stream<AuthState> get authStream;

  /// 현재 로그인한 유저
  Either<Failure, UserEntity> getCurrentUserOrElseThrow();

  /// 이메일, 비밀번호로 회원가입
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String nickname,
    required String profileUrl,
  });

  /// 이메일, 비밀번호로 로그인
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// 로그아웃
  Future<Either<Failure, void>> signOut();
}
