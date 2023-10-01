import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/theme/constant/icon_paths.dart';
import '../pages/category/category_page.dart';
import '../pages/home/home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/user/user_page.dart';
import 'cubit/bottom_nav_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => BottomNavCubit(),
        child: const MainScreenView(),
      );
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
        centerTitle: true,
      ),
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (BuildContext context, BottomNavState state) {
          switch (state) {
            case BottomNavState.home:
              return const HomePage();
            case BottomNavState.category:
              return const CategoryPage();
            case BottomNavState.search:
              return const SearchPage();
            case BottomNavState.user:
              return const UserPage();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (BuildContext context, BottomNavState state) =>
            BottomNavigationBar(
          items: List.generate(
            BottomNavState.values.length,
            (idx) => BottomNavState.values[idx],
          )
              .map((state) => BottomNavigationBarItem(
                    icon: state.icon,
                    label: state.label,
                    activeIcon: state.activeIcon,
                    tooltip: state.label,
                  ))
              .toList(),
          onTap: (index) => context.read<BottomNavCubit>().handleIndex(index),
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
