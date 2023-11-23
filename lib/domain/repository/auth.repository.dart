import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';

abstract class AuthRepository extends Repository {
  Future<ResponseWrapper<UserCredential>> signInWithGoogle();

  Future<bool> checkNicknameDuplicated(String nickname);

  Future<ResponseWrapper<void>> submitOnBoardingForm(
      {required String uid,
      required UserModel user,
      required List<Asset> images});
}
