import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/theme/theme.dart';

import 'core/di/dependency_injection.dart';
import 'core/env/env.dart';
import 'core/util/snackbar/snackbar.dart';
import 'presentation/route/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //     url: Env.supabaseUrl,
  //     anonKey: Env.supabaseAnonKey); // supabase client 초기화

  configureDependencies(); // 의존성 주입

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Traveler',
      theme: customThemeData,
      routerConfig: getIt<CustomRouter>().routerConfig,
      builder: (context, child) => Stack(
        children: [
          child!,
          SnackBarWidget(key: getIt<CustomSnackBar>().snackbarKey),
        ],
      ),
    );
  }
}
