import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Stream<AuthState> get authStream;

  UserModel getCurrentUserOrElseThrow();

  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname,
      required String profileUrl});

  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  @Deprecated('Supabase 콘솔에서 회원가입을 트리거로 회원정보 적재하는 함수 구현해서 필요하지 않음')
  Future<void> insertUser(UserModel user);

  Future<void> modifyUser(UserModel user);
}
