import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/route.enum.dart';
import '../../../../core/enums/status.enum.dart';
import '../../../bloc/auth/auth.bloc.dart';
import '../../../bloc/auth/auth.event.dart';
import '../../../bloc/auth/auth.state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _logout(BuildContext context) => () {
        context.read<AuthBloc>().add(SignOut());
      };

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state.authStatus == AuthStatus.unAuthenticated) {
          debugPrint(state.toString());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('need to login again'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ));
          context.go(RoutePath.signIn.path);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("HOME"), actions: [
          Wrap(children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_none)),
            IconButton(
                onPressed: _logout(context),
                icon: const Icon(Icons.logout_outlined)),
          ])
        ]),
        body: SizedBox(),
      ));
}
