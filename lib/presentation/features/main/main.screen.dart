import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/features/chat/chat.screen.dart';
import 'package:my_app/presentation/features/home/bloc/swipe/swipe.event.dart';
import 'package:my_app/presentation/features/match/match.screen.dart';
import 'package:my_app/presentation/features/setting/setting.screen.dart';

import '../../../core/constant/bottom_navigation.enum.dart';
import '../home/bloc/swipe/swipe.bloc.dart';
import '../home/home.screen.dart';
import 'bottom_navigation.widget.dart';
import 'cubit/bottom_navigation.cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),
          BlocProvider<SwipeBloc>(
              create: (_) => SwipeBloc()..add(SwipeInitEvent()))
        ],
        child: const _MainScreenView(),
      );
}

class _MainScreenView extends StatelessWidget {
  const _MainScreenView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<BottomNavCubit, BottomNavigation>(
          builder: (BuildContext _, BottomNavigation state) {
            switch (state) {
              case BottomNavigation.home:
                return const HomeScreen();
              case BottomNavigation.match:
                return const MatchScreen();
              case BottomNavigation.chat:
                return const ChatScreen();
              case BottomNavigation.setting:
                return const SettingScreen();
            }
          },
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      );
}
