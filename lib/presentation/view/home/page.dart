import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';

import '../../../core/constant/constant.dart';
import '../../bloc/bloc_module.dart';
import '../../bloc/bottom_nav/home_bottom_nav.cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<BlocModule>().nav,
        child: BlocBuilder<HomeBottomNavCubit, HomeBottomNavState>(
            builder: (context, state) {
          return Scaffold(
              body: _navigationShell,
              bottomNavigationBar: state.visible
                  ? BottomNavigationBar(
                      elevation: 0,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      unselectedItemColor:
                          Theme.of(context).colorScheme.tertiary,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      currentIndex: _navigationShell.currentIndex,
                      onTap: (int idx) {
                        if (idx != _navigationShell.currentIndex) {
                          _navigationShell.goBranch(
                            idx,
                            initialLocation:
                                idx == _navigationShell.currentIndex,
                          );
                          context.read<HomeBottomNavCubit>().handleChange(idx);
                        }
                      },
                      items: HomeBottomNavItems.values
                          .map((item) => BottomNavigationBarItem(
                              activeIcon: Icon(item.activeIconData, size: 25),
                              icon: Icon(item.iconData, size: 20),
                              label: item.label))
                          .toList())
                  : null);
        }));
  }
}
