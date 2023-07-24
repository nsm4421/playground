import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/c_bottom_nav.dart';
import 'package:flutter_sns/screen/home/s_home.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';
import 'package:get/get.dart';

class AppScreen extends GetView<BottomNavController> {
  const AppScreen({super.key});

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
                  Text("Search"),
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
                    BottomNavigationBarItem(
                        icon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.homeOff,
                        ),
                        activeIcon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.homeOn,
                        ),
                        label: "Home"),
                    // Search Icon
                    BottomNavigationBarItem(
                        icon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.searchOff,
                        ),
                        activeIcon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.searchOn,
                        ),
                        label: "Search"),
                    // Upload Icon
                    BottomNavigationBarItem(
                        icon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.uploadIcon,
                        ),
                        label: "Upload"),
                    // Activity Icon
                    BottomNavigationBarItem(
                        icon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.activeOff,
                        ),
                        activeIcon: ImageIconWidget(
                          size: 30,
                          imagePath: ImagePath.activeOn,
                        ),
                        label: "Activity"),
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
