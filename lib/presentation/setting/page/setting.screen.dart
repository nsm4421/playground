import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:hot_place/presentation/setting/page/profile.widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTING"),
      ),
      body: Column(
        children: [ProfileWidget(context.read<AuthBloc>().currentUser!)],
      ),
    );
  }
}
