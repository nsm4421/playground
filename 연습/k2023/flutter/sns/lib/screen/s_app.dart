import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/controller/auth_controller.dart';
import 'package:flutter_sns/screen/active/s_active.dart';
import 'package:flutter_sns/controller/bottom_nav_controller.dart';
import 'package:flutter_sns/screen/home/s_home.dart';
import 'package:flutter_sns/screen/mypage/s_my_page.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';
import 'package:get/get.dart';

import 'search/s_search.dart';

class AppScreen extends GetView<BottomNavController> {
  const AppScreen({super.key});

  BottomNavigationBarItem _bottomNavItem(
      {required String iconImagePath,
      String? activeIconImagePath,
      String? label}) {
    return BottomNavigationBarItem(
        icon: ImageIconWidget(
          size: CommonSize.iconSizeLg,
          imagePath: iconImagePath,
        ),
        activeIcon: ImageIconWidget(
          size: CommonSize.iconSizeLg,
          imagePath: activeIconImagePath ?? iconImagePath,
        ),
        label: label);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.handleWillPop,
        child: Obx(() => Scaffold(
              /// body
              body: IndexedStack(
                index: controller.navIndex.value,
                // TODO : Replace by fragments
                children: [
                  HomeScreen(),
                  // 중첩 라우팅을 위해 global key 생성
                  Navigator(
                    key: controller.searchPageNavigatorKey,
                    onGenerateRoute: (routeSetting) {
                      return MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      );
                    },
                  ),
                  Text("Upload"),
                  ActiveScreen(),
                  MyPageScreen(),
                ],
              ),

              /// bottom navigation
              bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: controller.navIndex.value,
                  elevation: 0,
                  onTap: controller.handleNav,
                  items: [
                    // Home Icon
                    _bottomNavItem(
                        iconImagePath: ImagePath.homeOff,
                        activeIconImagePath: ImagePath.homeOn,
                        label: "Home"),
                    // Search Icon
                    _bottomNavItem(
                        iconImagePath: ImagePath.searchOff,
                        activeIconImagePath: ImagePath.searchOn,
                        label: "Search"),
                    // Upload Icon
                    _bottomNavItem(
                        iconImagePath: ImagePath.uploadIcon, label: "Search"),
                    // Activity Icon
                    _bottomNavItem(
                        iconImagePath: ImagePath.activeOff,
                        activeIconImagePath: ImagePath.activeOn,
                        label: "Search"),
                    // Avatar
                    BottomNavigationBarItem(
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            width: CommonSize.iconSizeLg + 5,
                            height: CommonSize.iconSizeLg + 5,
                            child: (AuthController.to.user.value.thumbnail ==
                                        null) |
                                    (AuthController
                                            .to.user.value.thumbnail?.isEmpty ??
                                        true)
                                ? Image.asset(
                                    ImagePath.defaultProfile,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        AuthController.to.user.value.thumbnail!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        label: "Avatar"),
                  ]),
            )));
  }
}
