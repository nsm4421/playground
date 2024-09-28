import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'shared/config/di/dependency_injection.dart';
import 'presentation/route/router.dart';
import 'shared/style/theme/light_theme.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 불러오기
  await dotenv.load();

  // 의존성 주입
  configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: CustomLightTheme().theme,
        darkTheme: CustomDarkTheme().theme,
        routerConfig: getIt<CustomRoute>().routerConfig);
  }
}
