import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/constant.dart';

part 'f_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage(this._navigationShell, {super.key});

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: BottomNavigationFragment(_navigationShell),
    );
  }
}