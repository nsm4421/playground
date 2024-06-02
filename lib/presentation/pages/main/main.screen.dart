import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/pages/main/chat/chat.screen.dart';
import 'package:my_app/presentation/pages/main/feed/feed.screen.dart';
import 'package:my_app/presentation/pages/main/home/home.screen.dart';
import 'package:my_app/presentation/pages/main/setting/setting.screen.dart';
import 'package:my_app/presentation/pages/main/short/short.screen.dart';

import '../../bloc/bottom_nav/bottm_nav.cubit.dart';

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
        return const HomeScreen();
      case BottomNav.feed:
        return const FeedScreeen();
      case BottomNav.short:
        return const ShortScreen();
      case BottomNav.chat:
        return const ChatScreen();
      case BottomNav.setting:
        return const SettingScreen();
    }
  }
}
