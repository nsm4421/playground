import 'package:flutter_sns/controller/auth_controller.dart';
import 'package:flutter_sns/controller/bottom_nav_controller.dart';
import 'package:flutter_sns/controller/my_page_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
  static additionalBinding(){
    Get.put(MyPageController(), permanent: true);
  }
}
