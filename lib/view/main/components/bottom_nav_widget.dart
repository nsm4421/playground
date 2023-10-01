import '../cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
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
    );
  }
}
