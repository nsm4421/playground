part of 'datasource_impl.dart';

abstract class AuthDataSource {
  Future<User?> signUpWithEmailAndPassword(String email, String password);
}
