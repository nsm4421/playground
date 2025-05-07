import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/home/search/search.screen.dart';
import 'cubit/bottom_navigation.cubit.dart';
import 'chat/chat.screen.dart';
import 'feed/feed.screen.dart';
import 'post/post.screen.dart';
import 'profile/profile.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider<BottomNavigationCubit>(
      create: (_) => BottomNavigationCubit(),
      child: SafeArea(
          child: Scaffold(
              body: BlocBuilder<BottomNavigationCubit, BottomNavigationItem>(
                  builder: (BuildContext context, state) {
                switch (state) {
                  case BottomNavigationItem.feed:
                    return const FeedScreen();
                  case BottomNavigationItem.search:
                    return const SearchScreen();
                  case BottomNavigationItem.post:
                    return const PostScreen();
                  case BottomNavigationItem.chat:
                    return const ChatScreen();
                  case BottomNavigationItem.profile:
                    return const ProfileScreen();
                }
              }),
              bottomNavigationBar:
                  BlocBuilder<BottomNavigationCubit, BottomNavigationItem>(
                      builder: (BuildContext context, state) =>
                          BottomNavigationBar(
                              currentIndex: state.index,
                              onTap: (index) => context
                                  .read<BottomNavigationCubit>()
                                  .handleIndex(index),
                              showSelectedLabels: false,
                              showUnselectedLabels: false,
                              type: BottomNavigationBarType.fixed,
                              items: BottomNavigationItem.values
                                  .map(
                                    (e) => BottomNavigationBarItem(
                                      icon: e.icon,
                                      activeIcon: e.activeIcon,
                                      label: e.label,
                                      tooltip: e.label,
                                    ),
                                  )
                                  .toList())))));
}
