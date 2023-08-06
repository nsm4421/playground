import 'package:flutter_sns/c_auth.dart';
import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
