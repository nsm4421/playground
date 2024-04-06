import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:hot_place/presentation/setting/page/profile.widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  _handleSignOut() {
    context.read<AuthBloc>().add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("SETTING"),
          actions: [
            IconButton(
                onPressed: _handleSignOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [ProfileWidget()],
        ),
      );
}
