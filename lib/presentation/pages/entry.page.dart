import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/bloc/user/auth/auth.cubit.dart';
import 'package:my_app/presentation/bloc/user/account/account.bloc.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/pages/auth/auth.screen.dart';
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
  late StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    // TODO : auth stream 코드 수정하기
    // _authStream = context.read<AuthCubit>().authStream;
    _authSubscription = _authStream.listen((event) {
      if (event == null) {
        context.read<AccountBloc>().add(SignOutEvent());
      } else {
        context.read<AccountBloc>().add(SignInEvent(event));
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
              return BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                if (state is OnBoardingState) {
                  return const OnBoardingScreen();
                } else if (state is UserLoadedState) {
                  return const MainScreen();
                }
                if (state is UserFailureState && state.message != null) {
                  log('user bloc 오류 발생 : ${state.message}');
                }
                return const LoadingFragment();
              });
            }
          }),
    );
  }
}
