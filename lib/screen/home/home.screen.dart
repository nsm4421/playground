import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/home/search/search.screen.dart';
import 'cubit/bottom_navigation.cubit.dart';
import 'favorite/favorite.screen.dart';
import 'feed/feed.screen.dart';
import 'post/post.screen.dart';
import 'profile/pofile.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => BottomNavigationCubit(),
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
              case BottomNavigationItem.favorite:
                return const FavoriteScreen();
              case BottomNavigationItem.profile:
                return const ProfileScreen();
            }
          }),
          bottomNavigationBar:
              BlocBuilder<BottomNavigationCubit, BottomNavigationItem>(
            builder: (BuildContext context, state) => BottomNavigationBar(
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<BottomNavigationCubit>().handleIndex(index),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: BottomNavigationItem.values
                  .map((e) => BottomNavigationBarItem(
                        icon: e.icon,
                        activeIcon: e.activeIcon,
                        label: e.label,
                        tooltip: e.label,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}
