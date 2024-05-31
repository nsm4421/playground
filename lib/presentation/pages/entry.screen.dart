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

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱 전역에서 접근할 수 있는 Bloc
    return MultiBlocProvider(providers: [
      // 인증상태 Bloc
      BlocProvider(create: (context) => getIt<AuthCubit>()),
      BlocProvider(create: (context) => getIt<UserBloc>()..add(InitUserEvent()))
    ], child: const _View());
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
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
