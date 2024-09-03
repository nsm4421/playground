part of 'repository_impl.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<User?> signInWithEmailAndPassword(String email, String password);
}
