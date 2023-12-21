import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';
import '../../domain/model/user/user.model.dart';

abstract class AuthRepository extends Repository {
  String? get currentUid;

  Future<Response<UserModel?>> getCurrentUser();

  Future<void> signOut();

  Future<Response<void>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Response<UserCredential>> createUserWithEmailAndPassword(
      {required String email, required String password});

  Future<Response<void>> saveUser(
      {required String uid, required String email, required String nickname});

  Future<Response<void>> updateProfile(
      {required String nickname, required List<Asset> assets});
}
