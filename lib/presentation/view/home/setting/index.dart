import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_setting.dart';
part 'f_profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen();
  }
}
