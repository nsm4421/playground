import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/auth/auth.cubit.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/pages/auth/auth.screen.dart';
import 'package:my_app/presentation/pages/main/main.screen.dart';
import 'package:my_app/presentation/pages/on_board/on_board.screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late Stream<User?> _authStream;
  late StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authStream = context.read<AuthCubit>().authStream;
    _authSubscription = _authStream.listen((event) {
      if (event == null) {
        context.read<UserBloc>().add(SignOutEvent());
      } else {
        context.read<UserBloc>().add(SignInEvent(event));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: _authStream,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              // on error
              return const Center(child: Text("ERROR"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              // on loading
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              // not session user
              return const AuthScreen();
            } else {
              // on login
              return BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                if (state is OnBoardingState) {
                  return const OnBoardingScreen();
                } else if (state is UserLoadedState) {
                  return const MainScreen();
                }
                if (state is UserFailureState && state.message != null) {
                  log('user bloc 오류 발생 : ${state.message}');
                }
                return Scaffold(appBar: AppBar(title: const Text("ERROR")));
              });
            }
          }),
    );
  }
}
