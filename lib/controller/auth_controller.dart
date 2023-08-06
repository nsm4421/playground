import 'package:flutter_sns/model/user_dto.dart';
import 'package:flutter_sns/repository/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<UserDto> user = UserDto().obs;

  static AuthController get to => Get.find();

  Future<UserDto?> loginUser(String uid) async {
    return await UserRepository.findByUid(uid);
  }

  Future<bool> signUp(UserDto userVo) async {
    if (await UserRepository.signUp(userVo)) {
      user(userVo);
      return true;
    }
    return false;
  }
}
