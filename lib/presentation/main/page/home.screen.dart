import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/chat/page/chat.fragment.dart';
import 'package:hot_place/presentation/home/page/home.fragment.dart';
import 'package:hot_place/presentation/map/map.fragment.dart';
import 'package:hot_place/presentation/setting/page/setting.fragment.dart';

import '../../../core/constant/bottom_nav.constant.dart';
import '../../post/page/post.fragment.dart';
import '../bloc/bottom_nav/bottom_nav.cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BottomNavCubit, BottomNav>(
      builder: (context, state) => Scaffold(
          body: SafeArea(child: _Body(state)),
          bottomNavigationBar: BottomNavigationBar(
              onTap: context.read<BottomNavCubit>().handleIndex,
              currentIndex: context.read<BottomNavCubit>().state.index,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedFontSize: 23,
              unselectedFontSize: 18,
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              selectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              items: BottomNav.values
                  .map((nav) => BottomNavigationBarItem(
                      label: nav.label,
                      tooltip: nav.label,
                      icon: Icon(nav.icon),
                      activeIcon: Icon(nav.activeIcon)))
                  .toList())));
}

class _Body extends StatelessWidget {
  const _Body(this.bottomNav);

  final BottomNav bottomNav;

  @override
  Widget build(BuildContext context) {
    switch (bottomNav) {
      case BottomNav.home:
        return const HomeFragment();
      case BottomNav.feed:
        return const PostFragment();
      case BottomNav.map:
        return const MapFragment();
      case BottomNav.chat:
        return const ChatFragment();
      case BottomNav.setting:
        return const SettingFragment();
    }
  }
}
