import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/presentation/bloc/auth/authentication.bloc.dart';
import 'package:travel/presentation/widgets/widgets.dart';

import '../../route/router.dart';

part 'setting.screen.dart';

part 'display_profile.fragment.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen();
  }
}
