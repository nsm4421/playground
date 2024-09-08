import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/bloc/authentication.bloc.dart';
import 'package:flutter_app/shared/config/config.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constant/constant.export.dart';

part 'home.screen.dart';

part 'bottom_navigation.fragment.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return HomeScreen(_navigationShell);
  }
}
