import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:travel/core/generated/assets.gen.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/presentation/view/auth/sign_in/index.dart';

part 's_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
