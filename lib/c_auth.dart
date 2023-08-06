import 'package:flutter_sns/model/vo_user.dart';
import 'package:flutter_sns/repository/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<UserVo> user = UserVo().obs;

  static AuthController get to => Get.find();

  Future<UserVo?> loginUser(String uid) async {
    return await UserRepository.findByUid(uid);
  }

  Future<bool> signUp(UserVo userVo) async {
    if (await UserRepository.signUp(userVo)) {
      user(userVo);
      return true;
    }
    return false;
  }
}
