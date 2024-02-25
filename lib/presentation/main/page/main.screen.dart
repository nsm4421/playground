import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth.bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth.event.dart';
import 'package:hot_place/presentation/main/page/home.screen.dart';
import 'package:hot_place/presentation/main/page/login.screen.dart';

import '../../../core/di/dependency_injection.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        // 앱 전역에서 인증상태 cubit에 접근
        create: (context) => getIt<AuthBloc>()..add(UpdateAuthEvent()),
        child: StreamBuilder<User?>(
            stream: getIt<AuthBloc>().currentUserStream,
            builder: (ctx, snapshot) {
              // 로딩중
              if (snapshot.connectionState != ConnectionState.active) {
                return const Center(child: CircularProgressIndicator());
              }
              // 유저 정보가 없는 경우 로그인 페이지로,
              // 유저 정보가 있는 경우 Home 화면으로
              return (snapshot.data == null)
                  ? const LoginScreen()
                  : const HomeScreen();
            }),
      );
}
