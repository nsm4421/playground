import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';

import '../../../core/route/router.dart';

part "setting.screen.dart";

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen();
  }
}
