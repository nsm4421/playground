import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/all/f_all.dart';
import 'package:fast_app_base/screen/main/tab/favorite/f_favorite.dart';
import 'package:fast_app_base/screen/main/tab/home/f_home.dart';
import 'package:fast_app_base/screen/main/tab/pay/f_pay.dart';
import 'package:flutter/material.dart';

import 'benefit/f_benefit.dart';

enum TabItem {
  home(Icons.home, '홈', HomeFragment()),
  benefit(Icons.star, '혜택', BenefitFragment()),
  favorite(Icons.payment, '즐겨찾기', FavoriteFragment(isShowBackButton: false)),
  payment(Icons.payment, '페이', PayFragment()),
  stock(Icons.candlestick_chart, '주식', HomeFragment()),
  all(Icons.menu, '전체', AllFragment());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage,
      {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated
              ? context.appColors.iconButton
              : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
