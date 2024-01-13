import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/response/response_wrapper.dart';
import 'package:my_app/domain/model/auth/user_metadata.model.dart';
import 'package:my_app/domain/repository/base.repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository extends Repository {
  Stream<User?> getCurrentUserStream();

  User? getCurrentUer();

  Future<void> signOut();

  Future<ResponseWrapper<void>> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<ResponseWrapper<void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<ResponseWrapper<UserMetaDataModel>> editProfile(
      {required String nickname, XFile? profileImageData});
}
