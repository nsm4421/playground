import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';
import 'package:my_app/presentation/components/stream_builder.widget.dart';
import 'package:my_app/presentation/pages/auth/auth.screen.dart';
import 'package:my_app/presentation/pages/home/home.screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 앱 전역에서 접근할 수 있는 Bloc
    return MultiBlocProvider(providers: [
      // 인증상태 Bloc
      BlocProvider(create: (_) => getIt<AuthenticationBloc>())
    ], child: _View());
  }
}

class _View extends StatelessWidget {
  const _View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilderWidget<User?>(
          stream: context.read<AuthenticationBloc>().authStream,
          onSuccessWidgetBuilder: (u) =>
              u == null ? const AuthScreen() : const HomeScreen()),
    );
  }
}
