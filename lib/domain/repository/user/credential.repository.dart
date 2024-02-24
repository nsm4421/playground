import 'package:firebase_auth/firebase_auth.dart';

abstract class CredentialRepository {
  // 인증 상태
  bool get isAuthenticated;

  // 현재 로그인한 유저 id
  String? get currentUid;

  Stream<User?> get currentUserStream;

  // 로그아웃
  Future<void> signOut();

  // 구글계정으로 회원가입
  Future<UserCredential> googleSignIn();
}
