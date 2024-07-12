import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/chat/page/base/chat.screen.dart';
import 'package:hot_place/presentation/feed/page/feed.screen.dart';
import 'package:hot_place/presentation/home/page/home.screen.dart';
import 'package:hot_place/presentation/main/cubit/bottom_nav.cubit.dart';
import 'package:hot_place/presentation/notification/page/notification.screen.dart';
import 'package:hot_place/presentation/setting/page/setting.screen.dart';

import '../cubit/bottom_nav.dart';

class OnLogInScreen extends StatelessWidget {
  const OnLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => BottomNavCubit(),
        child: Scaffold(
          body: BlocBuilder<BottomNavCubit, BottomNav>(
            builder: (context, state) {
              return Scaffold(
                body: _Body(state),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: context.read<BottomNavCubit>().handleSelect,
                  currentIndex: state.index,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedFontSize: 23,
                  unselectedFontSize: 18,
                  selectedIconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.primary),
                  unselectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                  items: BottomNav.values
                      .map((e) => BottomNavigationBarItem(
                          icon: Icon(e.icon),
                          activeIcon: Icon(e.activeIcon),
                          label: e.label))
                      .toList(),
                ),
              );
            },
          ),
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body(this.bottomNav, {super.key});

  final BottomNav bottomNav;

  @override
  Widget build(BuildContext context) {
    switch (bottomNav) {
      case BottomNav.home:
        return const HomeScreen();
      case BottomNav.feed:
        return const FeedScreen();
      case BottomNav.chat:
        return const ChatScreen();
      case BottomNav.notification:
        return const NotificationScreen();
      case BottomNav.setting:
        return const SettingScreen();
    }
  }
}
