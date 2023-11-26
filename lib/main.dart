import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/theme/custom_theme_data.dart';
import 'package:my_app/presentation/main/main.screen.dart';
import 'package:my_app/presentation/pages/auth/auth.screen.dart';
import 'package:my_app/presentation/pages/splash/splash.screen.dart';
import 'core/constant/enums/routes.enum.dart';
import 'firebase_options.dart';
import 'dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies(); // 의존성 주입
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig,
        theme: CustomThemeData.themeData,
      );
}

final GoRouter routerConfig = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.auth.path,
      name: Routes.auth.name,
      builder: (_, __) => const AuthScreen(),
    ),
    GoRoute(
      path: Routes.main.path,
      name: Routes.main.name,
      builder: (_, __) => const MainScreen(),
    ),
  ],
);
