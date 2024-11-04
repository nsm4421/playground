import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';

import '../../../core/constant/constant.dart';
import '../../../core/generated/assets.gen.dart';
import '../../../core/theme/theme.dart';
import '../../route/routes.dart';
import 'sign_in/index.dart';

part 's_home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
