import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/pages/main/chat/entry/chat.page.dart';
import 'package:my_app/presentation/pages/main/home/home.page.dart';
import 'package:my_app/presentation/pages/main/setting/entry/setting.page.dart';

import '../../bloc/bottom_nav/bottm_nav.cubit.dart';
import 'feed/entry/feed.page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BottomNavCubit>(),
        child: BlocBuilder<BottomNavCubit, BottomNav>(
            builder: (BuildContext context, BottomNav state) {
          return Scaffold(
              body: _Body(state),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (int index) {
                  context.read<BottomNavCubit>().handleIndex(index);
                },
                currentIndex: context.read<BottomNavCubit>().state.index,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                items: BottomNav.values
                    .map((e) => BottomNavigationBarItem(
                        label: e.label,
                        icon: Icon(e.iconData),
                        activeIcon: Icon(e.activeIconData)))
                    .toList(),
              ));
        }));
  }
}

class _Body extends StatelessWidget {
  const _Body(this.state, {super.key});

  final BottomNav state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case BottomNav.home:
        return const HomePage();
      case BottomNav.feed:
        return const FeedPage();
      case BottomNav.chat:
        return const ChatPage();
      case BottomNav.setting:
        return const SettingPage();
    }
  }
}
