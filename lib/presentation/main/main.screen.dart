import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/main/cubit/bottom_nav.cubit.dart';
import 'package:my_app/presentation/pages/chat/chat.screen.dart';
import 'package:my_app/presentation/pages/feed/home.screen.dart';
import 'package:my_app/presentation/pages/home/home.screen.dart';
import 'package:my_app/presentation/pages/user/user.screen.dart';

import '../../core/constant/enums/bottom_nav.enum.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => BottomNavCubit(),
        child: Scaffold(
          body: BlocBuilder<BottomNavCubit, BottomNav>(
              builder: (BuildContext context, state) {
            switch (state) {
              case BottomNav.home:
                return const HomeScreen();
              case BottomNav.feed:
                return const FeedScreen();
              case BottomNav.chat:
                return const ChatScreen();
              case BottomNav.user:
                return const UserScreen();
            }
          }),
          bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNav>(
            builder: (BuildContext context, state) => BottomNavigationBar(
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<BottomNavCubit>().handleIndex(index),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: BottomNav.values
                  .map((e) => BottomNavigationBarItem(
                      icon: e.icon, activeIcon: e.activeIcon, label: e.label))
                  .toList(),
            ),
          ),
        ),
      );
}
