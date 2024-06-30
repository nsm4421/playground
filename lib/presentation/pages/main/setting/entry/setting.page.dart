import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/components/user/avatar.widget.dart';

import '../../../../../core/constant/routes.dart';

part 'setting.screen.dart';

part 'profile.fragment.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen();
  }
}
