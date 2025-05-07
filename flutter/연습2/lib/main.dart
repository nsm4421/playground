import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/di/dependency_injection.dart';
import 'package:my_app/presentation/bloc/export.bloc.dart';
import 'package:my_app/presentation/router/router.dart';

void main() async {
  configureDependencies(); // dependency injection

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: MaterialApp.router(
        routerConfig: getIt<CustomRouter>().config,
        title: 'FullStackApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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
