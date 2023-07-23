import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // BottomNavController Instance를 앱이 종료될 때까지 binding 시켜줌
    Get.put(BottomNavController(), permanent: true);
  }
}
