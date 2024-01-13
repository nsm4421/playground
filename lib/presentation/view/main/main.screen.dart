import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/view/main/bloc/bottom_nav.cubit.dart';
import 'package:my_app/presentation/view/main/chat/chat.screen.dart';
import 'package:my_app/presentation/view/main/group/group.screen.dart';
import 'package:my_app/presentation/view/main/home/home.screen.dart';
import 'package:my_app/presentation/view/main/search/search.screen.dart';
import 'package:my_app/presentation/view/main/profile/profile.screen.dart';

import '../../../core/enums/bottom_nav.enum.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<BottomNavCubit>(
        create: (_) => BottomNavCubit(),
        child:
            const Scaffold(body: _Body(), bottomNavigationBar: _BottomNavBar()),
      );
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BottomNavCubit, BottomNav>(builder: (_, state) {
        switch (state) {
          case BottomNav.home:
            return const HomeScreen();
          case BottomNav.search:
            return const SearchScreen();
          case BottomNav.group:
            return const GroupScreen();
          case BottomNav.chat:
            return const ChatScreen();
          case BottomNav.profile:
            return const ProfileScreen();
        }
      });
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BottomNavCubit, BottomNav>(
      builder: (_, state) => BottomNavigationBar(
            items: List.generate(
              BottomNav.values.length,
              (index) => BottomNavigationBarItem(
                  icon: BottomNav.values[index].icon(),
                  label: BottomNav.values[index].label(),
                  activeIcon: BottomNav.values[index].activeIcon()),
            ),
            onTap: (index) =>
                context.read<BottomNavCubit>().changeNavIndex(index),
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
          ));
}
