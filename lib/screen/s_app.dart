import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:flutter_sns/screen/home/s_home.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';
import 'package:get/get.dart';

import 'search/s_search.dart';

class AppScreen extends GetView<BottomNavController> {
  const AppScreen({super.key});

  static const double _ICON_SIZE = 30;

  BottomNavigationBarItem _bottomNavItem(
      {required String iconImagePath,
      String? activeIconImagePath,
      String? label}) {
    return BottomNavigationBarItem(
        icon: ImageIconWidget(
          size: _ICON_SIZE,
          imagePath: iconImagePath,
        ),
        activeIcon: ImageIconWidget(
          size: _ICON_SIZE,
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
                children: const [
                  HomeScreen(),
                  SearchScreen(),
                  Text("Upload"),
                  Text("Activity"),
                  Text("MyPage"),
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
                        icon: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: const SizedBox(),
                        ),
                        label: "Avatar"),
                  ]),
            )));
  }
}
