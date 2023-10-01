import 'home_app_bar_widget.dart';

import '../cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'default_app_bar_widget.dart';

class TopAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBarWidget({super.key});

  static const double _preferredSize = 45;


  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (BuildContext context, BottomNavState state) =>
            (state == BottomNavState.home)
                ? HomeAppBarWidget()
                : DefaultAppBarWidget(label: state.label.toUpperCase()),
      );

  @override
  Size get preferredSize => Size.fromHeight(_preferredSize);
}
