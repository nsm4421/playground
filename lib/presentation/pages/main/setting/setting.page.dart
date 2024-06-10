import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _handleSignOut() {
    context.read<UserBloc>().add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        actions: [
          IconButton(onPressed: _handleSignOut, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
