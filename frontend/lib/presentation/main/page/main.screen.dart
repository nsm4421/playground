import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/auth/page/sign_in/sign_in.screen.dart';
import 'package:hot_place/presentation/main/page/on_login.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/bloc/auth.bloc.dart';
import '../../setting/bloc/user.bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription<AuthState> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<AuthBloc>().authStream.listen((authState) {
      // 세션 가져오기
      final sessionUser = authState.session?.user;

      // 로그인 되지 않은 경우, 인증상태 초기화
      if (sessionUser == null) {
        context.read<AuthBloc>().add(InitAuthEvent());
        return;
      }

      // 로그인 된 경우 인증상태 업데이트
      final currentUser = UserEntity.fromSession(sessionUser);
      context.read<AuthBloc>().add(UpdateCurrentUserEvent(currentUser));
    });

    // 인증상태 초기화
    context.read<UserBloc>().add(InitUserEvent());
    // last_seen_at 필드 업데이트
    context.read<UserBloc>().add(SignInEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthBloc, AuthenticationState>(
          builder: (_, state) => (state is AuthSuccessState)
              ? const OnLogInScreen()
              : const SignInScreen());
}
