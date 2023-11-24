import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/domain/repository/repository.dart';

import '../../core/utils/response_wrappper/response_wrapper.dart';

abstract class AuthRepository extends Repository {
  /// 이메일로 유저 조회
  Future<ResponseWrapper<UserModel>> findByEmail(String email);

  /// 구글 계정으로 로그인
  Future<ResponseWrapper<UserCredential>> signInWithGoogle();

  /// 닉네임 중복여부
  Future<bool> checkNicknameDuplicated(String nickname);

  /// on boarding 양식 제출
  Future<ResponseWrapper<void>> submitOnBoardingForm(
      {required String uid,
      required UserModel user,
      required List<Asset> images});
}
