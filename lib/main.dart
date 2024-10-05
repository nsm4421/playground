import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/presentation/bloc/auth/authentication.bloc.dart';
import 'package:travel/presentation/bloc/bloc_module.dart';
import 'package:travel/presentation/route/router.dart';

import 'core/di/dependency_injection.dart';
import 'core/env/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey); // supabase client 초기화

  await Hive.initFlutter(); // 로컬 DB 초기화

  configureDependencies(); // 의존성 주입

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>().auth
        ..add(OnMountedEvent()), // 앱 전역에서 인증 bloc 접근 가능
      child: MaterialApp.router(
        title: 'Traveler',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              primary: Colors.blue,
              secondary: Colors.teal,
              tertiary: Colors.blueGrey),
          useMaterial3: true,
        ),
        routerConfig: routerConfig,
      ),
    );
  }
}
