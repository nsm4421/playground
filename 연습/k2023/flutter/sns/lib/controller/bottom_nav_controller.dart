import 'package:flutter/cupertino.dart';
import 'package:flutter_sns/screen/upload/s_upload.dart';
import 'package:get/get.dart';

enum NavItem { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  RxInt navIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigatorKey =
      GlobalKey<NavigatorState>();
  List<int> history = [0];

  void handleNav(int idx) {
    // 현재 탭과 같은 버튼 누른 경우 pass
    if (idx == navIndex.value) return;
    switch (NavItem.values[idx]) {
      // 업로드 버튼을 누른 경우 → 업로드 페이지로 이동
      case NavItem.UPLOAD:
        Get.to(() => const UploadScreen());
        break;
      // 그 외 → History 저장, Index 변경
      case NavItem.HOME:
      case NavItem.SEARCH:
      case NavItem.ACTIVITY:
      case NavItem.MYPAGE:
        history.add(idx);
        navIndex(idx);
    }
  }

  // true 반환 시, 앱 종료
  Future<bool> handleWillPop() async {
    if (history.length == 1) return true;
    // 검색화면에서 중첩 라우팅 처리
    if (NavItem.values[history.last] == NavItem.SEARCH) {
      if (await searchPageNavigatorKey.currentState?.maybePop() == true) {
        return false;
      }
    }
    history.removeLast();
    navIndex(history.last);
    return false;
  }
}
