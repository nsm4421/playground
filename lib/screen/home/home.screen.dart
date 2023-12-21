import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/screen/home/bloc/auth.bloc.dart';
import 'package:my_app/screen/home/bloc/auth.event.dart';
import 'package:my_app/screen/home/bloc/auth.state.dart';
import 'package:my_app/screen/home/search/search.screen.dart';
import '../../configurations.dart';
import 'bloc/bottom_navigation.cubit.dart';
import 'favorite/favorite.screen.dart';
import 'feed/feed.screen.dart';
import 'post/post.screen.dart';
import 'profile/profile.screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationCubit>(
              create: (_) => BottomNavigationCubit()),
          BlocProvider<AuthBloc>(
              create: (_) => getIt<AuthBloc>()..add(InitAuthEvent())),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (_, state) {
            switch (state.status) {
              case AuthStatus.initial:
              case AuthStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case AuthStatus.success:
                return const _AuthSuccessScreen();
              case AuthStatus.error:
                return const Text("Auth Error");
            }
          },
        ),
      );
}

class _AuthSuccessScreen extends StatelessWidget {
  const _AuthSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: e.icon,
                    activeIcon: e.activeIcon,
                    label: e.label,
                    tooltip: e.label,
                  ),
                )
                .toList(),
          ),
        ),
      );
}
