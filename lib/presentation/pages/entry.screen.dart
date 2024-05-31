import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/auth/auth.cubit.dart';
import 'package:my_app/presentation/pages/auth/auth.screen.dart';
import 'package:my_app/presentation/pages/main/main.screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱 전역에서 접근할 수 있는 Bloc
    return MultiBlocProvider(providers: [
      // 인증상태 Bloc
      BlocProvider(create: (context) => getIt<AuthCubit>())
    ], child: const _View());
  }
}

class _View extends StatelessWidget {
  const _View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: context.read<AuthCubit>().authStream,
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
              // TODO : Bloc Builder를 사용해 On boarding 페이지를 보여주거나, Home 화면을 보여주도록 수정
              return const MainScreen();
            }
          }),
    );
  }
}
