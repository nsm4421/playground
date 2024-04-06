import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/auth/page/sign_in/sign_in.screen.dart';
import 'package:hot_place/presentation/main/page/on_login.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/bloc/auth.bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Stream<AuthState> _stream;
  late StreamSubscription<AuthState> _subscription;

  @override
  void initState() {
    super.initState();
    _stream = context.read<AuthBloc>().authStream;
    _subscription = _stream.listen((authState) {
      final sessionUser = authState.session?.user;
      if (sessionUser != null) {
        final currentUser = UserEntity.fromSession(sessionUser);
        context.read<AuthBloc>().add(UpdateCurrentUserEvent(currentUser));
      } else {
        context.read<AuthBloc>().add(InitAuthEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthBloc, AuthenticationState>(builder: (_, state) {
        if (state is AuthSuccessState) {
          return const OnLogInScreen();
        }
        return const SignInScreen();
      });
}



