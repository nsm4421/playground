import 'package:fast_app_base/screen/notification/s_notification.dart';
import 'package:flutter/material.dart';

import '../../../../common/common.dart';

class AppBarWidget extends StatefulWidget {
  static const double appBarHeight = 60;
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _showRedDot = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBarWidget.appBarHeight,
      color: context.appColors.appBarBackground,
      child: Row(
        children: [
          const Width(10),
          Image.asset("$basePath/icon/toss.png", height: 30),
          const Expanded(child: SizedBox()),
          Image.asset("$basePath/icon/map_point.png", height: 30),
          const Width(10),
          // Tab을 누르면 redDot을 보여주지 않음
          Tap(
            onTap: () {
              Nav.push(const NotificationScreen());
            },
            child: Stack(
              children: [
                Image.asset("$basePath/icon/notification.png", height: 30),
                // showRedDot이 true면, 상단에 빨간 점 보여줌
                if (_showRedDot)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
