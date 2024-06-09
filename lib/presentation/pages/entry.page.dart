import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/pages/auth/auth.page.dart';
import 'package:my_app/presentation/pages/main/main.screen.dart';
import 'package:my_app/presentation/pages/on_board/on_board.page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late Stream<User?> _authStream;
  late StreamSubscription<User?> _authStreamSubscription;

  @override
  void initState() {
    super.initState();
    _authStream = context.read<UserBloc>().authStream;
    _authStreamSubscription = _authStream.listen((data) {
      if (data != null) {
        context.read<UserBloc>().add(FetchAccountEvent(data));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UserBloc, UserState>(
            listenWhen: (prev, curr) =>
                (prev is NotAuthenticatedState) && (curr is OnBoardingState),
            listener: (BuildContext context, state) {
              if (state is OnBoardingState) {
                context
                    .read<UserBloc>()
                    .add(FetchAccountEvent(state.sessionUser));
              }
            },
            child: BlocBuilder<UserBloc, UserState>(
              builder: (BuildContext context, UserState state) {
                if (state is NotAuthenticatedState) {
                  return const AuthPage();
                } else if (state is OnBoardingState) {
                  return const OnBoardingScreen();
                } else if (state is UserLoadedState) {
                  return const MainScreen();
                } else if (state is UserLoadingState) {
                  return const LoadingFragment();
                } else {
                  return const ErrorFragment();
                }
              },
            )));
  }
}
