import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/shared.export.dart';

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
