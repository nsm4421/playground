import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/presentation/bloc/bottom_nav/cubit.dart';
import 'package:travel/presentation/bloc/module.dart';

part 'f_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().homeBottomNav,
      child: Scaffold(
        body: _navigationShell,
        bottomNavigationBar: BottomNavigationFragment(_navigationShell),
      ),
    );
  }
}
