import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/di/dependency_injection.dart';
import 'package:my_app/presentation/bloc/export.bloc.dart';
import 'package:my_app/presentation/router/router.dart';

import 'presentation/pages/export.pages.dart';

void main() async {
  configureDependencies(); // dependency injection

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>()..add(InitEvent()),
      child: MaterialApp.router(
        routerConfig: routerConfig,
        title: 'FullStackApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
      ),
    );
  }
}
