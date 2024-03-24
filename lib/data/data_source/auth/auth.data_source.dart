import 'package:hot_place/domain/model/user/user.model.dart';

abstract class AuthDataSource {
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname});

  Future<String> signInWithEmailAndPassword(
      {required String email, required String password});
}
