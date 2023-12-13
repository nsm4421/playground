import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';

abstract class AuthRepository extends Repository {
  Future<Response<void>> signInWithEmailAndPassword(
      String email, String password);

  Future<Response<UserCredential>> createUserWithEmailAndPassword(
      String email, String password);

  Future<Response<void>> saveUser(
      {required String uid, required String email, required String nickname});
}
