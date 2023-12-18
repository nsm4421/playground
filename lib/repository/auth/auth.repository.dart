import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';
import '../../domain/model/user/user.model.dart';

abstract class AuthRepository extends Repository {
  String? get currentUid;

  Future<Response<UserModel?>> getCurrentUser();

  Future<void> signOut();

  Future<Response<void>> signInWithEmailAndPassword(
      String email, String password);

  Future<Response<UserCredential>> createUserWithEmailAndPassword(
      String email, String password);

  Future<Response<void>> saveUser(
      {required String uid, required String email, required String nickname});
}
