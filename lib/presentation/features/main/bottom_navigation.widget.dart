import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/bottom_navigation.enum.dart';
import 'cubit/bottom_navigation.cubit.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BottomNavCubit, BottomNavigation>(
        builder: (BuildContext context, BottomNavigation state) =>
            BottomNavigationBar(
          elevation: 0,
          items: BottomNavigation.values.map((e) => e.toWidget()).toList(),
          onTap: (index) => context.read<BottomNavCubit>().handleIndex(index),
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      );
}
